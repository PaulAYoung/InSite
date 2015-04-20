var AbstractBrowser = require('mock-browser').delegates.AbstractBrowser;
var MockBrowser = require('mock-browser').mocks.MockBrowser;
GLOBAL.window = MockBrowser.createWindow();
GLOBAL.document = MockBrowser.createDocument();

var browser = new AbstractBrowser({window: window});
GLOBAL.navigator = browser.getNavigator();

var baseDir= require('./basedir');
var geoSort = require(baseDir + 'geoSort');
var testData = require('./testData.json');

var assert = require('chai').assert;

describe('geoSort', function(){
    it('item 7 should be nearest', function(){
        assert.equal(7, geoSort([-122.32779622077942, 37.89016347485787], testData)[0].id);
    });
});
