<map>
    <div name="mapArea" class="mapArea" if={ this.display }></div>

    <script>
        // scripts
        this.display=false;
        var L = require('leaflet');
        L.Icon.Default.imagePath = 'leaflet_images/'
        var $ = require('jquery');
        var controller = opts.controller;
        var self = this;
        var user_marker = false;
        var bulb_latlng = L.latLng(37.8899, -122.324721);
        var test_latlng = L.latLng(37.890218, -122.315228);

        self.mapMarkers = [];
        
        this.on('mount', function(e){
            this.map = new L.Map(this.mapArea);
            var accessToken = 'pk.eyJ1IjoiYXJkbmFzZWVsIiwiYSI6IkNpTXlHU0UifQ.M20m1nJ01_0olbOTdPJ1oQ'
            var mapboxTiles = L.tileLayer('https://{s}.tiles.mapbox.com/v4/ardnaseel.kfgj3f5l/{z}/{x}/{y}.png?access_token='+ accessToken);
            this.map
                .addLayer(mapboxTiles)
                // .setView(bulb_latlng, 15 );

            var options = {
              enableHighAccuracy: true,
              timeout: 5000,
              maximumAge: 0
            };
            function success(pos) {
                if (user_marker){
                    self.map.removeLayer(location_circle);
                }
                var crd = pos.coords;  
                var radius = crd.accuracy / 2;
                var user_location = L.latLng(crd.latitude,crd.longitude);
                var location_circle = L.circle(user_location, radius).addTo(self.map);
                user_marker = true;
                distance_to_bulb = bulb_latlng.distanceTo(user_location);
              console.log('Your current position is:');
              console.log('Latitude : ' + crd.latitude);
              console.log('Longitude: ' + crd.longitude);
              console.log('More or less ' + crd.accuracy + ' meters.');
              console.log("distance to bulb: "+ distance_to_bulb+"m");

              //only set map view if location is in within radius of 
                if (distance_to_bulb <= 1416){
                    self.map.setView(user_location, 15);
                }
                else{
                    self.map.setView(bulb_latlng, 15);
                }

            };
            function error(err) {
              console.warn('ERROR(' + err.code + '): ' + err.message);
            };
            navigator.geolocation.watchPosition(success, error, options);

            

        });
        
        controller.on('ActivateView', function(title){
            self.display = (title=='Map');
            self.update();
            self.map.invalidateSize();
        });

        controller.on('ItemsUpdated', function(item){
            self.clearMarkers();
            
            var markers = controller.markers;
            var mark;
            $.each(markers, function(index, value){
                mark = L.marker([value.geometry.coordinates[1],value.geometry.coordinates[0]]).bindPopup(value.name+'<br>'+value.description).addTo(self.map);
                self.mapMarkers.push(mark);
            });
            //refer to self.map 
        });
        
        clearMarkers(){
            var mark;
            while (self.mapMarkers.length > 0){
                mark = self.mapMarkers.pop();
                self.map.removeLayer(mark);
            }
        }


    </script>

</map>
