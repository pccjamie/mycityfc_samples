// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require foundation/foundation
//= require foundation/foundation.tooltip
//= require foundation/foundation.orbit
//= require foundation/foundation.dropdown

//more stuff coming

//= require_tree .

//declare mycityfc and globals here

var MYCITYFC = {

    GLOBALS: {

        name: 'GLOBALSVIEW',

        displayAdmin: function () {
            $('#view-tips').on('click', function () {
                $(this).toggleClass('view-on');
                $('.section-title').toggleClass('extra-padding');
                $('.has-tip').toggle();
            });
        },

        fb: function () {

            //FB callback now appends this hash '#_=_' to a page's URL. This JS removes that, as well as controls related impact on page scroll.
            if (window.location.hash && window.location.hash == '#_=_') {
                if (window.history && history.pushState) {
                    window.history.pushState("", document.title, window.location.pathname);
                } else {
                    // Prevent scrolling by storing the page's current scroll offset
                    var scroll = {
                        top: document.body.scrollTop,
                        left: document.body.scrollLeft
                    };
                    window.location.hash = '';
                    // Restore the scroll offset, should be flicker free
                    document.body.scrollTop = scroll.top;
                    document.body.scrollLeft = scroll.left;
                }
            }
//see: http://stackoverflow.com/questions/7131909/facebook-callback-appends-to-return-url


        }




    }
};

$(function () {

    $(document).foundation();
    MYCITYFC.GLOBALS.fb();
    MYCITYFC.GLOBALS.displayAdmin();

});

