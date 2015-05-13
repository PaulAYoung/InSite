<itemdetail>
    <div id="itemDetail" if={this.display}>
        <div class="panel panel-default">
          <!-- Default panel contents -->
            <div class="panel-heading" id="title">
                <h3 style="margin-top: 0px">{item.name}
                </h3>
            </div>
          
            <div class="panel-body">
                <div name="mapThumbnail">
                </div>
                <div id="description"> 
                    <p>{item.description}</p>
                </div>
            </div>
     
        <!-- list of stories connected to item -->
            <div id="audioList" if={ this.item.audio_array }> 
                
            <!-- insert relevant stories -->
                <ul class="list-group">
                    <li  each={this.getAudio()} onclick={parent.playAudio} class="list-group-item audioItem">
                    <!-- <div class="col-md-12"> -->
                        <div style="float:left;clear:both;">
                            <span class="glyphicon glyphicon-volume-up"></span>
                        </div>
                        <div style="margin-left:20px;">
                            <strong class="audio-name">{name} - </strong>  
                            <span class="attribution" style="font-size:16px;">{attribution}</span>
                            <p>{description}</p>
                        </div>
                    </li>
                </ul>
            </div>
        </div>


        <!-- image slideshow -->
        <div show={ item.photo_array != null }> 
            <!-- The Gallery as inline carousel, can be positioned anywhere on the page -->
                <div id="blueimp-gallery-carousel" name="gallery" class="blueimp-gallery blueimp-gallery-carousel blueimp-gallery-controls">
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
        </div>
        <div id="photo-description">{ photoDescription }</div>
    
        <!-- tags -->
        <div id="tags"> 
            <strong>Tags: </strong>
            <span style="color:#337ab7;" each={ getTags() } class=item-tag onclick={ parent.setFilter }>{ tag } </span>
        </div>
    </div>

    <script>
        this.display=false;
        // this.tourDisplay=false;
        this.item = null;
        this.item_id = null;
        this._viewID = "itemDetail";
        var controller = opts.controller;
        var tourMatcher = new RegExp("^(" + opts.tours.map(function(v){ return v.filter }).join("|") + ")\\d+$");
        var self = this;
        var riot = require('riot');
        var $ = require('jquery');

        getAudio(){
            if (self.item === null || self.item.audio_array === null || typeof self.item.audio_array === "undefined"){
                return [];
            }
            else{
                return self.item.audio_array.map(function(id){ return controller.itemDict['audio'+id];})
            }
        }

        getTags(){
            if (self.item !== null && typeof self.item !== 'undefined' && self.item.tags !== null && typeof self.item.tags !== "undefined"){
                return self.item.tags.split(",").map(function(tag){
                    tag = tag.trim();
                    var match = tag.match(tourMatcher);
                    if (match !== null){
                        tag =  match[1];
                    }
                    return {tag: tag};
                });
            } else {
                return [];
            }
        }

        setFilter(e){
            var item = e.item;
            controller.trigger("UpdateFilter", item.tag);
            riot.route("#Map");
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
                        startSlideshow: false,
                        prevClass: 'prev',
                        nextClass: 'next',
                        onslide: function(index, slide){self.onSlide(index, slide);}
                    }
                );
            }
        }

        onSlide(index, slide){
            var photo = self.getPhotoList()[index];
            self.photoDescription = photo.caption;
            self.photoName = photo.name;
            self.update();
        }

        controller.on('ActivateView', function(view, item){
            self.display = (view==self._viewID);
            self.loadItem(item);
            self.setPanelColor();
        });

        controller.on('ItemSelected', function(item){
            self.loadItem(item);
            self.setPanelColor();
        });


        controller.on('OnTour', function(bool){
            if (bool){
                $('itemDetail').css({"position":"relative","top":"100px"});
                $('listview').css({"position":"relative","top":"100px"});
            }
            else{
                $('itemDetail').css({"position":"relative","top":"0px"});
                $('listview').css({"position":"relative","top":"0px"});
            }
        });

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

        setPanelColor(){
           if (self.item !== null && self.item.tags !== null && typeof self.item.tags !== 'undefined'){
                if (self.item.tags.indexOf('People') !== -1){
                    $('#title').css('background-color', 'rgba(58, 171, 166, 0.7)');
                    $('.audio-name').css('color', 'rgb(58, 171, 166)');
                    $('.glyphicon-volume-up').css('color','rgb(58, 171, 166)');
                    $('.attribution').css('color', 'rgb(151, 202, 199)')
                } 
                else if (self.item.tags.indexOf('Art') !== -1){
                    $('#title').css('background-color', '#9495E8');
                    $('.audio-name').css('color', 'rgb(88, 90, 179)');
                    $('.glyphicon-volume-up').css('color','rgb(88, 90, 179)');
                    $('.attribution').css('color', '#9495E8')
                } 
                else{
                    $('#title').css('background-color', '#A5ABAD');
                    $('.attribution').css('color', 'gray');
                } 
           }
        }

        getPhotoList(){
            if (typeof self.item.photo_array === 'undefined' || self.item.photo_array === null){return false};
            return self.item.photo_array.map(function(id){
                return {
                    href:controller.itemDict["photo"+id].path_medium,
                    name: controller.itemDict["photo"+id].name,
                    caption: controller.itemDict["photo"+id].description
                }
            });
        }

        playAudio(e) {
            var item = e.item
            controller.trigger("playAudio", item)
        }
    </script>
</itemdetail>

