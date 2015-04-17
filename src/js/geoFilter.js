var L = require('leaflet');

function geoFilter(crds, items, max_distance){
    var out = [];
    var point = L.latLng(crds);

    for (var i=0;i<items.length;i++){
        var itemPoint = L.latLng(items[i].geometry.coordinates);
        if (point.distanceTo(itemPoint) <= max_distance) out.push(items[i]);
    }
    return out;
}

module.exports = geoFilter;
