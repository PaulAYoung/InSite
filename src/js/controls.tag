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
          <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse2">
            <span style="color: white;" class="glyphicon glyphicon-search" aria-hidden="true"></span>
            <span class="sr-only">Search:</span>
          </button>
          <a class="navbar-brand" href="index.html">InSite</a>

            <ul class="nav nav-pills">
                <li role="presentation" each={ opts.controls } class={ parent.isActive(title) }><a href={ '#'+  title  }>{ title }</a></li>
            </ul>
        </div>
        <div class="navbar-collapse collapse">
          <ul class="nav navbar-nav">
            <li><a href="#">About</a></li>
            <li><a href="#">Settings</a></li>
          </ul>
        </div>
        <div class="navbar-collapse2 collapse">
            <form class="navbar-form navbar-left" role="search" onsubmit={ this.search }>
                <ul class="nav navbar-nav">
                    <li onclick={ this.searchArt }><a href="">Art</a></li>
                    <li><a href="">People</a></li>
                  </ul>
                <div class="form-group">
                    <input type="text" name="searchbox" class="form-control" placeholder="Search">
                </div>
                <button type="submit" class="btn btn-default">Submit</button>
            </form>
        </div>
      </div>
    </div>


    <script>
        var controller = opts.controller;
        this.currentActive = opts.controls[0].title;

        activate(e){
            var item = e.item
            controller.trigger('ActivateView', item.title)
            this.currentActive = item.title;
            this.update();
        }

        isActive(title){
            if (title===this.currentActive){
                return "active";
            } 
        }

        search(e){
            e.preventDefault();
            console.log(this.searchbox.value);
            controller.trigger("UpdateFilter", this.searchbox.value);
        }

        searchArt(e){
            controller.trigger("UpdateFilter", "art");
        }

    </script>
</controls>
