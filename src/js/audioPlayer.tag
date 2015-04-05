<audioplayer>
<div if={ this.display }  name="control" class="audio-controls" onclick={ execCommand }>
        <span>{ this.command }</span>
    </div>

    <script>
        var controller = opts.controller;
        var self = this;

        self.audio = new Audio();
        self.command = "Play";
        self.display = false;

        controller.on("ItemSelected", function(item){
            if (item.overlay_type === "audio"){
                self.display = true;
                self.audio.pause();

                self.audio.src = item.file_path;
                
                self.update();
            } else {
                self.display = false;
                self.update();
            }
        });

        execCommand(){
            if (self.command === "Play"){
                self.audio.play();
                self.command = "Pause";
            }else{
                self.audio.pause();
                self.command = "Play";
            }
            self.update();
        }
    </script>
</audioplayer>
