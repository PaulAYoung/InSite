<map>
    <div name="mapArea" class="mapArea" if={ this.display }></div>

    <script>
        // scripts
        this.display=false;
        var L = require('leaflet');

        controller = opts.controller;
        var self = this;
        
        this.on('mount', function(e){
            this.map = new L.Map(this.mapArea);
            
            var osmUrl = 'http://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png';
            var osmAttrib = 'Map data © OpenStreetMap contributors';
            var osm = new L.TileLayer(osmUrl, { attribution: osmAttrib });

            this.map.setView(new L.LatLng(43.069452, -89.411373), 11);

            this.map.addLayer(osm);
        });
        
        controller.on('activate', function(title){
            self.display = (title=='Map');
            self.update();
            self.map.invalidateSize();
        });
    </script>

</map>
