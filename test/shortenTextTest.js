var baseDir= require('./basedir');
var shortenText = require(baseDir + 'shortenText');

var assert = require('chai').assert;

describe('shortenText', function(){
    it("should shorten one word into one word", function(){
        assert.equal('word', shortenText('word',4));
    });

    it("should not split a word when specified character count splits a word", function(){
        assert.equal('Sandra is ...', shortenText('Sandra is cool', 12));
    });

    // it("should not add ... after text that is already below character count", function(){
    //     assert.equal('Sandra is cool', shortenText('Sandra is cool', 14));
    // });
})


