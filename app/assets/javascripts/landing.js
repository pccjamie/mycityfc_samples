//ON DOC LOAD
$(function () {

    function scrollToAnchor(aid) {
        var aTag = $("a[name='" + aid + "']");
        $('html,body#landing,#intro,#login').animate({scrollTop: aTag.offset().top}, 'slow');
    }
    $("a.jump").click(function (e) {
        e.preventDefault();
        var href = $(this).attr('href').replace('#', '');
        scrollToAnchor(href);
    });

});
