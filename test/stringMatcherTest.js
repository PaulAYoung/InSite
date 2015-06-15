var baseDir= require('./basedir');
var stringMatcher = require(baseDir + 'stringMatcher');

var assert = require('chai').assert;

var matcher = new stringMatcher(['a', 'b', 'c'], "default");

describe('DataFilter', function(){
    it("should match a", function(){
        assert.equal("a", matcher.firstMatch('a'));
    });

    it("should return false", function(){
        assert.isFalse(matcher.firstMatch('f'));
    });
});
