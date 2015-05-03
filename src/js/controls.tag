<controls>
    <div class="navbar navbar-inverse navbar-fixed-top" role="navigation">
      <div class="container">
        <div class="navbar-header">
          <button type="button" class="navbar-toggle navbar-toggle-brand" data-toggle="collapse" data-target=".navbar-collapse1">
            <a class="navbar-brand">InSite</a>
            </button>
          <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
            <span style="color:white; margin-right:.5em;">{ this.filter }</span>
            <span style="color: white;" class="glyphicon glyphicon-search" aria-hidden="true"></span>
            <span class="sr-only">Search:</span>
          </button>
          
            <ul class="nav nav-pills">
                <li role="presentation"  ><a href='#Map'><img class="mapIcon" src="fonts/noun_24173_cc.svg"></img></a></li>
                <li role="presentation"  ><a href='#List'><span style="color:white;" class="glyphicon glyphicon-list"></span></a></li>
                <li role="presentation" onclick={ this.locateMe }><a href=""><img class="locateIcon" src="fonts/noun_40972_cc.svg"></img></a></li>
            </ul>
        </div>
        <div class="navbar-collapse1 collapse" name="itemSearch2">
            <ul class="nav navbar-nav">
                <li><a href="index.html">Home</a><li>
                <li><a href="">About</a></li>
            </ul>
        </div>
        <div class="navbar-collapse collapse" name="itemSearch">
            <form class="navbar-form navbar-left" role="search" onsubmit={ this.search }>
                <ul class="nav navbar-nav">
                    <li each={ opts.highlightedFilters } onclick={ parent.applyFilter } >
                        <a href="">
                            <span if= { iconClass } class={ iconClass }></span>
                            { name }
                        </a>
                    </li>
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
        this.filter = "";
        window.search = this.itemSearch;

        var self = this;

        this.on('mount', function(){
            $(self.itemSearch).on("shown.bs.collapse", function(){
                self.searchbox.focus();
            });
        });

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
        
        updateFilter(filter){
            controller.trigger("UpdateFilter", filter);
            $(this.itemSearch).collapse("hide");
            $(this.itemSearch2).collapse("hide");

            if (filter !== ""){
                this.filter = "Filter: " + filter;
            }else{
                this.filter = "";
            }
        }

        locateMe(){
            controller.trigger('LocateMe');
        }

        search(e){
            e.preventDefault();
            console.log(this.searchbox.value);
            this.updateFilter(this.searchbox.value);
        }

        reset(e){
            this.updateFilter("");
        }

        applyFilter(e){
            var item = e.item;
            this.updateFilter(item.name);
        }
    </script>
</controls>
