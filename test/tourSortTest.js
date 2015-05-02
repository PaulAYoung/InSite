var baseDir= require('./basedir');
var tourSort = require(baseDir + 'tourSort');

var assert = require('chai').assert;
var expect = require('chai').expect;

function regex(item, base){
    return parseInt(item.match(RegExp(base+"(\\d+)"))[1]);
}

describe('tourSort', function(){

    it("regex returns the number after the base term", function(){
        assert.equal(1, regex('bob, hello, tour1', 'tour'));
    });

    it("regex returns double digit number after the base term", function(){
        assert.equal(23, regex('bob, hello, tour23, morestuff', 'tour'));
    });

    it("should sort an array based on the number after the base term", function(){
        expect([{'tags':'tour1'}, {'tags':'tour2'}, {'tags':'tour3'}]).to.deep.equal(tourSort([{'tags': 'tour3'}, {'tags':'tour2'}, {'tags':'tour1'}], 'tour'));
    });

    // it("should sort an array based on the number after the base term", function(){
    //     expect([{'tags':'tour1'}, {'tags':'hello, tour2'}, {'tags':'tour3, blah'}]).to.deep.equal(tourSort([{'tags':'tour3, blah'}, {'tags':'hello, tour2'}, {'tags':'tour1'}], 'tour'));
    // });

})