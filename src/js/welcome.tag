<welcome>
    <div id="welcome-header" if={ this.display }>
        <h1>Welcome to the Albany Bulb</h1>
        <p>Listen to audio stories and explore</p>
    </div>

    <div id="welcome-footer" if={ this.display }>
        <span onclick={ this.hideWelcome } id="hideWelcome" class="glyphicon glyphicon-remove"></span>
        <div id="welcome-footer-content">
            <button id="tour-button" class="btn btn-primary" onclick={ this.startTour } type="submit">Take a Tour</button>  or  
            <button id="tour-button" class="btn btn-primary" onclick={ this.fullMap } type="submit">Explore Full Map</button>
        </div>
    </div>

    <script>
        var controller = opts.controller;
        var $ = require('jquery');
        var self = this;
        self.display = true;

        // controller.on('ActivateView', function(title){
        //     self.display = false;
        //     self.update();
        // });

        controller.on('ActivateView', function(title){
            self.display = (title=='Welcome');
            self.update();
        });

        hideWelcome(e){
            self.display = false;
        }

        startTour(){
            this.updateFilter('tour');
            controller.trigger('StartTour',0)
            self.display=false;
        }

        fullMap(){
            self.updateFilter("")
            self.display=false;
        }

        updateFilter(filter){
            controller.trigger("UpdateFilter", filter);
        }

        // $('#mapArea').click(function(){
        //     self.display=false;
        // });


    </script>
    
</welcome>
