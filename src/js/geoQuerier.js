/**
 * Broadcasts location updates through controller.
 *
 */
function GeoQuerier(opts){
    this._controller = opts.controller;
    var self = this;
    
    var options = {
      enableHighAccuracy: true,
      timeout: 5000,
      maximumAge: 0
    };
    
    console.log("setting watch");
    this._controller.on("StartApp", function(){
        navigator.geolocation.watchPosition(
                self._success.bind(self),
                self._error.bind(self),
                options);
    });
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
