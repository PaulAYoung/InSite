<controls>
    <div class="navbar navbar-inverse navbar-fixed-top" role="navigation">
      <div class="container">
        <div class="navbar-header">
          <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
            <span class="sr-only">Toggle navigation</span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </button>
          <a class="navbar-brand" href="index.html">InSite</a>

            <ul class="nav nav-pills">
              <li role="presentation" class="active"><a href="#">Map</a></li>
              <li role="presentation"><a href="#">List</a></li>
            </ul>

        </div>
        <div class="navbar-collapse collapse">
          <ul class="nav navbar-nav">
            <li><a href="about.html">About</a></li>
            <li><a href="research.html">Settings</a></li>
          </ul>
        </div>
      </div>
    </div>
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
