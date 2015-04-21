var assert = require('chai').assert;
var Zombie = require('zombie');
/**
 * Not working
 *
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

    it("map should hide if list is active", function(done){
        browser.visit("location.href=http://localhost:8080/#List", function(){
            browser.assert.evaluate("$('map').html().trim()===''");
        });
    });
});
**/
