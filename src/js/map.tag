<map>
    <div if={ this.display }>
        <div name="mapArea" class="mapArea"></div>
    </div>

    <script>
        // scripts
        this.display=false;
        var L = require('leaflet');
        L.Icon.Default.imagePath = 'leaflet_images/'
        var $ = require('jquery');
        var controller = opts.controller;
        var self = this;
        var user_marker = false;
        var startLatLng = L.latLng(opts.mapOpts.startLoc);
        var setViewbyLocation = require('./setViewbyLocation');
        var shortenText = require('./shortenText');

        self.mapMarkers = [];
        self.userMarker = null;

        this.on('mount', function(e){
            self.map = new L.Map(self.mapArea);
            var mapboxTiles = L.tileLayer(opts.mapOpts.tileUrl);
            
            console.log(startLatLng);
            self.map
                .addLayer(mapboxTiles)
                .setView(startLatLng, opts.mapOpts.startZoom);

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
            var distance_to_bulb = startLatLng.distanceTo(user_location);
           
            // self.map.setView(setViewbyLocation(1416, user_location, startLatLng), 16);
          
          console.log('Your current position is:');
          console.log('Latitude : ' + crd.latitude);
          console.log('Longitude: ' + crd.longitude);
          console.log('More or less ' + crd.accuracy + ' meters.');
          console.log("distance to bulb: "+ distance_to_bulb+"m");
        });

        controller.on("LocateMe", function(){
            self.map.setView(L.latLng(controller.loc.lat, controller.loc.lon), 18);
        });

        controller.on('ActivateView', function(title){
            self.display = ('Map Welcome'.indexOf(title) !== -1);
            self.update();
            self.map.invalidateSize();
        });

        controller.on("SetMapView", function(){
            self.map.setView.apply(self.map, arguments);
        });

        controller.on('ItemsUpdated', function(item){
            self.clearMarkers();
            var markers = controller.markers;
            console.log(markers);
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
                    else if(value.description === "" && value.photo_array === null && value.audio_array === null){
                        // markers without content
                        mark = L.circleMarker([value.geometry.coordinates[1],value.geometry.coordinates[0]], 
                            {radius: 6,
                            fillColor: '#d3d7e3',
                            fillOpacity: 1,
                            color: '#d3d7e3',
                            opacity: 1,
                            weight: 1})
                        .bindPopup(value.name+'<br>'+value.description)
                        .addTo(self.map);
                    }
                    else if (value.tags.indexOf('People') !== -1){
                        mark = L.circleMarker([value.geometry.coordinates[1],value.geometry.coordinates[0]], 
                            {radius: 14,
                            fillColor: '#64d3aa',
                            fillOpacity: 1,
                            color: '#eeffcc',
                            opacity: 1,
                            weight: 1})
                        .bindPopup(bindPopup(value))
                        .addTo(self.map);
                    }
                    else if (value.tags.indexOf('Art') !== -1){
                        mark = L.circleMarker([value.geometry.coordinates[1],value.geometry.coordinates[0]], 
                            {radius: 14,
                            fillColor: '#8f4c54',
                            fillOpacity: 1,
                            color: '#eeffcc',
                            opacity: 1,
                            weight: 1})
                        .bindPopup(bindPopup(value))
                        .addTo(self.map);
                    }
                    else{
                        // markers with content
                        mark = L.circleMarker([value.geometry.coordinates[1],value.geometry.coordinates[0]], 
                            {radius: 14,
                            fillColor: '#648ed3',
                            fillOpacity: 1,
                            color: '#eeffcc',
                            opacity: 1,
                            weight: 1})
                        .bindPopup(bindPopup(value))
                        .addTo(self.map);
                    }
                    
                    self.mapMarkers.push(mark); 

                    if (controller.filter !== ""){
                        var match = value.tags.match(RegExp(controller.filter + "(\\d+)", "i"));

                        if (match !== null){
                            mark = L.marker([value.geometry.coordinates[1],value.geometry.coordinates[0]], 
                                {icon: L.divIcon({className: "tour-labels", html: match[1]})})
                            .bindPopup(bindPopup(value))
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

        function bindPopup(value){
            return "<div class='container-fluid'><div class='row'><div class='col-xs-3'><div class='thumbnail-div'><a href='#itemDetail/marker" + value.id + "'><img class='thumbnail-photo' src='"+getPhoto(value)+"'></a></div></div><div class='col-xs-9'><a href='#itemDetail/marker" + value.id + "'><h4>" + value.name+'</h4></a>'+shortenText(value.description, 80)+"<br>"+getAudioLength(value)+"</div></div></div>";
        }

        function getPhoto(value){
            if (typeof value.photo_array === 'undefined' || value.photo_array === null){return "";};
            return controller.itemDict['photo'+value.photo_array[0]]['path_small'];
        }

        function getAudioLength(value){
            if (typeof value.audio_array === 'undefined' || value.audio_array === null){return "";};
            return "<span class ='glyphicon glyphicon-volume-up'></span>"+"x"+String(value.audio_array.length);
        }

    </script>

</map>
