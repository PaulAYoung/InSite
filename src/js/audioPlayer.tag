<audioplayer>
    <audio name="player" if={this.display}>
      <source src={ this.item.file_path }>
    </audio>
    <div class="audio-details">
        { item.name }
    </div>

    <script>
        var controller = opts.controller;
        var self = this;
        var as = null;

        //NEED TO FIX: DISPLAY SHOULD BE SET TO FALSE. 
        self.display = false;

        controller.on("playAudio", function(item){
            self.item = item;
            console.log("audio");
            if (item.overlay_type === "audio"){
                self.display = true;

                self.update();
                if (as === null){
                    audiojs.events.ready(function() {
                        as = audiojs.createAll()[0];
                        window.as = as;
                    });
                }else{
                    as.pause();
                    as.load(self.item.file_path);
                }

                as.play();
                

            } else {
                self.display = false;
                self.update();
            }
        });

    </script>


</audioplayer>
