var AbstractBrowser = require('mock-browser').delegates.AbstractBrowser;
var MockBrowser = require('mock-browser').mocks.MockBrowser;
GLOBAL.window = MockBrowser.createWindow();
GLOBAL.document = MockBrowser.createDocument();

var browser = new AbstractBrowser({window: window});
GLOBAL.navigator = browser.getNavigator();

var baseDir= require('./basedir');
var DataFilter = require(baseDir + 'dataFilter');


var geoFilter = require(baseDir + 'geoFilter');
var testData = require('./testData.json');
var L = require('leaflet');

var assert = require('chai').assert;

var items = new DataFilter(testData).filter("");

describe("geoFilter", function(){
    it("should only return all items for big number", function(){
        geoFilter([-122.32779622077942, 37.89016347485787], items, 9999999999999999999)
    });
});
