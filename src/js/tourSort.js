var L = require('leaflet');


function tourSort(items){
    return items.sort(function(a,b){
        return regex(a) > regex(b);
    });
}

function regex(item){
	return parseInt(item.tags.match(RegExp("tour(\\d+)"))[1]);
	console.log(item.tags.match(RegExp("tour\\d+"))[0]);
}


module.exports = tourSort;