<itemdetail>
    <div id="itemDetail" if={this.display}>
        <div class="panel panel-default">
          <!-- Default panel contents -->
            <div class="panel-heading" id="title">
                <h3 style="margin-top: 0px">{item.name}
                </h3>
            </div>
          
            <div class="panel-body">
                <div id="mapThumbnail">
                </div>
                <div id="description"> 
                    <p>{item.description}</p>
                </div>
            </div>
     
        <!-- list of stories connected to item -->
            <div id="audioList" if={ this.item.audio_array }> 
                
            <!-- insert relevant stories -->
                <ul class="list-group">
                    <div each={this.getAudio()} onclick={parent.playAudio}>
                        <li class="list-group-item audioItem">
                        <!-- <div class="col-md-12"> -->
                            <span class="glyphicon glyphicon-volume-up"></span>
                            <strong>{name}</strong> - {attribution}<br>
                            <p style="margin-left:18px">{description}</p>
                        <!-- </div> -->
                        </li>
                    </div>
                </ul>
            </div>
        </div>


        <!-- image slideshow -->
        <div show={ item.photo_array != null }> 
            <!-- The Gallery as inline carousel, can be positioned anywhere on the page -->
                <div id="blueimp-gallery-carousel" name="gallery" class="blueimp-gallery blueimp-gallery-carousel">
                    <div class="slides" name="slides"></div>
                        <h3 class="title"></h3>
                        <a class="prev">‹</a>
                        <a class="next">›</a>
                        <a class="play-pause"></a>
                        <ol class="indicator"></ol>
                        <!-- The modal dialog, which will be used to wrap the lightbox content -->
                        <div class="modal fade">
                            <div class="modal-dialog">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <button type="button" class="close" aria-hidden="true">&times;</button>
                                        <h4 class="modal-title"></h4>
                                    </div>
                                    <div class="modal-body next"></div>
                                    <div class="modal-footer">
                                        <button type="button" class="btn btn-default pull-left prev">
                                            <i class="glyphicon glyphicon-chevron-left"></i>
                                            Previous
                                        </button>
                                        <button type="button" class="btn btn-primary next">
                                            Next
                                            <i class="glyphicon glyphicon-chevron-right"></i>
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </div>

                </div>
        </div>
    
        <!-- tags -->
        <div id="tags"> 
            <h4>Tags</h4>
            <div class="row">
                <div class="col-md-4">
                    <span each={ getTags() } class=item-tag onclick={ parent.setFilter }> { tag } </span>
                </div>
            </div>
        </div>
    </div>

    <script>
        this.display=false;
        // this.tourDisplay=false;
        this.item = null;
        this.item_id = null;
        this._viewID = "itemDetail";
        var controller = opts.controller;
        var tourMatcher = new RegExp("^(" + opts.tours.join("|") + ")\\d+$");
        console.log(tourMatcher);
        var self = this;
        var $ = require('jquery');

        getAudio(){
            if (self.item === null || self.item.audio_array === null || typeof self.item.audio_array === "undefined"){
                return [];
            }
            else{
                var z = self.item.audio_array.map(function(id){ return controller.itemDict['audio'+id];})
                console.log(z);
                return z
            }
        }

        getTags(){
            if (self.item !== null && typeof self.item !== 'undefined' && self.item.tags !== null && typeof self.item.tags !== "undefined"){
                return self.item.tags.split(",").map(function(tag){
                    tag = tag.trim();
                    var match = tag.match(tourMatcher);
                    if (match !== null){
                        console.log("match found");
                        console.log(match[1]);
                        tag =  match[1];
                    }
                    return {tag: tag};
                });
            } else {
                return [];
            }
        }

        setFilter(e){
            var item = e.item;
            controller.trigger("UpdateFilter", item.tag);
            controller.trigger("ActivateView", "Map");
        }

        refreshGallery(){
            self.slides.innerHTML="";
            var photoList = self.getPhotoList();
            if (photoList !== false){
                blueimp.Gallery(
                    photoList,
                    {
                        container: self.gallery,
                        carousel: true, 
                        startSlideshow: false
                    }
                );
            }
        }

        controller.on('ActivateView', function(view, item){
            self.display = (view==self._viewID);
            self.loadItem(item);
        });

        controller.on('ItemSelected', function(item){
            self.loadItem(item);
        });


        controller.on('OnTour', function(bool){
            if (bool){
                $('itemDetail').css({"position":"relative","top":"100px"});
                $('listview').css({"position":"relative","top":"100px"});
            }
            else{
                $('itemDetail').css({"position":"relative","top":"0px"});
                $('listview').css({"position":"relative","top":"0px"});
            }
        });

        loadItem(item){
            if (! self.display){ self.update(); return;}
            self.item_id = item;
            if (controller.itemDict !== null && self.item_id in controller.itemDict){
                self.item = controller.itemDict[self.item_id];
            }else{
                self.item = {name: "Not found", description: "not found"};
            }

            self.update();
            self.refreshGallery();
        }

        getPhotoList(){
            if (typeof self.item.photo_array === 'undefined' || self.item.photo_array === null){return false};
            return self.item.photo_array.map(function(id){
                return {
                    href:controller.itemDict["photo"+id].path_medium,
                    caption: controller.itemDict["photo"+id].name
                }
            });
        }

        playAudio(e) {
            var item = e.item
            console.log(item);
            controller.trigger("playAudio", item)
        }

        // map thumbnail scripts
        this.display=false;
        var L = require('leaflet');
        L.Icon.Default.imagePath = 'leaflet_images/'
        var $ = require('jquery');
        var controller = opts.controller;
        var self = this;
        var user_marker = false;
        var startLatLng = L.latLng(opts.startLoc);
        var setViewbyLocation = require('./setViewbyLocation');

        self.mapMarkers = [];
        self.userMarker = null;
        
        this.on('mount', function(e){
            self.map = new L.Map(self.mapThumbnail);
            var accessToken = 'pk.eyJ1IjoiYXJkbmFzZWVsIiwiYSI6IkNpTXlHU0UifQ.M20m1nJ01_0olbOTdPJ1oQ'
            var mapboxTiles = L.tileLayer('https://{s}.tiles.mapbox.com/v4/ardnaseel.kfgj3f5l/{z}/{x}/{y}.png?access_token='+ accessToken);
            
            self.map
                .addLayer(mapboxTiles)
                .setView(startLatLng, 16 );

            self.update();
            self.map.invalidateSize();
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
        
        
    </script>
</itemdetail>

