MYCITYFC.TEAMSVIEW = {

    name: 'TEAMSVIEW',

    HELPERS: {

        name: '',

        log: function (v) {
            return console.log(v);
        },

        myTeam: function () {
            var myTeam = $('.my-team').text();
        },


        applyScroll: function (div) {
            $(div).tinyscrollbar();
        },

        updateScroll: function (div) {
            $(div).data("plugin_tinyscrollbar").update();
        }

    },

    filterLocalTeamsView: function () {

        var team1 = $('.select-local-team:first');
        team1.addClass('primary');
        $('.select-local-team:not(:first)').addClass('secondary');
        //deal with Foundations inability to correctly place divs for dynamically created elem
        $('.secondary').each(function () {
            $(this).addClass('end');
        });

        //apply logo as background of submit
        $('.local-team').each(function () {
            var logo = $(this).find('.team-logo').text();
            $(this).find('.team-logo-button').css('background-image', 'url(' + logo + ')');
            var league = $(this).find('.team-league').text();

            if (league === 'NASL') {
                $(this).find($('.team-league')).addClass('league-nasl');
            } else {
                $(this).find($('.team-league')).addClass('league-mls');


            }

        });

        $('.local-team').show();

    },
    switchLeagues: function () {
        //init cycle
        $('#js-select-any-team').cycle({});
    },
    listen: function () {

        var inputD = $('input#user_distance'),
            display = $('#user_distance_value span'),
            label = ' &nbsp;miles';
        //inputs initial value is the saved distance. this applies that value to the counter
        display.html(inputD.val());


        //otherwise, listen for change
        inputD.on('input', function () {
            display.html($(this).val());
        });


        //otherwise, listen for change
        inputD.on('mouseup', function () {
            $('#select-distance form').submit();
        });


        $('#select-any-team .any-team').on('click', function () {
            $('#new_user').submit();
        });

    }

};

//ON DOC LOAD
$(function () {

    function scrollToAnchor(aid) {
        var aTag = $("a[name='" + aid + "']");
        $('html,body,#content1, #content2').animate({scrollTop: aTag.offset().top}, 'slow');
    }

    $("a.link-to-anchor").click(function (e) {
        e.preventDefault();
        var href = $(this).attr('href').replace('#', '');
        scrollToAnchor(href);
    });

    //MYCITYFC.HELPERS.applyScroll('.scrollMe');

    MYCITYFC.TEAMSVIEW.filterLocalTeamsView();
    MYCITYFC.TEAMSVIEW.switchLeagues();
    MYCITYFC.TEAMSVIEW.listen();

});


