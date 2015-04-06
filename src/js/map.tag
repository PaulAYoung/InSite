<map>
    <div name="mapArea" class="mapArea" if={ this.display }></div>

    <script>
        // scripts
        this.display=false;
        var L = require('leaflet');

        var controller = opts.controller;
        var self = this;
        
        this.on('mount', function(e){
            this.map = new L.Map(this.mapArea);
            var accessToken = 'pk.eyJ1IjoiYXJkbmFzZWVsIiwiYSI6IkNpTXlHU0UifQ.M20m1nJ01_0olbOTdPJ1oQ'
            var mapboxTiles = L.tileLayer('https://{s}.tiles.mapbox.com/v4/ardnaseel.kfgj3f5l/{z}/{x}/{y}.png?access_token='+ accessToken);
            this.map
                .addLayer(mapboxTiles)
                .setView([37.8899, -122.324721], 15 );

        });
        
        controller.on('ActivateView', function(title){
            self.display = (title=='Map');
            self.update();
            self.map.invalidateSize();
        });
    </script>

</map>
