var riot = require('riot');

var map = require('./map.tag');
var welcome = require('./welcome.tag');
var listView = require('./listView.tag');
var controls = require('./controls.tag');
var tour = require('./tour.tag');

var L = require('leaflet');
var Connector = require('./localground_connector');
var itemDetail = require('./itemDetail.tag');
var audioPlayer = require('./audioPlayer.tag');
var Controller = require('./controller');
var GeoQuerier = require('./geoQuerier.js');
var welcome = require('./welcome.tag');

// set up jquery/bootstrap
var jQuery = require('jquery');
window.jQuery = jQuery;
window.$ = jQuery;
var bootstrap = require('bootstrap');
var blueimpgallery = require('./blueimp-gallery');

var opts = require('./options.json');

var controller = new Controller();

opts.controller = controller;


var connector = new Connector(opts);
var geoQuerier = new GeoQuerier(opts);

function setup(){
    riot.mount('*', opts);
    
    // set initial view
    controller.trigger('StartApp');
}

document.addEventListener('deviceready', setup, false);
document.addEventListener('DOMContentLoaded', setup, false);
