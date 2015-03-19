<listview>
<ul class="list-group" if={ this.display }>
        <li class="list-group-item">
            <div class="container-fluid">
                <div class="row">
                    <div class="col-xs-2">
                        <span class="glyphicon glyphicon-volume-up" aria-hidden="true"></span>
                        <span class="sr-only">Audio:</span>
                    </div>
                    <div class="col-xs-10">
                        <h4>Amber's Wish</h4>
                        Let's see how much text can feasibly fit on here. This is a description of the...
                    </div>
                </div>
            </div>
        </li>
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
