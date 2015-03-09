<listview>
<ul if={ this.display }>
        <li>Amber's Wish</li>
        <li>Something</li>
        <li>Something</li>
        <li>Something</li>
        <li>Something</li>
        <li>Something</li>
        <li>Something</li>
    </ul>

    <script>
        this.display=false;
        this.controller = opts.controller;
        var self = this;

        this.controller.on('activate', function(title){
            console.log(title);
            self.display = (title=='List');
            self.update();
        });
    </script>
</listview>
