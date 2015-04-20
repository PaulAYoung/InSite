<audioplayer>
    <audio name="player" if={this.display}>
      <source src={ this.item.file_path }>
    </audio>

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
                audiojs.events.ready(function() {
                    as = audiojs.createAll();
                });
                
                $('#audiojs_wrapper0').append("<div id='audioTitle'>test this</div>");

            } else {
                self.display = false;
                self.update();
            }
        });

    </script>


</audioplayer>
