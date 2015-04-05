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
        this._viewID = "itemDetail";
        var controller = opts.controller;
        var self = this;

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

    </script>
</itemdetail>

