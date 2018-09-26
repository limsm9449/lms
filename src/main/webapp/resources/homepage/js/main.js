$(document).ready(function () {
    var size = size_check();
    var mobile_btn = $('.mobile_btn');
    var logo_box = $('.logo_box');
    var util_box = $('.util_box');
    var search_box = $('.search_box');
    var menu_wrap = $('.menu_wrap');

    $('.slider_wrap').bxSlider({
        mode: 'fade',
        controls: false,
        pager: true,
        autoHover: true,
        auto: true
    });
    if (size) {
        // mobile(360px 이하)일 때
        // mobile_btn.insertBefore(logo_box);
        // search_box.insertAfter(util_box);
    }
    $(window).resize(function () {
        if (size) {
            // mobile_btn.insertBefore(logo_box);
            // search_box.insertAfter(util_box);
        }
    });
});
// $(window).bind('load', function(){
//     $('.slider_wrap').bxSlider({
//         mode: 'fade',
//         controls: false,
//         pager: true,
//         autoHover: true,
//         auto: true
//     });
// });
// function util_style(property_value) {
//     var mobile_remove = $('.util_box .pc');
//     for (var i = 0; i < mobile_remove.length; i++) {
//         var temp = mobile_remove[i];
//         temp.style.display = property_value;
//     }
// }

function size_check() {
    var size = {
        width: window.innerWidth || document.body.clientWidth,
        height: window.innerHeight || document.body.clientHeight
    }
    var text = document.getElementById('width_text');
    text.innerHTML = size.width;
    // if (size.width <= 360) {
    //     text.innerHTML = size.width;
    // }
}
size_check();

var dropdown_area = document.getElementsByClassName('menu_dropdown_wrapper')[0];

function sub_show() {
    dropdown_area.style.display = 'block';
}
function sub_hide() {
    dropdown_area.style.display = 'none';
}
