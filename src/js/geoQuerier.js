/**
 * Broadcasts location updates through controller.
 *
 */
function GeoQuerier(opts){
    this._controller = opts.controller;
    
    var options = {
      enableHighAccuracy: true,
      timeout: 5000,
      maximumAge: 0
    };
    
    navigator.geolocation.watchPosition(
            this._success.bind(this),
            this._error.bind(this),
            options);
}

GeoQuerier.prototype = {
    _success: function(pos){
        this._controller.trigger("LocationUpdated", pos);
    },
    _error: function(err){
        this._controller.trigger("LocationError", err);
    }
};

module.exports = GeoQuerier;
