var regions = { "SAS": "South Asia" , "ECS": "Europe and Central Asia", "MEA": "Middle East & North Africa", "SSF": "Sub-Saharan Africa", "LCN": "Latin America & Caribbean", "EAS": "East Asia &amp; Pacific", "NAC": "North America" },
	w = 925,
	h = 500,
	margin = 40,
    startYear =1, 
	endYear = 342,
	startAge = 1,
	endAge = 45000,
	y = d3.scale.linear().domain([endAge, startAge]).range([0 + margin, h - margin]),
	x = d3.scale.linear().domain([1, 341]).range([0 + margin -5, w]),
	years = d3.range(startYear, endYear);

var vis = d3.select("#vis")
    .append("svg:svg")
    .attr("width", w)
    .attr("height", h)
    .append("svg:g");
			
var line = d3.svg.line()
    .interpolate("basis")  
    .x(function(d,i) { return x(d.x); })
    .y(function(d) { return y(d.y); });
					

// Regions
var countries_regions = {};
d3.text('./data/country-regions.csv', 'text/csv', function(text) {
    var regions = d3.csv.parseRows(text);
    for (i=1; i < regions.length; i++) {
        countries_regions[regions[i][0]] = regions[i][1];
    }
});

var startEnd = {},
    countryCodes = {};
d3.text('./data/graph2_cleaned.csv', 'text/csv', function(text) {
    var countries = d3.csv.parseRows(text);
    
    for (i=1; i < countries.length; i++) {
        var values = countries[i].slice(2, countries[i.length-1]);
        var currData = [];
        countryCodes[countries[i][1]] = countries[i][0];
        
        var started = false;
        for (j=0; j < values.length; j++) {
            if (values[j] != '') {
                currData.push({ x: years[j], y: values[j] });
            
                if (!started) {
                    startEnd[countries[i][1]] = { 'startYear':years[j], 'startVal':values[j] };
                    started = true;
                } else if (j == values.length-1) {
                    startEnd[countries[i][1]]['endYear'] = years[j];
                    startEnd[countries[i][1]]['endVal'] = values[j];
                }
                
            }
        }
        console.log(currData)

        // Actual line
        vis.append("svg:path")
            .data([currData])
            .attr("country", countries[i][1])
            .attr("class", countries_regions[countries[i][1]])
            .attr("d", line)
            .on("mouseover", onmouseover)
            .on("mouseout", onmouseout);
    }
});  
    

vis.append("svg:line")
    .attr("x1", x(startYear))
    .attr("y1", y(startAge))
    .attr("x2", x(endYear))
    .attr("y2", y(startAge))
    .attr("class", "axis")

vis.append("svg:line")
    .attr("x1", x(startYear))
    .attr("y1", y(startAge))
    .attr("x2", x(startYear))
    .attr("y2", y(endAge))
    .attr("class", "axis")
			
vis.selectAll(".xLabel")
    .data(x.ticks(4))
    .enter().append("svg:text")
    .attr("class", "xLabel")
    .text(function(String) { return Math.abs(String - 350) + ' days ago'; })
    .attr("x", function(d) { return x(d) })
    .attr("y", h-5)
    .attr("text-anchor", "middle")

vis.selectAll(".yLabel")
    .data(y.ticks(5))
    .enter().append("svg:text")
    .attr("class", "yLabel")
    .text(String)
	.attr("x", 0)
	.attr("y", function(d) { return y(d) })
	.attr("text-anchor", "right")
	.attr("dy", 2)
			
vis.selectAll(".xTicks")
    .data(x.ticks(4))
    .enter().append("svg:line")
    .attr("class", "xTicks")
    .attr("x1", function(d) { return x(d); })
    .attr("y1", y(startAge))
    .attr("x2", function(d) { return x(d); })
    .attr("y2", y(startAge)+7)
	
vis.selectAll(".yTicks")
    .data(y.ticks(5))
    .enter().append("svg:line")
    .attr("class", "yTicks")
    .attr("y1", function(d) { return y(d); })
    .attr("x1", x(startYear-0.5))
    .attr("y2", function(d) { return y(d); })
    .attr("x2", x(startYear))

function onclick(d, i) {
    var currClass = d3.select(this).attr("class");
    if (d3.select(this).classed('selected')) {
        d3.select(this).attr("class", currClass.substring(0, currClass.length-9));
    } else {
        d3.select(this).classed('selected', true);
    }
}

function onmouseover(d, i) {
    var currClass = d3.select(this).attr("class");
    d3.select(this)
        .attr("class", currClass + " current");
    
    var countryCode = $(this).attr("country");
    var countryVals = startEnd[countryCode];
    
    var blurb = '<h2>' + countryCodes[countryCode] + '</h2>';
    blurb += "<p>Current speed: " + Math.round(countryVals['endVal']) + " doses / 100K. ";
    blurb += "</p>";
    
    $("#default-blurb").hide();
    $("#blurb-content").html(blurb);
}
function onmouseout(d, i) {
    var currClass = d3.select(this).attr("class");
    var prevClass = currClass.substring(0, currClass.length-8);
    d3.select(this)
        .attr("class", prevClass);
    // $("#blurb").text("hi again");
    $("#default-blurb").show();
    $("#blurb-content").html('');
}

function showRegion(regionCode) {
    var countries = d3.selectAll("path."+regionCode);
    if (countries.classed('highlight')) {
        countries.attr("class", regionCode);
    } else {
        countries.classed('highlight', true);
    }
}

$(document).ready(function() {
    $('#filters a').click(function() {
        var countryId = $(this).attr("id");
        $(this).toggleClass(countryId);
        showRegion(countryId);
    });
    
});
