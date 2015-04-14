<itemdetail>
<div id="itemDetail" if={this.display}>
<div id="title"> 
            <h1>{item.name}</h1>
        </div>
        

        <!-- image slideshow -->
        <div> 
            <h4>photos</h4>
            <!-- The Gallery as inline carousel, can be positioned anywhere on the page -->
                <div id="blueimp-gallery-carousel" name="gallery" class="blueimp-gallery blueimp-gallery-carousel">
                    <div class="slides"></div>
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

                <!-- description -->
                <div id="description"> 
                    <h4>{item.description}</h4>
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

        <!-- list of stories connected to item -->
        <div id="audioList"> 
        <h4>audio list</h4>
        <!-- insert relevant stories -->
            <div class="row">
                <div class="audioItem">
                    <div class="col-md-12">A Million Dollar View
                </div>
                <div class="audioItem">
                    <div class="col-md-12">Door of Opportunity
                </div>
                <div class="audioItem">
                    <div class="col-md-12">My Home
                    </div>
                </div>
        
            
                </div>
            </div>

    <script>
        this.display=false;
        this.items = null;
        this.item_id = null;
        this._viewID = "itemDetail";
        var controller = opts.controller;
        var self = this;
        var $ = require('jquery');
        window.gallery = $("#blueimp-gallery-carousel");

        this.on("mount", function(){
            console.log("loading gallery");
            var gallery = blueimp.Gallery(
                [{
                    href:"http://insite.localground.org/profile/photos/L3VzZXJkYXRhL21lZGlhL3NhbmRyYS9waG90b3MvaG9iYml0aG91c2VpbWcwMjkwdGh1bWJjb3B5XzUwMC5qcGc=/",
                    type: "image/jpeg",
                    caption: "blahblah"
                }],
                {
                    container: self.gallery,
                    carousel: true
                }
            );
            console.log(gallery);
        });

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
        }

        getPhotoList(){
            console.log(self.item.photo_array);
            return self.item.photo_array.map(function(id){
                return {
                    url:controller.itemDict["photo"+id].path_medium,
                    caption: controller.itemDict["photo"+id].name
                }
            });
        }

        

    </script>
</itemdetail>

