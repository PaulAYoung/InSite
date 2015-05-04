<tour>
    <div if={ this.display } class="tourstop-info">
        <h4 onclick={ this.itemDetailURL }>{ this.displayTourStopNumber()}:<br> { this.displayTourStopName() }</h4>
        <div style="position:relative;bottom:-20px;float:left;clear:both;" onclick={ this.updateTour }>
            <span>Next Tour Stop</span>
            <span class="glyphicon glyphicon-chevron-right" ></span>
        </div>
        <div style="float:right;position:relative;bottom:-20px;" onclick={ this.endTour }>
            <span class="glyphicon glyphicon-remove"></span>
            <span>Exit Tour</span>
        </div>
    </div>
    <button if={ this.tourButtonDisplay } id="map-tour-button" class="btn btn-primary" onclick={ this.startTour } type="submit">Start { this.tourName() }</button>

    <script>
        var SimpleSet = require('./simpleSet.js');

        this.display=false;
        var riot = require('riot');
        var controller = opts.controller;
        this.tourButtonDisplay=false;
        var self = this;

        var tours = new SimpleSet(opts.tours);

        self.tourIndex = 0;

        this.on("mount", function(){console.log("tour tag loaded");});

        controller.on('StartTour', function(index){
            controller.trigger('OnTour',true);
            controller._tourSort();
            self.display=true;
            self.tourButtonDisplay=false;
            self.tourIndex=index;
            self.selectItem(index);
            self.update();
        });

        controller.on('ItemsUpdated', function(){
            if (tours.contains(controller.filter) && self.display==false){
                self.tourButtonDisplay=true;
                self.update();
            }
            else{
                self.tourButtonDisplay=false;
                self.update();
            }
        })

        startTour(){
            controller.trigger('StartTour',0);
            self.tourButtonDisplay=false;
            self.update()
        }

        selectItem(index){
            controller.trigger("SetMapView", L.latLng(controller.markers[index].geometry.coordinates[1],controller.markers[index].geometry.coordinates[0]), 18);
            controller.trigger("ItemSelected", "marker" + controller.markers[self.tourIndex].id);
            //if listview is active
            // riot.route("#itemDetail/marker" + controller.markers[self.tourIndex].id);
        }

        itemDetailURL(){
            riot.route("#itemDetail/marker" + controller.markers[self.tourIndex].id);
        }

        updateTour(){
            self.tourIndex++;
            self.selectItem(self.tourIndex);
            self.update();
        }

        tourName(){
            return controller.filter;
        }

        displayTourStopNumber(){
            if (controller.markers !== null) {return 'Tour Stop '+String(self.tourIndex);}
            else {return "";}
        }

        displayTourStopName(){
            if (controller.markers !== null) {return controller.markers[self.tourIndex].name;}
            else {return "";}
        }

        endTour(){
            controller.trigger("SetMapView", L.latLng(opts.mapOpts.startLoc), opts.mapOpts.startZoom);
            controller.trigger("OnTour", false);
            self.tourButtonDisplay=true;
            self.display=false;
        }

    </script>

</tour>
