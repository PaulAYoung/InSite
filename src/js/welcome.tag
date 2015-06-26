<welcome>
    <div id="welcome-header" if={ this.display }>
        <h1 style="margin-bottom:5px;">{ opts.appTitle }</h1>
        <p style="font-size:16px;">{ opts.appDescription }</p>
    </div>
    <div if={ this.display } onclick={ this.hideWelcome } id="exit-welcome"></div>
    <div id="welcome-footer" if={ this.display }>
        <div id="welcome-footer-content">
            <button class="btn btn-primary tour-button" onclick={ this.startTour } type="submit">Take a Tour</button><span style='margin:5px;'>or</span><button class="btn btn-primary tour-button" onclick={ this.fullMap } type="submit">Explore Full Map</button>
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
    
        controller.on("UpdateFilter", function(){
                self.hideWelcome();
                self.update();
        });

        hideWelcome(e){
            self.display = false;
        }

        startTour(){
            controller.trigger('StartTour', opts.tours[0].filter)
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
