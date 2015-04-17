var riot = require('riot');
var DataFilter = require('./dataFilter');

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
    var self = this;

    riot.route(this._router.bind(this));

    this.on('ItemsLoaded', this._processItems.bind(this));

    this.one('StartApp', function(){
        riot.route.exec(self._router.bind(self));
    });

    this.on('UpdateFilter', function(filter){
        self._filterItems(filter);
    });
}

Controller.prototype = {
    _filterItems: function(filter){
        this._filter = filter;
        this.itemList = this._filterer.filter(filter);

        var m;
        var markers = new Set(this.itemList.map(function(i){
            return i.marker;
        }));

        this.markers = [];

        for (m of markers){
            this.markers.push(this.itemDict[m])
        }

        this.trigger("ItemsUpdated", this.itemList);
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
        this.itemDict = itemDict;

        // adds marker to each item, should also modify itemList since references are the same
        for (marker in markerMap){
            associated = markerMap[marker];
            for (i=0;i<associated.length;i++){
                itemDict[associated[i]].marker = marker;
            }
        }


        this._filterItems(this._filter);
    },
    _router: function(){
        // routes should be in format view/filter1/filter2/etc ex: map/sites/nature
        // or view/collection/id ex: list/people/12
        //
        // this makes an array with 'ActivateView' as first arg, and arguments as added on

        args = ['ActivateView'].concat(Array.prototype.slice.call(arguments));
        console.log(args);
        if (args[1] === ""){ args[1] = 'Map';}
        console.log(args);
        this.trigger.apply(this, args);
    }
};

module.exports = Controller;
