<map>
    <div if={ this.display }>
        <div name="mapArea" class="mapArea"></div>
        <div name="legend" class="map-legend dropup">
            <button type="button" class="btn btn-default insite-button" data-toggle="dropdown">
                Legend
            </button>
            <ul class="dropdown-menu map-legend-items">
                <li each={ tag, i in opts.tagStyles }>
                    <svg height="20" width="20">
                        <circle cx="10" cy="10" r="10" class="insite-map-marker {tag}"/>
                    </svg> { tag }</li>
                </li>
                <li>
                    <svg height="20" width="20">
                        <circle cx="10" cy="10" r="10" class="insite-map-marker"/>
                    </svg> other</li>
                </li>
            </ul>
        </div>
    </div>

    <script>
        // scripts
        this.display=false;
        var L = require('leaflet');
        var SimpleSet = require('./simpleSet.js');
        L.Icon.Default.imagePath = 'leaflet_images/'
        var $ = require('jquery');
        var controller = opts.controller;
        var self = this;
        var user_marker = false;
        // var tourButtonDisplay=false;
        var startLatLng = L.latLng(opts.mapOpts.startLoc);
        var setViewbyLocation = require('./setViewbyLocation');
        var shortenText = require('./shortenText');

        // get tags that should have styles applied.
        var Matcher = require('./stringMatcher')
        var matcher = new Matcher(opts.tagStyles);

        self.mapMarkers = [];
        self.userMarker = null;

        var tours = new SimpleSet(opts.highlightedFilters.map(function(v){ return v.tour; }));
        var tour_filter = new SimpleSet(opts.highlightedFilters.map(function(v){ return v.filter; }));
        var tourDict = {};
        for (var i=0, l=opts.highlightedFilters.length, tour; i<l, tour=opts.highlightedFilters[i]; i++){
            tourDict[tour.filter] = tour;
        }

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

        // controller.on("OnTour", function(bool){
        //     if (bool === true){
        //         self.tourButtonDisplay=false;
        //     }
        // });

        controller.on('ItemsUpdated', function(item){
            //display tourbutton
            // if (tour_filter.contains(controller.filter) && controller.filter!== ""){
            //     self.tourButtonDisplay=true;
            // }
            // else{
            //     self.tourButtonDisplay=false;
            // }
            // self.update();

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
                        return;
                    }
                    else{
                        // markers with content
                        var cssClass = "insite-map-marker";
                        
                        // check if marker is tagged for a certain style
                        var tagged = matcher.firstMatch(value.tags);
                        if (tagged){
                            cssClass += " " + tagged;
                        }
                        
                        mark = L.circleMarker([value.geometry.coordinates[1],value.geometry.coordinates[0]], 
                            {className: cssClass})
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
            return "<div class='insite-popup'>" + 
                        getPhoto(value) +
                        "<div class='description'>" +
                            "<a href='#itemDetail/marker" + value.id + "'><h4>" + value.name+'</h4></a>'+
                            shortenText(value.description, 80) +
                        "</div>" +
                        "<div class='indicators'>"+getAudioLength(value)+"</div>" +
                    "</div>";
        }

        function getPhoto(value){
            if (typeof value.photo_array === 'undefined' || value.photo_array === null){return "";};
            return "<div class='thumbnail-div'>" + 
                            "<div style='height:auto'></div>" +
                            "<a href='#itemDetail/marker" + value.id + "'>" + 
                                "<img class='thumbnail-photo' src='" + controller.itemDict['photo'+value.photo_array[0]]['path_small'] + "'>" + 
                            "</a>" +
                            "<div style='height:auto'></div>" +
                        "</div>";
            
        }


        function getAudioLength(value){
            if (typeof value.audio_array === 'undefined' || value.audio_array === null){return "";};
            return "<span class ='glyphicon glyphicon-volume-up'></span>"+"x"+String(value.audio_array.length);
        }

        // startTour(){
        //     if (controller.filter in tourDict){
        //         previousFilter = controller.filter;
        //         controller.trigger("UpdateFilter", tourDict[controller.filter].tour);
        //     }
        //     controller.trigger('StartTour',0);
        //     self.tourButtonDisplay=false;
        //     self.update()
        // }

        // tourName(){
        //     return tourDict[controller.filter].name;
        // }

    </script>

</map>
