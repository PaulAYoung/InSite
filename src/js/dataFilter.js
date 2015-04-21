// understands how to filter a dataset
function DataFilter(data){
    this._data = data;
}

DataFilter.prototype = {
    filter: function(filter){
        out = [];
        filter = filter.toLowerCase();
        for (var i=0; i< this._data.length; i++){
            if (this._data[i].tags.toLowerCase().indexOf(filter) !== -1 ||
                this._data[i].name.toLowerCase().indexOf(filter) !== -1
                    ){
                out.push(this._data[i]);
            }
        }
        return out;
    },
};

module.exports = DataFilter
