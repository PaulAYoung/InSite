<tour>
    <div if={ this.display } class="tourstop-info">
        <h4 if={ tour } class="tour-title">{ tour.name } Tour</h4>
        <span onclick={ this.itemDetailURL }>{ this.displayTourStopNumber()}: { this.displayTourStopName() } - { this.distanceTo() }</span>
        <div style="float:right;position:relative;" onclick={ this.endTour }>
            <span class="glyphicon glyphicon-remove"></span>
            <span>Exit Tour</span>
        </div>
        <div style="position:relative;float:left;clear:both;width:100%;margin:.5em;">
            <div style="position:relative;float:left;" onclick={ this.back }>
                <span class="glyphicon glyphicon-chevron-left" ></span>
                <span>Back</span>
            </div>
            <div style="position:relative;float:right;" onclick={ this.next }>
                <span>Next</span>
                <span class="glyphicon glyphicon-chevron-right" ></span>
            </div>
        </div>
    </div>

    <script>
        var SimpleSet = require('./simpleSet.js');
        var L = require('leaflet');
        var convertToUSDistance = require('./convertToUSDistance');
        this.display=false;
        this.tour = null;
        var riot = require('riot');
        var controller = opts.controller;
        this.tourButtonDisplay=false;
        var previousFilter="";
        var self = this;

        self.tourIndex = 0;

        this.on("mount", function(){console.log("tour tag loaded");});

        controller.on('StartTour', function(tour){
            var filter = tour.filter;
            self.tour = tour;
            controller.trigger("UpdateFilter", filter, true);
            self.tourButtonDisplay=false;
            self.tourIndex=0;
            self.tourLength=controller.itemList.length;
            console.log(controller.markers.length);
            self.selectItem(0);
            self.update();
        });

        controller.on("UpdateFilter", function(filter, tour){
            self.display = tour;
            self.update();
        });


        selectItem(index){
            controller.trigger("SelectMapItem", index, 18);
            controller.trigger("ItemSelected", "marker" + controller.markers[self.tourIndex].id);
            //if listview is active
            // riot.route("#itemDetail/marker" + controller.markers[self.tourIndex].id);
        }

        itemDetailURL(){
            riot.route("#itemDetail/marker" + controller.markers[self.tourIndex].id);
        }

        next(){
            if (self.tourIndex<self.tourLength-1){
                self.tourIndex++;
            } else {
                self.tourIndex = 0;
            }
            self.selectItem(self.tourIndex);
            self.update();
        }

        back(){
            if (self.tourIndex>0){
                self.tourIndex--;
            }else {
                self.tourIndex = self.tourLength-1;
            }
            self.selectItem(self.tourIndex);
            self.update();
        }


        tourName(){
            return tourDict[controller.filter].name;
        }

        displayTourStopNumber(){
            if (controller.markers !== null) {return 'Stop '+String(self.tourIndex+1);}
            else {return "";}
        }

        displayTourStopName(){
            if (controller.markers !== null) {return controller.markers[self.tourIndex].name;}
            else {return "";}
        }

        distanceTo(){
            var user_location_marker = L.latLng(controller.loc['lat'], controller.loc['lon']);
            var marker_location= L.latLng(controller.markers[self.tourIndex].geometry.coordinates[1], controller.markers[self.tourIndex].geometry.coordinates[0]);
            //convert distance from meters to ft
            var distance_m = user_location_marker.distanceTo(marker_location)
            return String(convertToUSDistance(distance_m).num)+" "+convertToUSDistance(distance_m).unit;
        }

        endTour(){
            controller.trigger("SetMapView", L.latLng(opts.mapOpts.startLoc), opts.mapOpts.startZoom);
            controller.trigger("OnTour", false);
            controller.trigger("UpdateFilter", previousFilter);
            self.tourButtonDisplay=true;
            self.display=false;
        }

    </script>

</tour>
