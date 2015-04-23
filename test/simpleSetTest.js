var baseDir= require('./basedir');
var SimpleSet = require(baseDir + 'simpleSet');

var assert = require('chai').assert;

var itemsA = ["a", "b", "c"];
var itemsB = ["d", "e", "f"];
var itemsC = ["g", "h", "i"];

describe("simple set", function(){
    it("should allow items to be added", function(){
        var set = new SimpleSet(itemsA);
        assert.isTrue(set.contains("a"));
        assert.isTrue(set.contains("b"));
        assert.isTrue(set.contains("c"));
    });

    it("should not have items that are not added", function(){
        var set = new SimpleSet(itemsA);
        assert.isFalse(set.contains("d"));
    });
    
    it("should return list of items", function(){
        var set = new SimpleSet(itemsA);
        var items = set.items();
        assert.includeMembers(itemsA, set.items())
    });
})