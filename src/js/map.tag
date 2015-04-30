<map>
    <div name="mapArea" class="mapArea" if={ this.display }></div>
    <div onclick={ this.updateTour } if={ this.tourDisplay } style="position:fixed;color:white;right:0px;top:470px">
        <span>Next Tour Stop</span>
        <span class="glyphicon glyphicon-chevron-right" ></span>
    </div>
    <script>
        // scripts
        this.display=false;
        this.tourDisplay=false;
        var L = require('leaflet');
        L.Icon.Default.imagePath = 'leaflet_images/'
        var $ = require('jquery');
        var controller = opts.controller;
        var self = this;
        var user_marker = false;
        var bulb_latlng = L.latLng(37.8899, -122.324721);
        var test_latlng = L.latLng(37.890218, -122.315228); //this latlng is within the bulb radius
        var setViewbyLocation = require('./setViewbyLocation');

        self.mapMarkers = [];
        self.userMarker = null;
        
        this.on('mount', function(e){
            self.map = new L.Map(self.mapArea);
            var accessToken = 'pk.eyJ1IjoiYXJkbmFzZWVsIiwiYSI6IkNpTXlHU0UifQ.M20m1nJ01_0olbOTdPJ1oQ'
            var mapboxTiles = L.tileLayer('https://{s}.tiles.mapbox.com/v4/ardnaseel.kfgj3f5l/{z}/{x}/{y}.png?access_token='+ accessToken);
            
            self.map
                .addLayer(mapboxTiles)
                .setView(bulb_latlng, 16 );

            self.update();
            self.map.invalidateSize();
        });

        controller.on("LocationError", function(err){
          console.warn('ERROR(' + err.code + '): ' + err.message);
        });

        controller.on("LocationUpdated", function(pos){

            if (self.userMarker){
                self.map.removeLayer(self.userMarker);
            }
            var crd = pos.coords;  
            var radius = crd.accuracy / 2;
            var user_location = L.latLng(crd.latitude,crd.longitude);
            self.userMarker = L.circle(user_location, radius).addTo(self.map);
            var distance_to_bulb = bulb_latlng.distanceTo(user_location);
           
            // self.map.setView(setViewbyLocation(1416, user_location, bulb_latlng), 16);
          
          console.log('Your current position is:');
          console.log('Latitude : ' + crd.latitude);
          console.log('Longitude: ' + crd.longitude);
          console.log('More or less ' + crd.accuracy + ' meters.');
          console.log("distance to bulb: "+ distance_to_bulb+"m");
        });

        controller.on("LocateMe", function(){
            self.map.setView(L.latLng(controller.loc.lat, controller.loc.lon), 18);
        });

        controller.on('StartTour', function(index){
            self.tourDisplay = true;
            self.update()
            self.setMapViewbyTourIndex(index);
            window.tourIndex=index+1;
            window.tourLength=controller.markers.length;
        });

        setMapViewbyTourIndex(index){
            self.map.setView(L.latLng(controller.markers[index].geometry.coordinates[1],controller.markers[index].geometry.coordinates[0]), 18);
            if (window.tourIndex<window.tourLength){
                window.tourIndex++;
            }
        }

        updateTour(){
            self.setMapViewbyTourIndex(window.tourIndex);
        }
        
        controller.on('ActivateView', function(title){
            self.display = (title=='Map');
            self.update();
            self.map.invalidateSize();
        });

        controller.on('ItemsUpdated', function(item){
            self.clearMarkers();
            var markers = controller.markers;
            if (markers === null) { markers = []; }
            var mark;
            $.each(markers, function(index, value){
                if (typeof value !== "undefined"){
                    if (value.tags.indexOf('label') !== -1){
                        // Map labels
                        mark = L.marker([value.geometry.coordinates[1],value.geometry.coordinates[0]], 
                            {icon: L.divIcon({className: 'map-labels', html: value.name})})
                        .addTo(self.map);
                    }
                    else if (value.tags.indexOf('People') !== -1 && value.tags.indexOf('tour') == -1){
                        mark = L.marker([value.geometry.coordinates[1],value.geometry.coordinates[0]], 
                                {icon: L.divIcon({className: "houseIcon", html: '<span class="glyphicon glyphicon-home"></span>'})})
                            .bindPopup("<a href='#itemDetail/marker" + value.id + "'>" + value.name+'</a><br>'+value.description)
                            .addTo(self.map);
                    }
                    else if (value.tags.indexOf('Art') !== -1 && value.tags.indexOf('tour') == -1){
                        mark = L.marker([value.geometry.coordinates[1],value.geometry.coordinates[0]], 
                                {icon: L.divIcon({className: "artIcon", html: '<span class="glyphicon glyphicon-asterisk"></span>'})})
                            .bindPopup("<a href='#itemDetail/marker" + value.id + "'>" + value.name+'</a><br>'+value.description)
                            .addTo(self.map);
                    }
                    else if(value.photo_array !== null || value.audio_array !== null){
                        // markers with content
                        mark = L.circleMarker([value.geometry.coordinates[1],value.geometry.coordinates[0]], 
                            {radius: 10,
                            fillColor: 'blue',
                            fillOpacity: 1,
                            color: 'white',
                            opacity: 1,
                            weight: 1})
                        .bindPopup("<a href='#itemDetail/marker" + value.id + "'>" + value.name+'</a><br>'+value.description)
                        .addTo(self.map);
                    }
                    else {
                        // markers without content
                        mark = L.circleMarker([value.geometry.coordinates[1],value.geometry.coordinates[0]], 
                            {radius: 6,
                            fillColor: 'gray',
                            fillOpacity: 1,
                            color: 'white',
                            opacity: 1,
                            weight: 1})
                        .bindPopup(value.name+'<br>'+value.description)
                        .addTo(self.map);
                    }
                    self.mapMarkers.push(mark); 

                    if (controller.filter !== ""){
                        var match = value.tags.match(RegExp(controller.filter + "(\\d+)", "i"));

                        if (match !== null){
                            mark = L.marker([value.geometry.coordinates[1],value.geometry.coordinates[0]], 
                                {icon: L.divIcon({className: "tour-labels", html: match[1]})})
                            .bindPopup("<a href='#itemDetail/marker" + value.id + "'>" + value.name+'</a><br>'+value.description)
                            .addTo(self.map);
                            self.mapMarkers.push(mark);
                        }
                    }
                }
                
            });
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
