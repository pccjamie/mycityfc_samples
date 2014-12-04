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
//= require foundation/foundation.reveal
//= require foundation/foundation.dropdown

//= require jquery.cycle2
//= require moment
//= require hoverintent
//= require jquery.tinyscrollbar
//= require youtube

//= require_tree .

MYCITYFC.GLOBALS = {

    name: 'GLOBALSVIEW',

    displayAdmin: function () {
        $('#view-tips').on('click', function () {
            $(this).toggleClass('view-on');
            $('.section-title').toggleClass('extra-padding');
            $('.has-tip').toggle();
        });
    }

};


$(function () {

    $(document).foundation();
    MYCITYFC.GLOBALS.displayAdmin();

});

