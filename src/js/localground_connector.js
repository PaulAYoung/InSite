var $ = require('jquery');

function LGConnector(opts){
    /**
     * Understands a local ground data source.
     * See localground.org for more info
     *
     * opts-object with configuration options:
     *  url - base url of data source. ex: http://insite.localground.org/api/0/
     *  controller - event management object - see https://muut.com/riotjs/guide/#observable
     *
     */
    this._url = opts.url;
    this._controller = opts.controller;

    var boundGet = this._get.bind(this);

    this._controller.on("UpdateItems", boundGet);
    this._controller.on("StartApp", boundGet);
}

LGConnector.prototype = {
    _get: function(query){
        // TODO: process query arg
        $.getJSON(this._url, this._success.bind(this), this._failure.bind(this));

    },
    _success: function(data){
        // pull out geoJSON from data.
        var processedData = data.children.markers.data.concat(
            data.children.photos.data,
            data.children.audio.data
            );
        this._controller.trigger("ItemsUpdated", processedData);
    },
    _failure: function(err){
        this._controller.trigger("ErrorGettingData", err);
    }
}

module.exports = LGConnector;
