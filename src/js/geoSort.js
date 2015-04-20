var L = require('leaflet');

/**
 * Sorts geojson points in items by distance to crds
 *
 * @param crds - lat long in array or L.latLng object. Items are sorted by distance to this
 * @param items - array of items to be sorted. Each item should an object with a geometry.coordinates member.
 *
 */
function geoSort(crds, items){
    origin = L.latLng(crds);
    return items.sort(function(a,b){
        return origin.distanceTo(a.geometry.coordinates) - origin.distanceTo(b.geometry.coordinates);
    });
}

module.exports = geoSort;
