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

    it("should be able to add individual items", function(){
        var set = new SimpleSet(itemsA);
        set.add("q");
        assert.isTrue(set.contains("q"));
    });

    it("should be able to remove individual items", function(){
        var set = new SimpleSet(itemsA);
        set.remove("b");
        assert.isFalse(set.contains("b"));
    });

    it("should allow another set to be added", function(){
        var set = new SimpleSet(itemsA);
        set.addAll(new SimpleSet(itemsB));

        assert.includeMembers(set.items(), itemsB);
    });

    it("should allow another set to be removed", function(){
        var set = new SimpleSet(itemsA);
        set.removeAll(new SimpleSet(["a", "b"]));

        assert.isFalse(set.contains("a"));
        assert.isFalse(set.contains("b"));
    });

    it("should check if set contains other set", function(){
        var set = new SimpleSet(itemsA);
        set.addAll(new SimpleSet(itemsB));

        assert.isTrue(set.containsAll(["a", "b", "d", "e"]));
        assert.isTrue(set.containsAll(new SimpleSet(["a", "b", "d", "e"])));
    });
    
})
