
var doc = document.documentElement;
doc.setAttribute('data-useragent', navigator.userAgent);

var dropdown_area_pc = document.getElementById('menu_dropdown_pc');
var dropdown_area_mobile = document.getElementById('menu_dropdown_mobile');

// PC menu dropdown
function sub_show() {
    dropdown_area_pc.style.display = 'block';
}
function sub_hide() {
    dropdown_area_pc.style.display = 'none';
}
var menu_click = false;
function sub_show_hide(){
    if(dropdown_area_mobile && menu_click){
        dropdown_area_mobile.style.display = 'none';
        menu_click = false;
    }else if(dropdown_area_mobile){
        dropdown_area_mobile.style.display = 'block';
        menu_click = true;
    }
}

// bxSlider
// $(window).load(function(){
//     var size = size_check();
//     var tab1 = document.getElementById('tab1');
//     var tab2 = document.getElementById('tab2');
//     var tab3 = document.getElementById('tab3');

//     $('.slider_wrap').bxSlider({
//         mode: 'fade',
//         controls: false,
//         pager: true,
//         autoHover: true,
//         auto: true,
//         ease: 'cubic-sezier(0.42, 0, 0.58, 1)',
//         autocontrolsCombine: true,
//         autoControls:true,
//         touchEnabled:false,
//         shrinkItems: true,
//         pause:5000,
//         speed:800 
//     });

//     tab2.parentNode.parentNode.style.display = 'none';
//     tab3.parentNode.parentNode.style.display = 'none';
// });

// $(window).load(function() {

//     var slider = $('.slider_wrap').bxSlider({
//         mode: 'vertical',
//         hideControlOnEnd: true,
//         infiniteLoop: false,
//         pager:false,
//         minSlides:1
//     });
    
//     $(window).resize(function(e){
//         e.preventDefault();
//         slider.reloadSlider({
//             mode: 'vertical',
//             hideControlOnEnd: true,
//             infiniteLoop: false,
//             pager:false,
//             minSlides:1,
//         });
//     });
// });

$(document).ready(function () {
    var size = size_check();
    var tab1 = document.getElementById('tab1');
    var tab2 = document.getElementById('tab2');
    var tab3 = document.getElementById('tab3');

    $('.slider_wrap').bxSlider({
        mode: 'fade',
        controls: false,
        pager: true,
        autoHover: true,
        auto: true,
        ease: 'cubic-sezier(0.42, 0, 0.58, 1)',
        autocontrolsCombine: true,
        autoControls:true,
        touchEnabled:false,
        shrinkItems: true,
        pause:5000,
        speed:800 
    });

    tab2.parentNode.parentNode.style.display = 'none';
    tab3.parentNode.parentNode.style.display = 'none';
});

// device size check
function size_check() {
    var size = {
        width: window.innerWidth || document.body.clientWidth,
        height: window.innerHeight || document.body.clientHeight
    }
    var text = document.getElementById('width_text');
    text.innerHTML = size.width;

    return size;
}
size_check();

// visual tab area handler
var visual_tabs = document.getElementsByClassName('tabs');
var visual_active = 1;

function change_tab(num, elem){
    var active_tab = num;
    var btns = document.getElementsByClassName('slider_tab')[0].getElementsByTagName('button');
    for(var j = 0; j < btns.length; j++){
        var btn = btns[j];
        if(j === active_tab){
            btn.classList.add('on');
        }else if(btn.classList = 'on'){
            btn.classList.remove('on');
        }
    }

    for(var i = 0; i <= visual_tabs.length; i++){
        var temp = visual_tabs[i];
        if(i === active_tab){
            var elem = document.getElementById('tab'+(active_tab+1));
            elem.parentNode.parentNode.style.display = 'block';
            elem.style.display = 'block';
        }else{
            temp.parentNode.parentNode.style.display = 'none';
        }
    }
}

// mobile menu
var doc = document.getElementsByTagName('body')[0];
var head_mobile = document.getElementsByClassName('head_mobile')[0];
var menu = document.getElementsByClassName('mobile_dropwdown_wrap')[0];
var menu_open = false;

function mobile_menu(){
    if(menu_open){
        mobile_menu_close();
    }else{
        doc.style.overflow = 'hidden';
        menu.style.display = 'block';
        menu_open = true;
        head_mobile.classList.add('on');
    }
}

// mobile sub menu
function sub_menu_open(btn){
    var clicked_button = btn;
    var menu_box = clicked_button.parentNode.querySelector('ul');
    var list_style = window.getComputedStyle(menu_box)['display'];
    var all_list = document.querySelectorAll('.mobile_menu > ul');

    for(var i = 0; i < all_list.length; i++){
        var temp = all_list[i];
        if(temp === menu_box){
            if(list_style === 'none'){
                clicked_button.style.background = 'url("./img/menu_arr_up.png") #fff 90% 50% no-repeat';
                temp.style.display = 'block';
            }else{
                clicked_button.style.background = 'url("./img/menu_arr_down.png") #fff 90% 50% no-repeat';
                temp.style.display = 'none';
            }
        }else{
            temp.parentNode.querySelector('button').style.background = 'url("./img/menu_arr_down.png") #fff 90% 50% no-repeat';
            temp.style.display = 'none';
        }
    }
}

function mobile_menu_close(){

    doc.style.overflow = 'unset';
    menu.style.display = 'none';
    menu_open = false;
    head_mobile.classList.remove('on');
}

// login
function login(){
    console.log('login btn clicked');
}