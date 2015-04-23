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
        // console.log(controller.itemDict);

        controller.on('ActivateView', function(title){
            self.display = (title=='List');
            self.update();
        });
        
        controller.on('ItemsUpdated', function(items){
            self.items = controller.markers;
            console.log(controller.itemDict);
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

        getDescription(){
            item_child = [];
            for (var i=0, item, copy, l = self.items.length; i<l, item=self.items[i]; i++){
                copy = Object.create(item);
                copy.description= copy.description.substring(0,10);
                item_child.push(copy);
            }
            console.log(item_child);
            return item_child;
            
        }

        shortenText(description){
            // var shortDescription = description.substring(0,10);
            var text_array = description.split(" ");
            return text_array.slice(0,19).join(" ");
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
            <img src={ parent.getPhoto(photo_array) }> 
            <p>{ name }</p>
            <span>{ parent.shortenText(description) }</span>
            <span>{ parent.distanceTo(geometry.coordinates[1], geometry.coordinates[0]) }
        </div>
    </div>

</item>


