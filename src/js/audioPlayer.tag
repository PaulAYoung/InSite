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

        self.display = false;

        controller.on("playAudio", function(item){
            self.item = item;
            if (item.overlay_type === "audio"){
                self.display = true;
                self.update();
                if (as === null){
                    // console.log($('#audiojs_wrapper0').length);
                    audiojs.events.ready(function() {
                        as = audiojs.createAll()[0];
                        window.as = as;
                    });
                    $('#audiojs_wrapper0').append("<div id='close_audio' style='float:right;padding:10px'><span class='glyphicon glyphicon-remove' style='color:white'></span></div>");
                    $('#close_audio').click(function(){
                        as.pause();
                        $('#audiojs_wrapper0').hide();
                    });
                }else{
                    as.pause();
                    as.load(self.item.file_path);
                    $('#audiojs_wrapper0').show();
                }
                as.play();

            } else {
                self.display = false;
                self.update();
            }
        });

    </script>


</audioplayer>
