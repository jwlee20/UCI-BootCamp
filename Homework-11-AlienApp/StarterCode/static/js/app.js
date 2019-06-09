// from data.js
var tableData = data;

// YOUR CODE HERE!
console.log(data)

var tbody = d3.select("tbody");

function displayData(data){
	data.forEach((ufoSightings) => {
	var row = tbody.append("tr")
	Object.entries(ufoSightings).forEach(([key,value]) => {
		var cell = row.append("td");
		cell.text(value);
	})
})}

var button = d3.select("#filter-btn");
var input = d3.select("#datetime")

function handleChange(){
	d3.event.preventDefault();
	var inputValue = input.property("value")
	console.log(inputValue)
	var new_tableData = tableData.filter(ufoSightings => ufoSightings.datetime === inputValue)
	displayData(new_tableData)
	console.log(new_tableData)

}


button.on("click",handleChange);