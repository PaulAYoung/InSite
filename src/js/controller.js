var riot = require('riot');

function Controller(){
    /**
     * Communicates between app parts and holds data.
     *
     */

    //make observable
    riot.observable(this);
    this.itemDict = null;
    this.itemList = null;

    riot.route(this._router.bind(this));

    this.on('ItemsUpdated', this._processItems.bind(this));

    this.one('StartApp', function(){
        console.log('started');
        riot.route.exec(this._router.bind(this));
    }.bind(this));
}

Controller.prototype = {
    _processItems: function(items){
        var itemDict = {};
        this.itemList = items;
        for (i = 0; i<items.length; i++){
            item = items[i];
            itemDict[item.overlay_type + item.id] = item;
        }
        this.itemDict = itemDict;
    },
    _router: function(){
        // routes should be in format view/filter1/filter2/etc ex: map/sites/nature
        // or view/collection/id ex: list/people/12
        //
        // this makes an array with 'ActivateView' as first arg, and arguments as added on
        args = ['ActivateView'].concat(Array.prototype.slice.call(arguments));
        if (args.length === 1){ args.push('Map');}
        this.trigger.apply(this, args);
    }
};

module.exports = Controller;
