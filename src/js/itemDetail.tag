<itemdetail>
<div class="list-group" if={this.display}>
    {item.name}
    <br>
    {item.description}
</div>

    <script>
        this.display=false;
        this.items = null;
        this.item_id = null;
        var controller = opts.controller;
        var self = this;

        controller.on('ActivateView', function(view, item){
            console.log(arguments);
            self.display = (view=='itemDetail');
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

    </script>
</itemdetail>

