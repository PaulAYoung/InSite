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
        var test_latlng = L.latLng(37.890218, -122.315228); //this latlng is within the bulb radius

        self.mapMarkers = [];
        
        this.on('mount', function(e){
            self.map = new L.Map(self.mapArea);
            var accessToken = 'pk.eyJ1IjoiYXJkbmFzZWVsIiwiYSI6IkNpTXlHU0UifQ.M20m1nJ01_0olbOTdPJ1oQ'
            var mapboxTiles = L.tileLayer('https://{s}.tiles.mapbox.com/v4/ardnaseel.kfgj3f5l/{z}/{x}/{y}.png?access_token='+ accessToken);
            
            self.map
                .addLayer(mapboxTiles)
                .setView([37.8899, -122.324721], 15 );

            self.update();
            self.map.invalidateSize();

            //only set map view to user location if user is located is in within 1416 meters of the Albany Bulb.
        });

        controller.on("LocationError", function(err){
          console.warn('ERROR(' + err.code + '): ' + err.message);
        });

        controller.on("LocationUpdated", function(pos){
            console.log("location updated");
            if (user_marker){
                self.map.removeLayer(location_circle);
            }
            var crd = pos.coords;  
            var radius = crd.accuracy / 2;
            var user_location = L.latLng(crd.latitude,crd.longitude);
            var location_circle = L.circle(user_location, radius).addTo(self.map);
            user_marker = true;
            var distance_to_bulb = bulb_latlng.distanceTo(user_location);

            function setView_by_location(distance_to_bulb, user_location){
               if (distance_to_bulb <= 1416){
                    return user_location;
                }
                else{
                    return bulb_latlng;
                }
            }
           
            self.map.setView(setView_by_location(distance_to_bulb, user_location), 15);
          
          console.log('Your current position is:');
          console.log('Latitude : ' + crd.latitude);
          console.log('Longitude: ' + crd.longitude);
          console.log('More or less ' + crd.accuracy + ' meters.');
          console.log("distance to bulb: "+ distance_to_bulb+"m");
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
