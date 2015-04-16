// understands how to filter a dataset
function DataFilter(data){
    this._data = data;
}

DataFilter.prototype = {
    filter: function(filter){
        out = [];
        for (var i=0; i< this._data.length; i++){
            if (this._data[i].tags.indexOf(filter) !== -1 ||
                this._data[i].name.indexOf(filter) !== -1
                    ){
                out.push(this._data[i]);
            }
        }
        return out;
    },
    geoFilter: function(geom){
        return this._data;
    }

};

module.exports = DataFilter
