<audioplayer>
    <audio if={this.display}>
      <source src="http://insite.localground.org/profile/audio/L3VzZXJkYXRhL21lZGlhL255Ym9ycm9ieW4vYXVkaW8vdGFtYXJhc2lnaHRmb3Jzb3JlZXllcy5tcDM=/">
    </audio>

    <script>
        var controller = opts.controller;
        var self = this;

        self.audio = new Audio();
        self.command = "Play";
        //NEED TO FIX: DISPLAY SHOULD BE SET TO FALSE. 
        self.display = true;
        self.url = "http://insite.localground.org/profile/audio/L3VzZXJkYXRhL21lZGlhL255Ym9ycm9ieW4vYXVkaW8vdGFtYXJhc2lnaHRmb3Jzb3JlZXllcy5tcDM=/";

        //initialize audiojs player
        audiojs.events.ready(function() {
            var as = audiojs.createAll();
          });

        controller.on("ItemSelected", function(item){
                console.log(item);
            if (item.overlay_type === "audio"){
                console.log(self.display);
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
