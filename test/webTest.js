var baseDir= require('./basedir');
var phantom= require('phantom');

var assert = require('chai').assert;

baseurl = "http://localhost:8080/";

describe("A simple web page test", function(){
    it("title should be InSite", function(done){
        phantom.create(function(ph){
            ph.createPage(function(page){
                page.open(baseurl, function(status){
                    page.evaluate(function(){
                        return document.title;
                    }, function(title){
                        assert.equal("InSite", title);
                    });
                    ph.exit();
                    done();
                });
            });
        });
    });

    it("clicking listView should make map dissappear", function(done){
        phantom.create(function(ph){
            ph.createPage(function(page){
                page.open(baseurl, function(status){
                    page.evaluate(function(){
                            location.href = baseurl + "#List";
                            return $("map").is(":empty");
                        }, function(empty){
                            console.log("test");
                            assert.isTrue(empty);
                        });
                    ph.exit();
                    done();
                });
            });
        });
    });

});
