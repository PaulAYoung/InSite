<welcome>
    <div id="welcome-header" if={ this.display }>
        <h1>Welcome to the Albany Bulb</h1>
        <p>Listen to audio stories and explore</p>
    </div>

    <div id="welcome-footer" if={ this.display }>
        <button id="tour-button" class="btn btn-primary" onclick={ this.startTour } type="submit">Start Tour</button>
        <p onclick={ this.hideWelcome } id="hideWelcome">or go straight to map</p>
    </div>

    <script>
        var controller = opts.controller;
        var $ = require('jquery');
        var self = this;
        self.display = true;

        hideWelcome(e){
            self.display = false;
        }

        startTour(){
            this.updateFilter('tour');
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
