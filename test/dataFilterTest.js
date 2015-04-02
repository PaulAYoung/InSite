var baseDir= require('./basedir');
var DataFilter = require(baseDir + 'dataFilter');
var testData = require('./testData.json');

var assert = require('chai').assert;

describe('testData', function(){
    it("should filter by tags", function(){
        var filter = new DataFilter(testData);

        var filtered = filter.filter('a');
        assert.equal(7, filtered[0].id);

        var filtered = filter.filter('b');
        assert.equal(6, filtered[0].id);

        filter
    });
})


