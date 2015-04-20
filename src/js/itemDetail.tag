<itemdetail>
    <div id="itemDetail" if={this.display}>
        <div id="title"> 
            <h1>{item.name}</h1>
        </div>
        

        <!-- image slideshow -->
        <div show={ item.photo_array != null }> 
            <h4>photos</h4>
            <!-- The Gallery as inline carousel, can be positioned anywhere on the page -->
                <div id="blueimp-gallery-carousel" name="gallery" class="blueimp-gallery blueimp-gallery-carousel">
                    <div class="slides" name="slides"></div>
                        <h3 class="title"></h3>
                        <a class="prev">‹</a>
                        <a class="next">›</a>
                        <a class="play-pause"></a>
                        <ol class="indicator"></ol>
                </div>

                <div name="images">
                    <a href="http://insite.localground.org/profile/photos/L3VzZXJkYXRhL21lZGlhL3NhbmRyYS9waG90b3MvaG9iYml0aG91c2VpbWcwMjkwdGh1bWJjb3B5XzUwMC5qcGc=/">
                    </a>
                    
                </div>

        </div>
        <!-- description -->
        <div id="description"> 
            <h4>{item.description}</h4>
        </div>

        <!-- list of stories connected to item -->
        <div id="audioList" if={ this.item.audio_array }> 
        <h4>audio list</h4>
        <!-- insert relevant stories -->
            <div each={this.getAudio()} onclick={parent.playAudio} class="row">
                <div class="audioItem">
                    <div class="col-md-12"> {name}
                    </div>
                </div>
            </div>
        </div>

        <!-- tags -->
        <div id="tags"> 
            <h4>tags</h4>
            <div class="row">
                <div class="col-md-4">{item.tags}</div>
            </div>
            <!-- insert taglist here -->
        </div>
    </div>

    <script>
        this.display=false;
        this.item = null;
        this.item_id = null;
        this._viewID = "itemDetail";
        var controller = opts.controller;
        var self = this;
        var $ = require('jquery');

        getAudio(){
            if (self.item === null || self.item.audio_array === null || typeof self.item.audio_array === "undefined"){
                return [];
            }
            else{
                return self.item.audio_array.map(function(id){ return controller.itemDict['audio'+id];})
            }
        }

        refreshGallery(){
            self.slides.innerHTML="";
            var photoList = self.getPhotoList();
            if (photoList !== false){
                blueimp.Gallery(
                    photoList,
                    {
                        container: self.gallery,
                        carousel: true
                    }
                );
            }
        }

        controller.on('ActivateView', function(view, item){
            self.display = (view==self._viewID);
            if (! self.display){ self.update(); return;}
            self.item_id = item;
            self.loadItem();
        });
        
        controller.on('ItemsUpdated', function(){self.loadItem();});
        
        loadItem(){
            if (controller.itemDict !== null && self.item_id in controller.itemDict){
                self.item = controller.itemDict[self.item_id];
            }else{
                self.item = {name: "Not found", description: "not found"};
            }

            self.update();
            self.refreshGallery();
        }

        getPhotoList(){
            if (typeof self.item.photo_array === 'undefined' || self.item.photo_array === null){return false};
            return self.item.photo_array.map(function(id){
                return {
                    href:controller.itemDict["photo"+id].path_medium,
                    caption: controller.itemDict["photo"+id].name
                }
            });
        }

        playAudio(e) {
            var item = e.item
            console.log(item);
            controller.trigger("playAudio", item)
        }

        

    </script>
</itemdetail>

