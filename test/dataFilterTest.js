var baseDir= require('./basedir');
var DataFilter = require(baseDir + 'dataFilter');
var testData = require('./testData.json');

var assert = require('chai').assert;

var filter = new DataFilter(testData);

describe('DataFilter', function(){
    it("should filter by tags", function(){
        var filtered = filter.filter('a');
        assert.equal(7, filtered[0].id);

        var filtered = filter.filter('b');
        assert.equal(6, filtered[0].id);

        filter
    });
    
    it("empty list should filter to empty", function(){
        var filter = new DataFilter([]);
        var filtered = filter.filter('a');
        assert.equal(0, filtered.length);

    });

    it("empty filter should return full list", function(){
        var filtered = filter.filter('');
        assert.equal(testData.length, filtered.length);
    })

    it("should also filter by item name", function(){
        var filtered = filter.filter("Hobbit House");
        assert.equal(6, filtered[0].id);
    });

    it("should be case insensitive", function(){
        var filtered = filter.filter("q");
        assert.equal(1, filtered[0].id);
    });
    
    it("should return full list if no arguments", function(){
        var filtered = filter.filter();
        assert.equal(testData.length, filtered.length);
    });
})


