// InSite options
// Here you can configure your instance of InSite
// All options are held in the opts object
var opts = {
    url: "http://insite.localground.org/api/0/projects/8/?format=jsonp&callback=?", // this should point to the local ground project api you are using. You should use the jsonp datasource.
    appTitle: "Welcome to the Albany Bulb", // This will be displayed on the splash page of the site.
    appDescription: "Listen to audio stories and explore", // This will be placed under the title

    // tags that should have special styling applied to them
    // Markers and items that contain the tags listed here will have css classes applied to them.
    // See config.css for examples.
    // Only the first matching tag will have a class applied. 
    //  eg if a marker is tagged both "art, people". Only the art classes will be used. 
    tagStyles: [
        'art',
        'people'
    ],

    // tags that have been used to identify tours. 
    // See documentation on creating tours TODO: create documentation for creating tours
    //      filter: the filter that will be used to identify markers in the touer
    //      name: the name that should be displayed in the interface
    tours: [
        {filter: 'generaltour', name:"Albany Bulb"},
        {filter: 'arttour',  name:"Art"},
        {filter: 'peopletour', name:"People"}
        ],

    // options for the map
    mapOpts:{
        startLoc: {
            // set the lat/lon coordinates the map should center on when the page first loads
            lat: 37.890378, 
            lon: -122.324725
        },
        startZoom: 16, // initial zoom level
        // url to desired tileserver
        tileUrl: 'https://{s}.tiles.mapbox.com/v4/ardnaseel.kfgj3f5l/{z}/{x}/{y}.png?access_token=pk.eyJ1IjoiYXJkbmFzZWVsIiwiYSI6IkNpTXlHU0UifQ.M20m1nJ01_0olbOTdPJ1oQ'
    },

    // highlighted filters will be displayed in the search menu (opened using the magnifiying glass in upper right)
    //      name: name dispalyed in menu
    //      filter: filter applied when activated
    //      tour: associated tour filter that will be suggested to users when filter is applied
    highlightedFilters: [
        {
            name: "Full Map",
            filter: "",
        },
        {
            name: "Highlights",
            filter: "generaltour"
        },
        {
            name: "Art",
            filter: "Art"
        },
        {
            name: "Former Residents",
            filter: "People"
        }
    ],
    startFilter: "generaltour", // the filter that will be applied on app start
    aboutMarkerID: "marker467" // marker that containes about information - TODO: find better way of implementing this
};

// setup InSite instance
// this line creates an instance of insite, applying the options defnied above
var app = new InSite(opts);

// load app once everything else is loaded
// this sets up the app once all necessary resources are loaded
document.addEventListener('DOMContentLoaded',
    function(){ app.setup() },
    false);
