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
     * Returns true if all items are in set
     *
     * @param - items - set or array of items to be checked
     *
     */
    containsAll: function(items){
        items = getItems(items);
        for (var i=0, l=items.length; i<l; i++){
            if (!this.contains(items[i])){ return false; }
        }
        return true;
    },
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
        items = getItems(items);
        for (var i=0, l=items.length; i<l; i++){
            this.add(items[i]);
        }
    },
    /**
     * Removes all given items from set
     *
     * @param - items - array or set of items to remove.
     *
     */
    removeAll: function(items){
        items = getItems(items);
        for (var i=0, l=items.length; i<l; i++){
            this.remove(items[i]);
        }
    },
    /**
     * Returns array of items in set
     */
    items: function(){
        return Object.keys(this._set);
    }
}

function getItems(items){
        if (items instanceof SimpleSet){return items.items();}
        else { return items }
}

module.exports = SimpleSet;
