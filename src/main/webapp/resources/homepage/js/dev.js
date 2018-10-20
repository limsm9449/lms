
var resourceUrl = '/resources/hompage/';
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
function sub_show_hide() {
    if (dropdown_area_mobile && menu_click) {
        dropdown_area_mobile.style.display = 'none';
        menu_click = false;
    } else if (dropdown_area_mobile) {
        dropdown_area_mobile.style.display = 'block';
        menu_click = true;
    }
}

$(document).ready(function () {
    // var size = size_check();
    var tab1 = document.getElementById('tab1');
    var tab2 = document.getElementById('tab2');
    var tab3 = document.getElementById('tab3');

    if (tab1) {
        $('.slider_wrap').bxSlider({
            mode: 'fade',
            controls: false,
            pager: true,
            autoHover: true,
            auto: true,
            ease: 'cubic-sezier(0.42, 0, 0.58, 1)',
            autocontrolsCombine: true,
            autoControls: true,
            touchEnabled: false,
            shrinkItems: true,
            pause: 5000,
            speed: 800
        });

        tab2.parentNode.parentNode.style.display = 'none';
        tab3.parentNode.parentNode.style.display = 'none';
    }
});

// device size check
function size_check() {
    var size = {
        width: window.innerWidth || document.body.clientWidth,
        height: window.innerHeight || document.body.clientHeight
    }
    var text = document.getElementById('width_text');
    if (text) {
        text.innerHTML = size.width;
        return size;
    }
}
size_check();

// visual tab area handler
var visual_tabs = document.getElementsByClassName('tabs');
var visual_active = 1;

function change_tab(num, elem) {
    var active_tab = num;
    var btns = document.getElementsByClassName('slider_tab')[0].getElementsByTagName('button');
    for (var j = 0; j < btns.length; j++) {
        var btn = btns[j];
        if (j === active_tab) {
            btn.classList.add('on');
        } else if (btn.classList = 'on') {
            btn.classList.remove('on');
        }
    }

    for (var i = 0; i <= visual_tabs.length; i++) {
        var temp = visual_tabs[i];
        if(temp){
            if (i === active_tab) {
                var elem = document.getElementById('tab' + (active_tab + 1));
                elem.parentNode.parentNode.style.display = 'block';
                elem.style.display = 'block';
            } else {
                temp.parentNode.parentNode.style.display = 'none';
            }
        }
    }
}

// mobile menu
var doc = document.getElementsByTagName('body')[0];
var head_mobile = document.getElementsByClassName('head_mobile')[0];
var menu = document.getElementsByClassName('mobile_dropwdown_wrap')[0];
var menu_open = false;

function mobile_menu() {
    if (menu_open) {
        mobile_menu_close();
    } else {
        doc.style.overflow = 'hidden';
        menu.style.display = 'block';
        menu_open = true;
        head_mobile.classList.add('on');
    }
}

// mobile sub menu
function sub_menu_open(btn, page) {
    var url_up = '';
    var url_down = '';

    switch (page) {
        case 'main':
            url_up = 'url("'+resourceUrl+'img/menu_arr_up.png") #fff 90% 50% no-repeat';
            url_down = 'url("'+resourceUrl+'img/menu_arr_down.png") #fff 90% 50% no-repeat';
            break;
        case 'others':
            url_up = 'url("'+resourceUrl+'img/menu_arr_up.png") #fff 90% 50% no-repeat';
            url_down = 'url("'+resourceUrl+'img/menu_arr_down.png") #fff 90% 50% no-repeat';
            break;
    }

    var clicked_button = btn;
    var menu_box = clicked_button.parentNode.querySelector('ul');
    var list_style = window.getComputedStyle(menu_box)['display'];
    var all_list = document.querySelectorAll('.mobile_menu > ul');

    for (var i = 0; i < all_list.length; i++) {
        var temp = all_list[i];
        if (temp === menu_box) {
            if (list_style === 'none') {
                clicked_button.style.background = url_up;
                temp.style.display = 'block';
            } else {
                clicked_button.style.background = url_down;
                temp.style.display = 'none';
            }
        } else {
            temp.parentNode.querySelector('button').style.background = url_down;
            temp.style.display = 'none';
        }
    }
}

function mobile_menu_close() {
    doc.style.overflow = 'auto';
    menu.style.display = 'none';
    menu_open = false;
    head_mobile.classList.remove('on');
}

// login
function login() {
    console.log('login btn clicked');
}

function lecture_view(target, type) {
    var clicked_btn = $('.user_lecture_tab_box button');
    if(clicked_btn){
        for (var j = 0; j < clicked_btn.length; j++) {
            var temp = clicked_btn[j];
            if(temp.classList){
                if (temp === target) {
                    temp.classList.add('on');
                } else {
                    clicked_btn[j].classList.remove('on');
                }
            }
        }
    }
    var lecture_list = $('.user_lecture_list');
    if (type) {
        var active, inactive;
        for (var i = 0; i < lecture_list.length; i++) {
            var temp = lecture_list[i].classList[1];
            if (temp === type) {
                switch (type) {
                    case 'present':
                        active = $('.present');
                        inactive = $('.past');
                        break;
                    case 'past':
                        active = $('.past');
                        inactive = $('.present');
                        break;
                }
                for(var j = 0, k = 0; j < active.length, k < inactive.length; j++, k++){
                    var active_temp = active[j];
                    var inactive_temp = inactive[k];
                    active_temp.style.display = 'block';
                    inactive_temp.style.display = 'none';
                }
            }
        }
    }
}

// 학습시작 btn
function open_study(){
    window.open(resourceUrl+'html/classroom/study.html', '_blank');
}

// 고객지원 Tab
function list_tab(target, tochange) {
    var active_btn = target;
    var next_list_id = tochange;
    var buttons = document.getElementsByClassName('support_btn');
    var all_list = document.getElementsByClassName('support_list_wrap');

    for(var j = 0; j < buttons.length; j++){
        var button = buttons[j];
        if(button === active_btn){
            button.classList.add('active');
        }else{
            button.classList.remove('active');
        }
    }

    for (var i = 0; i < all_list.length; i++) {
        var temp = all_list[i];
        if (temp.id === next_list_id) {
            temp.style.display = 'block';
        } else {
            temp.style.display = 'none';
        }
    }
}