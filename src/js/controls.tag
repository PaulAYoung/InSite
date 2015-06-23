<controls>
    <div class="navbar navbar-inverse navbar-fixed-top container-fluid controls-container" role="navigation">
        <div class="row">
            <div class="btn-group insite-menu-button">
              <button type="button" class="btn btn-default insite-button" data-toggle="collapse" data-target=".insite-menu">
                  <a class="navbar-brand"><img width="60" src="fonts/InSite_logo_web.png"></a>
              </button>
            </div>


                <div class="nav-buttons">
                    <a href='#Map'><img class="mapIcon" src="fonts/noun_24173_cc.svg"></img></a>
                    <a href='#List'><span style="color:white;" class="glyphicon glyphicon-list"></span></a>
                    <a href="#"><img class="locateIcon" src="fonts/noun_40972_cc.svg"></img></a>
                    <button class="btn btn-default insite-button" data-toggle="collapse" data-target=".tour-list">
                        <span>Tours</span>
                    </button>
                </div>
            
            <button type="button" class="btn btn-default insite-button float-right" data-toggle="collapse" data-target=".suggested-filters">
                <span class="glyphicon glyphicon-search"></span>
            </button>
        </div>

        <!-- expanding elements --!>

        <div class="row collapse insite-menu">
            <ul class="">
              <li><a href="index.html">Home</a><li>
              <li><a href="#itemDetail/{opts.aboutMarkerID}">About</a></li>
          </ul>
        </div>

        <div class="tour-list row collapse">
            <ul class="">
                <li class="list-unstyled" each={ opts.tours }>
                    <a href="">
                        { name }
                    </a>
                </li>
            </ul>
        </div>


        <div class="suggested-filters row collapse" name="itemSearch">
            <ul class="">
                <li class="list-unstyled" each={ opts.highlightedFilters } onclick={ parent.applyFilter } >
                    <a href="">
                        { name }
                    </a>
                </li>
            </ul>
            <div class="form-group">
                <form onsubmit={ search }>
                    <input type="text" name="searchbox" class="form-control" placeholder="Search">
                    <button type=submit class="btn btn-default">Submit</button>
                </form>
            </div>
        </div>
    </div>

    <script>
        var controller = opts.controller;
        this.filter = "";
        window.search = this.itemSearch;

        var self = this;

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
                this.filter = ("Filter: " + filter).substring(0,16);
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
            e.preventDefault();
            var item = e.item;
            this.updateFilter(item.filter);
            return false;
        }
    </script>
</controls>
