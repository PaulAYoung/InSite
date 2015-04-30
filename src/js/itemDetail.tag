<itemdetail>
    <div id="itemDetail" if={this.display}>
        <div id="title"> 
            <h3 style="margin-top: 0px">{item.name}</h3>
        </div>
        <!-- list of stories connected to item -->
        <div id="audioList" if={ this.item.audio_array }> 
        <h4>Stories</h4>
        <!-- insert relevant stories -->
            <div each={this.getAudio()} onclick={parent.playAudio} class="row">
                <div class="audioItem">
                    <div class="col-md-12">
                        <span class="glyphicon glyphicon-volume-up"></span>
                        <strong>{name}</strong> - {attribution}<br>
                        <p style="margin-left:18px">{description}</p>
                    </div>
                </div>
            </div>
        </div>


        <!-- image slideshow -->
        <div show={ item.photo_array != null }> 
            <!-- The Gallery as inline carousel, can be positioned anywhere on the page -->
                <div id="blueimp-gallery-carousel" name="gallery" class="blueimp-gallery blueimp-gallery-carousel">
                    <div class="slides" name="slides"></div>
                        <h3 class="title"></h3>
                        <a class="prev">‹</a>
                        <a class="next">›</a>
                        <a class="play-pause"></a>
                        <ol class="indicator"></ol>
                        <!-- The modal dialog, which will be used to wrap the lightbox content -->
                        <div class="modal fade">
                            <div class="modal-dialog">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <button type="button" class="close" aria-hidden="true">&times;</button>
                                        <h4 class="modal-title"></h4>
                                    </div>
                                    <div class="modal-body next"></div>
                                    <div class="modal-footer">
                                        <button type="button" class="btn btn-default pull-left prev">
                                            <i class="glyphicon glyphicon-chevron-left"></i>
                                            Previous
                                        </button>
                                        <button type="button" class="btn btn-primary next">
                                            Next
                                            <i class="glyphicon glyphicon-chevron-right"></i>
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </div>

                </div>

                <!-- <div name="images">
                    
                </div> -->

        </div>
        <!-- description -->
        <div id="description"> 
            <p>{item.description}</p>
        </div>

        

        <!-- tags -->
        <div id="tags"> 
            <h4>Tags</h4>
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
                var z = self.item.audio_array.map(function(id){ return controller.itemDict['audio'+id];})
                console.log(z);
                return z
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
                        carousel: true, 
                        startSlideshow: false
                    }
                );
            }
        }

        controller.on('ActivateView', function(view, item){
            self.display = (view==self._viewID);
            self.loadItem(item);
        });

        controller.on('ItemSelected', function(item){
            self.loadItem(item);
        });

        // controller.on('ItemsUpdated', function(){self.loadItem();});
        
        loadItem(item){
            if (! self.display){ self.update(); return;}
            self.item_id = item;
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

