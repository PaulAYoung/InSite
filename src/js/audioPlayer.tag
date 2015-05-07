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
                    $('.audio-details').show();
                    $('#audiojs_wrapper0').append("<div id='close_audio' style='float:right;padding:5px;'><span class='glyphicon glyphicon-remove-sign' style='color:white;font-size:20px;'></span></div>");
                    // $('#audiojs_wrapper0').append("<div id='close_audio' style='float:right;padding:5px;'><img src='fonts/noun_53504_cc.svg'></div>");
                    $('.play-pause').append("<svg id='audioplayer-circle' height='80px' width='20%'><circle cx='37' cy='25' r='18' stroke='white' stroke-width='1' fill='transparent'/></svg>");
                    $('#close_audio').click(function(){
                        as.pause();
                        $('.audio-details').hide();
                        $('#audiojs_wrapper0').hide();
                    });
                }else{
                    as.pause();
                    as.load(self.item.file_path);
                    $('#audiojs_wrapper0').show();
                    $('.audio-details').show();
                }
                as.play();

            } else {
                self.display = false;
                self.update();
            }
        });

    </script>


</audioplayer>
