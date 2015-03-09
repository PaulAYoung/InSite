<controls>
    <div class="controlArea">
        <div each={ opts.controls } class="control">
            <a onclick={ parent.activate }>{ title }</a>
        </div>
    </div>

    <script>
        this.controller = opts.controller;
        activate(e){
            var item = e.item
            this.controller.trigger('activate', item.title)
            console.log(item.title);
        }
    </script>
</controls>
