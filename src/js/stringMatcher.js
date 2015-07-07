function Matcher(tags){
    /**
     * Accepts a list of strings. Returns a class that will tell you the 
     * first matching string in another string or return a default.
     *
     */

    if (typeof defaultString === 'undefined') defaultString = 'default';
    this._tags = tags.map(function(t){ return t.toLowerCase(); });
}

Matcher.prototype = {
    firstMatch: function(tags){
        // returns the first match from tags.
        tags = tags.toLowerCase();
        for(var i=0, tag, l=this._tags.length; i<l, tag=this._tags[i]; i++){
            if (tags.indexOf(tag) !== -1){return tag;}
        }
        return false;
    }
}

module.exports=Matcher;
