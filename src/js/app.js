var riot = require('riot');
var map = require('./map.tag');
var listView = require('./listView.tag');
var controls = require('./controls.tag');
var L = require('leaflet');
var Connector = require('./localground_connector');
var itemDetail = require('./itemDetail.tag');
var audioPlayer = require('./audioPlayer.tag');
var Controller = require('./controller');

// set up jquery/bootstrap
var jQuery = require('jquery');
window.jQuery = jQuery;
window.$ = jQuery;
var bootstrap = require('bootstrap');

var controller = new Controller();

var opts = {
        controller: controller,
        url: "http://insite.localground.org/api/0/projects/2/?format=jsonp&callback=?",
        controls: [
            {title: "Map"},
            {title: "List"}
        ]
    };

var connector = new Connector(opts);

function setup(){
    riot.mount('*', opts);
    
    // set initial view
    controller.trigger('StartApp');
}

document.addEventListener('deviceready', setup, false);
document.addEventListener('DOMContentLoaded', setup, false);
