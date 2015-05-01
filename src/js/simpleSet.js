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
    contains: function(item){return item in this._set;},
    add: function(item){
        this._set[item] = true;
    },
    addAll: function(items){
        for (var i=0; i<items.length; i++){
            this.add(items[i]);
        }
    },
    items: function(){
        return Object.keys(this._set);
    }
}

module.exports = SimpleSet;
