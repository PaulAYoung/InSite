<welcome>
    <div id="welcome-header" if={ this.display }>
        <h1>Welcome to the Albany Bulb</h1>
        <p>Listen to audio stories and explore</p>
    </div>
    <div if={ this.display } onclick={ this.hideWelcome } id="exit-welcome"></div>
    <div id="welcome-footer" if={ this.display }>
        <span onclick={ this.hideWelcome } id="hideWelcome" class="glyphicon glyphicon-remove"></span>
        <div id="welcome-footer-content">
            <button id="welcome-tour-button" class="btn btn-primary" onclick={ this.startTour } type="submit">Take a Tour</button>  or  
            <button class="btn btn-primary" onclick={ this.fullMap } type="submit">Explore Full Map</button>
        </div>
    </div>

    <script>
        var controller = opts.controller;
        var $ = require('jquery');
        var self = this;

        controller.on('ActivateView', function(title){
            self.display = (title=='Welcome');
            self.update();
        });

        hideWelcome(e){
            self.display = false;
        }

        startTour(){
            this.updateFilter('tour');
            controller.trigger('OnTour',true);
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

    </script>
    
</welcome>
