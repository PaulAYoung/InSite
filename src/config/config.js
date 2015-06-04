// InSite options
var opts = {
    url: "http://insite.localground.org/api/0/projects/8/?format=jsonp&callback=?",
    appTitle: "Welcome to the Albany Bulb",
    appDescription: "Listen to audio stories and explore",
    tours: [
        {filter: 'generaltour', name:"Albany Bulb"},
        {filter: 'arttour',  name:"Art"},
        {filter: 'peopletour', name:"People"}
        ],
    mapOpts:{
        startLoc: {
            // lat: 37.8899,
            // lon: -122.324721
            lat: 37.890378, 
            lon: -122.324725
        },
        startZoom: 16,
        tileUrl: 'https://{s}.tiles.mapbox.com/v4/ardnaseel.kfgj3f5l/{z}/{x}/{y}.png?access_token=pk.eyJ1IjoiYXJkbmFzZWVsIiwiYSI6IkNpTXlHU0UifQ.M20m1nJ01_0olbOTdPJ1oQ'
    },
    highlightedFilters: [
        {
            name: "Full Map",
            filter: "",
        },
        {
            name: "Highlights",
            filter: "generaltour",
            tour: "generaltour"
        },
        {
            name: "Art",
            filter: "Art",
            tour: "arttour"
            // iconClass: "glyphicon glyphicon-asterisk"
        },
        {
            name: "Former Residents",
            filter: "People",
            tour: "peopletour"
            // iconClass: "glyphicon glyphicon-home"
        }
    ],
    startFilter: "generaltour",
    aboutMarkerID: "marker467"
};

// setup InSite instance
var app = new InSite(opts);

// load app once everything else is loaded
document.addEventListener('DOMContentLoaded',
    function(){ app.setup() },
    false);
