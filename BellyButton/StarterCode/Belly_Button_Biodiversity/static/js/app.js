function buildMetadata(sample) {

  var metaurl = `/metadata/${sample}`;

    d3.json(metaurl).then(function(sample){
      var sampleData = d3.select(`#sample-metadata`);

      sampleData.html("");

      Object.entries(sample).forEach(function([key,value]){
        var row = sampleData.append("p");
        row.text(`${key}:${value}`)
      })
    });
}

function buildCharts(sample) {

  var url = `/samples/${sample}`;
  
  d3.json(url).then(function(data){

    console.log(data)
    
    var values = data.sample_values.slice(0,10);
    var labels = data.otu_ids.slice(0,10);
    var hover = data.otu_labels.slice(0,10);

    var pie = [{
      values: values,
      labels: labels,
      hovertext: hover,
      type: "pie"
    }];

    var layout = {
      margin: {t:0,l:0}
    }
    Plotly.newPlot('pie',pie,layout);

  });

  d3.json(url).then(function(data){
    var x_axis = data.otu_ids
    var y_axis = data.sample_values
    var size = data.sample_values
    var color = data.otu_ids
    var texts = data.otu_labels

    var bubble = {
      x: x_axis,
      y:y_axis,
      text: texts,
      mode : 'markers',
      marker: {
        size:size,
        color: color
      }

    var layout = {
      title: "Belly Button Bacteria"
      xaxis : {title: "OTU ID"}
    }
  });

    Plotly.newPlot("bubble",bubble,layout)
}

function init() {
  // Grab a reference to the dropdown select element
  var selector = d3.select("#selDataset");

  // Use the list of sample names to populate the select options
  d3.json("/names").then((sampleNames) => {
    sampleNames.forEach((sample) => {
      selector
        .append("option")
        .text(sample)
        .property("value", sample);
    });

    // Use the first sample from the list to build the initial plots
    const firstSample = sampleNames[0];
    buildCharts(firstSample);
    buildMetadata(firstSample);
  });
}

function optionChanged(newSample) {
  // Fetch new data each time a new sample is selected
  buildCharts(newSample);
  buildMetadata(newSample);
}

// Initialize the dashboard
init();
