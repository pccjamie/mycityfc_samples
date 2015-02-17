//pattern - create module, assign to var, fill with stuff

var MYCITYFC = {

    HELPERS: {

        name: '',

        log: function (v) {
            return console.log(v);
        },

//        myTeam: function () {
//            var myTeam = $('.my-team').text();
//        },

        applyScroll: function (div) {
            $(div).tinyscrollbar();
        },

        updateScroll: function (div) {
            $(div).data("plugin_tinyscrollbar").update();
        }

    },

    MAIN: {

        name: 'MYCITYFCVIEW',

        // TODO edit dates
        filterSchedule: function () {

            var today = moment().format('MM-DD-YYYY'),
                nextYear = moment().add(1, 'years').format('YYYY'),
                schedule = $('#js-schedule'),
//                nextGameContainer = $('#js-next-game'),
                nextGameHeader = $('#js-next-game header h2'),
                game = $('.js-single-game'),
                games = game.toArray(),
                extLinks = $('#ext-links'),
                myTeam = $('#nav-primary ul:nth-of-type(2) li a:first').html();


            //look at ALL games which have been returned by scrape
            $(games).each(function () {

                //local var
                var game = $(this),
                    gameDate = moment(game.children('.game-date').text()).format('MM-DD-YYYY'); //removes day of week for calc.

                console.log('----var gameDate ----');
                console.log(gameDate + ':' + typeof gameDate);
                console.log('----var today ----');
                console.log(today + ':' + typeof today);

                if (gameDate < today) {

                    //TODO handle this
                    game.wrap('<a>');
                    game.parent('a').attr('href', function () {
                        return game.find('.sch_matchcenter').attr('href');
                    });
                    game.children('.game-links').remove();

//                var obj = game[0];
//                var div = obj.firstElementChild;
//                var text = $(div)[0];
//                text = $(text)[0];
//                cl($(text).text().trim());
//                var oldD = $(text).text().trim();
//                var newD = moment(oldD).format('MM-DD-YYYY');
//                cl(newD);
//                var t = $(game).children('.game-date').text(newD);

                } else if (gameDate >= today) {

                    game.appendTo(schedule);
                    $(".js-single-game:first").appendTo('#js-next-game-section #js-next-game');

                    if (gameDate === today) {
//                    var logo = $(this).find('.field-home-team-logo img').attr("src");
//                    var tickets = $(this).find('.sch_tickets').css('background-image', 'url(' + logo + ')');
                        $('#js-gameday-trigger').css('display', 'block');
                        $(nextGameHeader).text("MatchDay!");
                        $(this).find('.game-links .row:nth-child(1)').prepend('<div id="label-tv" class="small-3 columns">Watch On:</div>');
                        $(this).find('.game-links .row:nth-child(2)').prepend('<div id="label-other" class="small-3 columns">Tickets:</div>');
                        $('#js-gameday').show();

                    }

                }

                //TODO determine whether any part of this needs to stay within this loop
//                //limit displayed games
//                var remainingGames = schedule.children(game),
//                //TODO make limit adjustable
//                    limit = 3;
////                if (remainingGames.length === 0) {
//
//                    $('#js-next-game-section #js-next-game').append('Offseason! Your team will return to the pitch in '+nextYear);
//
//                } else {
//                    if (remainingGames.length > limit) {
//                        remainingGames.slice(limit).hide();
//                        extLinks.show();
//                    } else {
//                        extLinks.hide();
//                    }
//                }

                //adds class to each game for Results filter
                var gameType = $(this).children('.game-competition').text();
                console.log('----var gameType ----');
                console.log(gameType + ':' + typeof gameType);
                switch (gameType) {

                    case "MLS Regular Season":
                        $(this).addClass('type-mls-reg');
                        break;
                    case "MLS Cup":
                        $(this).addClass('type-mls-cup');
                        break;
                    case "CCL":
                        $(this).addClass('type-ccl');
                        break;
                    case "Friendly":
                        $(this).addClass('type-friendly');
                        break;
                    case "Open Cup":
                        $(this).addClass('type-natl-us');
                        break;
                    default:
                        $(this).addClass('type-other');
                }


            });

            //limit displayed games
            var remainingGames = schedule.children(game),
            //TODO make limit adjustable
                limit = 3;

            //TODO function to account for offseason. WIP / A
            if (remainingGames.length === 0) {
                $('#js-next-game-section #js-next-game').append('Your ' + myTeam + ' will return to the pitch in ' + nextYear + '. Schedule details are not yet available.');
            } else {
                if (remainingGames.length > limit) {
                    remainingGames.slice(limit).hide();
                    extLinks.show();
                } else {
                    extLinks.hide();
                }
            }

        },

        filterGames: function () {

            var gameOver = "#js-game-results-section .js-single-game";

//        function highlight(v) {
//            var kl = $(v).attr('class');
//            kl = $(kl).text();
//            console.log($(kl));
//            $(v).addClass('is-active').siblings('li').removeClass('is-active');
//
//        }
//
            //set up filter behavior
            $('ul.competitions li').hoverIntent(function () {
                var name = $(this);
                var k = $(this).attr('class');
                $(name).addClass('is-active').siblings('li').removeClass('is-active');
                //reset scroll position on tab switch
                MYCITYFC.HELPERS.updateScroll($('.scrollMe'));

            });

            //handles display based on filter

            $("li.type-all").hover(function () {
                $(gameOver).show();
            });

            $("li.type-mls-reg").hover(function () {

                $(gameOver + ".type-mls-reg").show();
                $(gameOver + ":not('.type-mls-reg')").hide();
            });
//
            $("li.type-mls-cup").hover(function () {

                $(gameOver + ".type-mls-cup").show();
                $(gameOver + ":not('.type-mls-cup')").hide();
            });

            $("li.type-ccl").hover(function () {

                $(gameOver + ".type-ccl").show();
                $(gameOver + ":not('.type-ccl')").hide();
            });

            $("li.type-natl-us").hover(function () {

                $(gameOver + ".type-natl-us").show();
                $(gameOver + ":not('.type-natl-us')").hide();
            });

            $("li.type-natl-can").hover(function () {
                $(gameOver + ".type-natl-can").show();
                $(gameOver + ":not('.type-natl-can')").hide();
            });

            $("li.type-friendly").hover(function () {
                $(gameOver + ".type-natl-can").show();
                $(gameOver + ":not('.type-natl-can')").hide();
            });

            $("li.type-other").hover(function () {
                $(gameOver + ".type-other").show();
                $(gameOver + ":not('.type-other')").hide();
            });
        },

        formatChannel: function (sentVal) {

            var nbcsn = "NBCSN",
                nbc = "NBC",
                bein = "BEIN SPORT",
                espn = "ESPN",
                espn2 = "ESPN2",
                watchESPN = "WatchESPN",
                mls = "MLS LIVE",
                unimas = "UniMas",
                tsn = "TSN",
                tsn2 = "TSN2";

            var channels = [
                nbc, nbcsn, mls, unimas, bein, espn, espn2, watchESPN, tsn, tsn2];

            if ($.inArray(sentVal, channels) > -1) {

                switch (sentVal) {
                    case unimas:
                        return "http://unimas.com";
                        break;
                    case mls:
                        return "https://live.mlssoccer.com/";
                        break;
                    case nbcsn:
                        return 'http://www.nbcsports.com/tv-listing';
                        break;
                    case espn2:
                        return 'http://espn.go.com/watchespn/index/_/type/live/channel/espn2';
                        break;
                    case watchESPN:
                        return 'http://espn.go.com/watchespn/index';
                        break;
                    case bein:
                        return 'http://www.beinsport.tv';
                        break;
                    case tsn:
                        return 'http://www.tsn.ca/soccer';
                        break;
                    case tsn2:
                        return 'http://www.livesoccertv.com/channels/tsn-2/';
                        break;
                    default:
                        return null;

                }

            }
            else {
                MYCITYFC.HELPERS.log('Not found');
                return null;
            }


        },

        formatGameTV: function () {

            var chName = $('.field-broadcast-partners strong');
            chName.each(function (i, e) {
                var actual = $(e),
                    rawLink = $(actual).contents();
                var linkText = ($(rawLink).text().trim());
                var linkChild = $(rawLink),
                    sentVal = $(linkChild).text();
                var cheese = MYCITYFC.MAIN.formatChannel(sentVal);
                var newLink = $(actual).wrap('<a></a>');
                if (cheese === null) {
                    $(newLink).unwrap('<a>').wrap('<p>');
                } else {
                    $(newLink).parent('a').attr("href", function (i, v) {
                        return v = cheese;
                    });
                }


            });

        },

        formatGameLinks: function () {

//            $('#js-schedule .js-single-game .home-team:empty').parent().empty().text('Pending');

            var noGameInfo = $('#js-schedule .js-single-game .home-team:empty').siblings(':not(".game-date")');
            $(noGameInfo).empty().parent().append('<p>Game information unavailable at this time.</p>');


            if (($('a.game-matchcenter') || $('a.game-tickets')).empty()) {
                $(this).css('display', 'none');
            }
        },

        displayGameDay: function () {

//            var gameDay = $('#js-gameday'),
            var gameDayContent = $('#js-gameday .sleeve'),
                gameDayToggle = $('#js-gameday-toggle');

            gameDayToggle.click(function () {

                if (gameDayContent.is(':visible')) {
                    gameDayToggle.text('+').addClass('is-open');
                    gameDayContent.slideUp();
                } else {
                    gameDayToggle.text('x').removeClass('is-open');
                    gameDayContent.slideDown();

                }
            });
        }

    }

};


//init on page load
$(function () {

    MYCITYFC.HELPERS.applyScroll('.scrollMe');
    MYCITYFC.MAIN.filterSchedule();
    MYCITYFC.MAIN.filterGames();
    MYCITYFC.MAIN.displayGameDay();
    MYCITYFC.MAIN.formatGameTV();
    MYCITYFC.MAIN.formatGameLinks();

});