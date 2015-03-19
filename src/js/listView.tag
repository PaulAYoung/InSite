<listview>
<ul class="list-group" if={ this.display }>
        <li class="list-group-item">Amber's Wish</li>
        <li class="list-group-item">Something</li>
        <li class="list-group-item">Something</li>
        <li class="list-group-item">Something</li>
        <li class="list-group-item">Something</li>
        <li class="list-group-item">Something</li>
        <li class="list-group-item">Something</li>
    </ul>

    <script>
        this.display=false;
        controller = opts.controller;
        var self = this;

        controller.on('activate', function(title){
            console.log(title);
            self.display = (title=='List');
            self.update();
        });
    </script>
</listview>
