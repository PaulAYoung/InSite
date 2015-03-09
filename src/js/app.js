var riot = require('riot');
var map = require('./map.tag')
var L = require('leaflet');

function setup(){
    riot.mount('*');
}

document.addEventListener('deviceready', setup, false);
