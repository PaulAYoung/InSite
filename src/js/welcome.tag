<welcome>
    <div id="welcome-header" if={ this.display }>
        <h1>Welcome to the Albany Bulb</h1>
        <p>Listen to audio stories and explore</p>
    </div>

    <div id="welcome-footer" if={ this.display }>
        <button id="tour-button" class="btn btn-primary" type="submit">Take a Tour</button>
        <p>or click <span class="glyphicon glyphicon-search"></span> to explore on your own</p>
    </div>

    <script>
        var controller = opts.controller;
        var self = this;
        self.display = true;

        this.on('mount', function(e){
            self.display = true;
        });

    </script>
    
</welcome>
