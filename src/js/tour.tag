<tour>
    <div if={ this.display } class="tourstop-info">
        <div onclick={ this.updateTour }>
            <p>{ this.displayTourName() }</p>
            <span>Next Tour Stop</span>
            <span class="glyphicon glyphicon-chevron-right" ></span>
        </div>
        <div onclick={ this.endTour }>
            <span class="glyphicon glyphicon-remove"></span>
            <span>Exit Tour</span>
        </div>
    </div>

    <script>
        this.display=false;
        var controller = opts.controller;
        var self = this;

        self.tourIndex = 0;

        this.on("mount", function(){console.log("tour tag loaded");});

        controller.on('StartTour', function(index){
            self.display = true;
            self.tourIndex=index;
            self.setMapViewbyTourIndex(index);
            self.update();
            console.log("tour started");
        });
        
        setMapViewbyTourIndex(index){
            controller.trigger("SetMapView", L.latLng(controller.markers[index].geometry.coordinates[1],controller.markers[index].geometry.coordinates[0]), 18);
        }

        updateTour(){
            self.tourIndex++;
            self.setMapViewbyTourIndex(self.tourIndex);
            self.update();
        }

        displayTourName(){
            if (controller.markers !== null) {return controller.markers[self.tourIndex].name;}
            else {return "";}
        }

        endTour(){
            controller.trigger("SetMapView", L.latLng(opts.startLoc), 16);
            self.display=false;
        }

    </script>

</tour>
