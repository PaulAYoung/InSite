//Sorts an array based on its the number after a specified tag, ex. [tour2, tour3, tour1] should be sorted [tour1, tour2, tour3]

var L = require('leaflet');

function tourSort(items, base){
    return items.sort(function(a,b){
        return regex(a, base) > regex(b, base);
    });
}

function regex(item, base){
	return parseInt(item.tags.match(RegExp(base+"(\\d+)"))[1]);
}

module.exports = tourSort;
