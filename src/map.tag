<map>
    <div name="mapArea" class="mapArea"></div>

    // scripts
    var L = require('leaflet');
    
    this.on('mount', function(e){
        this.map = new L.Map(this.mapArea);
        
        var osmUrl = 'http://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png';
        var osmAttrib = 'Map data © OpenStreetMap contributors';
        var osm = new L.TileLayer(osmUrl, { attribution: osmAttrib });

        this.map.locate({setView: true});
        
        this.map.addLayer(osm);
        this.map.invalidateSize()
    });

</map>
