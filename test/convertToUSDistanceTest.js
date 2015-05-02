var baseDir= require('./basedir');
var convertToUSDistance = require(baseDir + 'convertToUSDistance');

var assert = require('chai').assert;

describe('convertToUSDistance', function(){

    it("1 meter should equal 3.28 feet", function(){
        assert.equal(3.28, convertToUSDistance(1).num);
        assert.equal('ft',convertToUSDistance(1).unit);
    });

    it("1001 ft (305.1048m) should return .19 mile", function(){
        assert.equal(.19, convertToUSDistance(305.1048).num);
        assert.equal('mi', convertToUSDistance(305.1048).unit);
    });

    it("1000 ft (304.8m) should return 1000 ft", function(){
        assert.equal(1000, convertToUSDistance(304.8).num);
        assert.equal('ft', convertToUSDistance(304.8).unit);
    });

})


