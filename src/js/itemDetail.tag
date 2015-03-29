<itemdetail>
<div class="list-group" if={this.display}>
    {item.name}
    <br>
    {item.description}
</div>

    <script>
        this.display=false;
        this.items = null;
        var controller = opts.controller;
        var self = this;

        controller.on('ActivateView', function(view, item){
            self.display = (view=='itemDetail');
            if (controller.itemDict !== null && item in controller.itemDict){
                self.item = controller.itemDict[item];
            }else{
                self.item = {name: "Not found", description: "not found"};
            }

            self.update();
        });

    </script>
</itemdetail>

