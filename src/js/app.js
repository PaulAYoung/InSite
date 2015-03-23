var riot = require('riot');
var map = require('./map.tag');
var listView = require('./listView.tag');
var controls = require('./controls.tag');
var L = require('leaflet');
var Connector = require('./localground_connector');

// set up jquery/bootstrap
var jQuery = require('jquery');
window.jQuery = jQuery;
window.$ = jQuery;
var bootstrap = require('bootstrap');

var controller = riot.observable();

var opts = {
        controller: controller,
        url: "http://insite.localground.org/api/0/projects/2/?format=json",
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
    controller.trigger('ActivateView', 'Map');
}


document.addEventListener('deviceready', setup, false);
document.addEventListener('DOMContentLoaded', setup, false);
