var assert = require('chai').assert;
var Zombie = require('zombie');


describe('basic web tests', function(){
    var browser = new Zombie();

    before(function(done){
        browser.visit("http://localhost:8080/", function(){
            done();
        });
    });

    it("should load the page", function(){
        browser.assert.text("title", "InSite");
    });
});
