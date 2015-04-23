var riot = require('riot');
var DataFilter = require('./dataFilter');
var geoSort = require('./geoSort.js');
var SimpleSet = require('./simpleSet');


function Controller(){
    /**
     * Communicates between app parts and holds data.
     *
     */

    //make observable
    riot.observable(this);
    this.itemDict = null;
    this.itemList = null;
    this.markers = null;
    this._filterer = new DataFilter();
    this._filter = "";
    this.loc = null;
    var self = this;

    riot.route(this._router.bind(this));

    this.on('ItemsLoaded', function(items){
        self._processItems(items)
        self.trigger("ItemsUpdated", this.itemList);
    });

    this.one('StartApp', function(){
        riot.route.exec(self._router.bind(self));
    });

    this.on('UpdateFilter', function(filter){
        self._filterItems(filter);
        self.trigger("ItemsUpdated", this.itemList);
    });

    this.on('LocationUpdated', function(pos){
        var lat = pos.coords.latitude;
        var lon = pos.coords.longitude;
        if (
            self.loc === null ||
            self.loc.lat !== lat||
            self.loc.lon !== lon
        ){
                self.loc = {lat: lat, lon:lon};
                self._geoSort();
                self.trigger("ItemsUpdated", this.itemList);
        }
    });
}

Controller.prototype = {
    _filterItems: function(filter){
        this._filter = filter;
        this.itemList = this._filterer.filter(filter);

        var markers = new SimpleSet(this.itemList.map(function(i){
            return i.marker;
        }));

        
        this.markers = [];

        var items = markers.items();

        for (var i=0, m, l = items.length;i<l, m=items[i]; i++){
            this.markers.push(this.itemDict[m])
        }

        if (this.loc !== null){this._geoSort();}
    },
    _geoSort: function(){
        if (this.markers !== null){
            this.markers = geoSort(this.loc, this.markers);
        }
    },
    _processItems: function(items){
        var itemDict = {};
        var markerMap = {};

        this._filterer = new DataFilter(items);
        this.itemList = items;

        var key, associated, i;

        for (i = 0; i<items.length; i++){
            item = items[i];
            key = item.overlay_type + item.id;
            itemDict[item.overlay_type + item.id] = item;

            // map items to containing markers
            if (item.overlay_type === 'marker'){
                associated = [key];
                if (item.photo_array !== null){
                    associated.push.apply(associated, item.photo_array.map(function(i){return "photo" + i}));
                }
                if (item.audio_array !== null){
                    associated.push.apply(associated, item.audio_array.map(function(i){return "audio" + i}));
                }

                markerMap[key]=associated;
            }
        }

        // adds marker to each item, should also modify itemList since references are the same
        for (marker in markerMap){
            associated = markerMap[marker];
            for (i=0;i<associated.length;i++){
                itemDict[associated[i]].marker = marker;
            }
        }


        this.itemDict = itemDict;
        this._filterItems(this._filter);
    },
    _router: function(){
        // routes should be in format view/filter1/filter2/etc ex: map/sites/nature
        // or view/collection/id ex: list/people/12
        //
        // this makes an array with 'ActivateView' as first arg, and arguments as added on

        args = ['ActivateView'].concat(Array.prototype.slice.call(arguments));
        if (args[1] === ""){ args[1] = 'Map';}
        this.trigger.apply(this, args);
    }
};

module.exports = Controller;
