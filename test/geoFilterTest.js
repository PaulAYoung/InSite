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
    it("should not return any items for zero max distance", function(){
        assert.equal(0, geoFilter([1, 1], items, 0).length);
    });
});
