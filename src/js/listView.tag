<listview>
<ul class="list-group" if={this.display}>
    <li each={this.items} class="list-group-item" onclick={parent.selectItem}>
            <item> </item>
    </li>
</ul>

    <script>
        this.display=false;
        this.items = null;
        var controller = opts.controller;
        var self = this;

        controller.on('ActivateView', function(title){
            self.display = (title=='List');
            self.update();
        });
        
        controller.on('ItemsUpdated', function(items){
            console.log(items);
            self.items = items;
            self.update();
        });

        selectItem(e) {
        console.log(e.item)
        controller.trigger("ItemSelected", e.item)
        }

    </script>
</listview>

<item>
    <div class="container-fluid">
        <div class="row">
            test
            <span>{ overlay_type + ': ' + name }</span>
        </div>
    </div>

</item>


