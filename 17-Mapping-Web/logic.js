var earthquakeURL = "https://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/all_week.geojson";

d3.json(earthquakeURL,function(data){
  createFeatures(data.features)
})

// Creating map object
function createMap(earthquakes){
// Adding tile layer
  lightmap = L.tileLayer("https://api.tiles.mapbox.com/v4/{id}/{z}/{x}/{y}.png?access_token={accessToken}", {
    attribution: "Map data &copy; <a href=\"https://www.openstreetmap.org/\">OpenStreetMap</a> contributors, <a href=\"https://creativecommons.org/licenses/by-sa/2.0/\">CC-BY-SA</a>, Imagery © <a href=\"https://www.mapbox.com/\">Mapbox</a>",
    maxZoom: 18,
    id: "mapbox.light",
    accessToken: API_KEY
  });
  

  var overlayMaps = {
    "Earthquakes": earthquakes
  };

  var baseMaps = {
    "Light Map" : lightmap
  };

  var myMap = L.map("map", { 
    center: [39, -95],
    zoom: 5,
    layers: [lightmap, earthquakes]
  });

  L.control.layers(baseMaps,overlayMaps,{
    collapsed: false
  }).addTo(myMap);
}

function createFeatures(earthquakeData) {
  var earthquakes = L.geoJson(earthquakeData, {
    onEachFeature: function(feature,layer){
      layer.bindPopup(feature.properties.title)
    },
    pointToLayer: function(feature,latlng){
      return L.circle(latlng,
        {radius: (feature.properties.mag)*20000,
        fillColor: "green",
        fillOpacity: 0.6,
        color: "white",
        stroke: true,
        weight: .8
        })
    }
  })
  createMap(earthquakes)
}
