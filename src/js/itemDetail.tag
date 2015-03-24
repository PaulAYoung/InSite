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

        
        controller.on('ItemSelected', function(item){
            console.log(item);
            self.item = item;
            controller.trigger("ActivateView", "itemDetail");
        });

        controller.on('ActivateView', function(title){
            self.display = (title=='itemDetail');
            self.update();
        });

    </script>
</itemdetail>

