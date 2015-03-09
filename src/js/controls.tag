<controls>
    <div each={ opts.controls } class="control" onclick={ parent.activate }>
        { title }
    </div>

    <script>
        function activate(e){
            var item = e.item;
            this.trigger('active-control', item.title);
        }
    </script>
</controls>
