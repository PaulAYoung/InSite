<listview>
<ul class="list-group" if={this.display}>
    <li each={ this.items } if={ description || photo_array || audio_array } class="list-group-item" onclick={parent.selectItem}>
            <item> </item>
    </li>
</ul>

    <script>
        var L = require('leaflet');
        this.display=false;
        this.items = [];
        var controller = opts.controller;
        var riot = require('riot');
        var self = this;

        controller.on('ActivateView', function(title){
            self.display = (title=='List');
            self.update();
        });
        
        controller.on('ItemsUpdated', function(items){
            self.items = controller.markers;
            self.update();
        });

        selectItem(e) {
            var item = e.item
            controller.trigger("ItemSelected", item)
            riot.route("itemDetail/" + item.overlay_type + item.id)
        }

        distanceTo(lat, lon){
            var user_location_marker = L.latLng(controller.loc['lat'], controller.loc['lon']);
            var marker_location= L.latLng(lat, lon);
            //convert distance from meters to ft
            return String(Math.round(user_location_marker.distanceTo(marker_location) * 3.28084))+" ft";
        }

        shortenText(description){
            var text_array = description.split(" ");
            var shortened_text='';
            for (var i=0; i<text_array.length; i++){
                if (shortened_text.length < 50){
                    shortened_text=shortened_text+text_array[i]+" ";
                }
            }
            return shortened_text+"...";
        }

        getPhoto(photo_array){
            if (typeof photo_array === 'undefined' || photo_array === null){return false};
            return controller.itemDict['photo'+photo_array[0]]['path_small'];
        }


    </script>
</listview>

<item>
    <div class="container-fluid">
        <div class="row">
            <div class="col-xs-3 col-md-3">
                <div class="thumbnail-div">
                <img class="thumbnail-photo" src={ parent.getPhoto(photo_array) } >
                </div> 
            </div>
            <div class="col-xs-9 col-md-9">
                <div class="row description-row">
                    <div class="col-xs-12 col-md-12">
                        <h4>{ name }</h4>
                        <span if={ this.description }>{ parent.shortenText(description) }</span>
                    </div>
                    <div class="col-xs-9 col-md-9">
                         <!-- add two line breaks if there is no description so the distance text aligns to the bottom of div-->
                        <span if={ this.description == false }><br></span>
                        <span if={ this.audio_array } class="glyphicon glyphicon-volume-up"></span>
                    </div>
                    <div class="col-xs-3 col-md-3">
                        <!-- add two line breaks if there is no description so the distance text aligns to the bottom of div-->
                        <span if={ this.description == false }><br><br></span>
                        <span class="distance">{ parent.distanceTo(geometry.coordinates[1], geometry.coordinates[0]) }</span>
                    </div>
                </div>
            </div>
        </div>
    </div>

</item>


