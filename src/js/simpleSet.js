/**
 * Understands a set of items
 *
 * Implimenting this since IE does not have the native set object yet.
 *
 */
function SimpleSet(items){
    this._set = {};
    if (typeof items !== 'undefined')this.addAll(items);
};

SimpleSet.prototype = {
    /**
     * Returns true if given item is contained in set
     *
     * @param - item - item to be checked
     */
    contains: function(item){return item in this._set;},
    /**
     * Adds a single item to set
     *
     * @param - item - item to be added
     *
     */
    add: function(item){
        this._set[item] = true;
    },
    /**
     * Removes a single item from set
     *
     * @param - item - item to be removed
     *
     */
    remove: function(item){
        delete this._set[item];
    },
    /**
     * Adds all items in passed array or set
     *
     * @param - items - array or set of items to add.
     *
     */
    addAll: function(items){
        if (items instanceof SimpleSet){items = items.items();}
        for (var i=0; i<items.length; i++){
            this.add(items[i]);
        }
    },
    /**
     * Returns array of items in set
     */
    items: function(){
        return Object.keys(this._set);
    }
}

module.exports = SimpleSet;
