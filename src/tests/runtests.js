document.addEventListener(
    'DOMContentLoaded',
    function(){
        if (window.mochaPhantomJS){mochaPhantomJS.run()}
        else {
            window.mocha = require('mocha');
            mocha.run()
        }
    },
    false
);
