//$(document).ready(function () {
//    $(window).bind('load', function () {
//        $(".thumb").hover(
//            function () {
//                $(this).find(".inline-icons").show();
//                $(this).find(".title").show();
//                $(this).find(".meta").css("background", "black");
//            }, function () {
//                $(this).find(".inline-icons").hide();
//                $(this).find(".title").hide();
//                $(this).find(".meta").css("background", "none");
//            });
//    });
//});

$(document).delegate("#menuuser", "mouseenter mouseleave", function (event) {
    if (event.type == 'mouseenter') {
        $("#global-nav .panel").css("display", "block");
    } else {
        $("#global-nav .panel").css("display", "none");
    }
});

$(document).delegate(".thumb", "mouseenter mouseleave", function (event) {
    if (event.type == 'mouseenter') {
        $(this).find(".inline-icons").show();
        $(this).find(".title").show();
        $(this).find(".meta").css("background", "black");
    } else {
        $(this).find(".inline-icons").hide();
        $(this).find(".title").hide();
        $(this).find(".meta").css("background", "none");
    }
});


