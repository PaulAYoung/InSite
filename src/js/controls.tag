<controls>
    <div class="controlArea">
        <div each={ opts.controls } onclick={ parent.activate } class={ parent.isActive(title) }>
            <a >{ title }</a>
        </div>
    </div>

    <style scoped>
        :scope{
            width: 100%;
            display: inline-block;
        }

        .controlArea{
            width: 100%;
        }

        .active{
            background-color: #ccc;
        }

        .control{
            float: left;
            margin: 0em .5em;
        }
    </style>

    <script>
        var controller = opts.controller;
        this.currentActive = opts.controls[0].title;

        activate(e){
            var item = e.item
            controller.trigger('activate', item.title)
            this.currentActive = item.title;
            this.update();
        }

        isActive(title){
            if (title===this.currentActive){
                return "control active";
            } else {
                return "control";
            }
        }

    </script>
</controls>
