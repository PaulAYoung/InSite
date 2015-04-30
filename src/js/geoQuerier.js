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
      maximumAge: 10000
    };
    
    this._controller.on("StartApp", function(){
        navigator.geolocation.watchPosition(
                self._success.bind(self),
                self._error.bind(self),
                options);
    });
}

GeoQuerier.prototype = {
    _success: function(pos){

        var lat = pos.coords.latitude;
        var lon = pos.coords.longitude;

        if (
            this._controller.loc === null ||
            this._controller.loc.lat !== lat||
            this._controller.loc.lon !== lon
        ){
            this._controller.trigger("LocationUpdated", pos);
        }
    },
    _error: function(err){
        this._controller.trigger("LocationError", err);
    }
};

module.exports = GeoQuerier;
