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
    addAll: function(items){
        for (var i=0; i<items.length; i++){
            this._set[items[i]] = true;
        }
    },
    items: function(){
        return Object.keys(this._set);
    }
}

module.exports = SimpleSet;
