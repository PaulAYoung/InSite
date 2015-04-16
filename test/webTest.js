var baseDir= require('./basedir');
var phantom= require('phantom');

var assert = require('chai').assert;

baseurl = "http://localhost:8080/";

function jsLoaded(){
    /**
     * Should be executed in page.evaluate
     * triggers phantom callback once all scripts have been loaded
     */

    document.addEventListener("DOMContentLoaded", function(){
        console.log("calling phantom");
        window.callPhantom();
    }, false);
}

describe("A simple web page test", function(){
    this.timeout(10000);
    it("title should be InSite", function(done){
        phantom.create(function(ph){
            ph.createPage(function(page){
                page.open(baseurl, function(status){
                    page.evaluate(function(){
                        return document.title;
                    }, function(title){
                        ph.exit();
                        assert.equal("InSite", title);
                        done();
                    });
                });
            });
        });
    });

    it("clicking listView should make map dissappear", function(done){
        phantom.create(function(ph){
            ph.createPage(function(page){
                page.open(baseurl, function(status){
                    page.onInitialized = function(){
                        page.onCallback = function() {
                                page.evaluate(function(){
                                return test;
                            }, function(empty){
                                console.log(empty);
                                ph.exit();
                                assert.isTrue(empty);
                                done();
                            });
                        }
                    }
                    page.evaluate(jsLoaded);
                });
            });
        });
    });
});
