<listview>
<ul class="list-group" if={this.display}>
    <li each={ this.items } class="list-group-item" onclick={parent.selectItem}>
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

        // this.on('LocationUpdated', function(pos){
        //     var user_location = L.latLng(pos.coords.latitude, pos.coords.longitude);
        //     self.update();
        // })
        // distanceTo(lat, long){
        //     var user_location = L.latLng(pos.coords.latitude, pos.coords.longitude);
        //     console.log(user_location)
        //     var marker_location= L.latLng(lat, long);
        //     return user_location.distanceTo(marker_location);
        // }

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

    </script>
</listview>

<item>
    <div class="container-fluid">
        <div class="row">
            <p>{ name }</p>
            <span>{ parent.shortenText(description) }</span>
            <span>{ distanceTo(geometry.coordinates[1], geometry.coordinates[0]) }
        </div>
    </div>

</item>


