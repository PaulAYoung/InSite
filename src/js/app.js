var riot = require('riot');
var map = require('./map.tag');
var listView = require('./listView.tag');
var controls = require('./controls.tag');
var L = require('leaflet');
var controller = riot.observable();

function setup(){
    riot.mount('*', {
        controller: controller,
        controls: [
            {title: "Map"},
            {title: "List"}
        ]
    });
    
    // set initial view
    controller.trigger('activate', 'Map');
}


document.addEventListener('deviceready', setup, false);
document.addEventListener('DOMContentLoaded', setup, false);
