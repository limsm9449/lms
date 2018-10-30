
var resourceUrl = '/resources/homepage/';

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
    var url_up = 'url("' + resourceUrl + 'img/menu_arr_up.png") #fff 90% 50% no-repeat';
    var url_down = 'url("' + resourceUrl + 'img/menu_arr_down.png") #fff 90% 50% no-repeat';

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



// --- process ---

// register class
function register_class(flag) {
    window.open(resourceUrl+'html/course/register_course.html', '_self');
}


// --- process - register ---
function register_tab(btn, box_name){
    var clicked_btn = btn;
    var all_box = document.getElementsByClassName('register_tab_content_box');
    var all_btn = document.getElementsByClassName('register_btn');
    var focused_box = document.getElementById(box_name);

    for(var i = 0; i < all_box.length; i++){
        var temp = all_box[i];

        if(temp === focused_box){
            temp.style.display = 'block';
        }else{
            temp.style.display = 'none';
        }
    }

    for(var j = 0; j < all_btn.length; j++){
        var button = all_btn[j];
        if(clicked_btn === button){
            button.classList.add('active');
        }else{
            button.classList.remove('active');
        }
    }
}

function thumbnail(event, num){
    var clicked_item = event.target;
    var all_thumbnail = document.getElementsByClassName('register_image_list_item');
    var change_target = document.querySelector('#register_big_img img');

    for(var i = 0; i < all_thumbnail.length; i++){
        var temp = all_thumbnail[i];

        if(temp === clicked_item){
            if(temp.classList){
                temp.classList.add('active');            
            }else{
                // IE 9
                if(i === 2){
                    temp.setAttribute('class', 'register_image_list_item active last_right');
                }else{
                    temp.setAttribute('class', 'register_image_list_item active');
                }
            }
        }else{
            if(temp.classList){
                temp.classList.remove('active');
            }else{
                // IE 9
                if(i === 2){
                    temp.setAttribute('class', 'register_image_list_item last_right');
                }else{
                    temp.setAttribute('class', 'register_image_list_item');
                }
            }
        }
    }

    change_target.src = resourceUrl+'img/course/register_' + num +'.jpg';
}

function register_select_handler(){
    var select_box = document.getElementById('register_course_select');
    var elems = document.getElementsByClassName('part_only');
    if(select_box.value === 'part'){
        for(var i = 0; i < elems.length; i++){
            var temp = elems[i];
            temp.style.display = 'table-cell';
        }
    }else if(select_box.value === 'all'){
        for(var i = 0; i < elems.length; i++){
            var temp = elems[i];
            temp.style.display = 'none';
        }
    }
}



// --- classroom ---

// lecture Tab
function lecture_view(target, type) {
    var clicked_btn = $('.user_lecture_tab_box button');
    for (var j = 0; j < clicked_btn.length; j++) {
        var temp = clicked_btn[j];
        if (temp.classList) {
            if (temp === target) {
                temp.classList.add('on');
            } else {
                clicked_btn[j].classList.remove('on');
            }
        }else{
            // IE 9
            if (temp === target) {
                temp.setAttribute('class', 'on clear_fix');
            } else {
                temp.setAttribute('class', 'clear_fix');
            }
        }
    }
    var lecture_list = $('.user_lecture_list');
    if (type) {
        var active, inactive;
        for (var i = 0; i < lecture_list.length; i++) {
            var elem = lecture_list[i];
            if (elem.classList) {
                var temp = elem.classList[1];
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
                    for (var j = 0, k = 0; j < active.length, k < inactive.length; j++ , k++) {
                        var active_temp = active[j];
                        var inactive_temp = inactive[k];
                        active_temp.style.display = 'block';
                        inactive_temp.style.display = 'none';
                    }
                }
            }else{
                // IE 9
                var temp = elem.className;
                if(temp.indexOf(type)){
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
                    for (var j = 0, k = 0; j < active.length, k < inactive.length; j++ , k++) {
                        var active_temp = active[j];
                        var inactive_temp = inactive[k];
                        active_temp.style.display = 'block';
                        inactive_temp.style.display = 'none';
                    }
                }
            }
        }
    }
}

// study btn
function open_study(){
    window.open(resourceUrl+'html/classroom/study.html', '_blank');
}



// --- classroom - study ---

// Graph view handler
window.addEventListener("load", function (event) {
    var average = document.querySelector('#percentage_average');
    if (average) {
        var average_num = average.innerHTML;
        var my_num = document.querySelector('#percentage_my').innerHTML;
        var average_only_num = average_num.replace(/%/, '');
        var my_only_num = my_num.replace(/%/, '');

        average_only_num *= 1;
        my_only_num *= 1;
    }
});

// Notice/QnA Tab Area
function study_btn_click(btn) {
    var other_id, other_class, inactive_btn, inactive_list, active_list;

    active_list = document.querySelector('.study_support_list_box.' + btn.id);
    active_list.style.display = 'block';
    switch (btn.id) {
        case 'notice':
            other_id = '#qna'
            other_class = '.study_support_list_box.qna';
            break;
        case 'qna':
            other_id = '#notice';
            other_class = '.study_support_list_box.notice';
            break;
    }
    inactive_btn = document.querySelector(other_id);
    inactive_list = document.querySelector(other_class);
    if (btn.classList) {
        btn.classList.add('on');
        inactive_btn.classList.remove('on');
    }else{
        // IE 9
        btn.setAttribute('class', 'on');
        inactive_btn.setAttribute('class', '');
    }
    inactive_list.style.display = 'none';
}

// Lecture Study Open
function open_lecture(){
    window.open(resourceUrl + 'html/popup/popup_learning.html', 'win_lecture');
}

// Popup Open
function open_popup(page) {
    window.open(resourceUrl + 'html/popup/' + page + '.html', 'win_' + page, 'width=800, height=840');
}

// Popup Close
function close_popup(page) {
    var temp = document.getElementById(page);
    temp.style.display = 'none';
}



// --- classroom - study - popup ---

// Popup Open
function new_window(page) {
    window.open(resourceUrl + 'html/popup' + page + '.html', 'mywin', 'width=800, height=840');
}

// Popup Close
function close_popup(page) {
    var temp = document.getElementById(page);
    temp.style.display = 'none';
}


// --- classroom - lecture detail (popup) ---
function lecture_open_popup(page, popup) {
    var size = '';
    if(popup){
        size = 'width=750, height=840';
    }
    window.open(resourceUrl + 'html/classroom/' + page + '.html', 'win_'+page, size);
}



// --- support ---

// 고객지원 Tab
function list_tab(target, tochange) {
    var active_btn = target;
    var next_list_id = tochange;
    var buttons = document.getElementsByClassName('support_btn');
    var all_list = document.getElementsByClassName('support_list_wrap');

    for (var i = 0; i < all_list.length; i++) {
        var temp = all_list[i];
        if (temp.id === next_list_id) {
            temp.style.display = 'block';
        } else {
            temp.style.display = 'none';
        }
    }

    for (var j = 0; j < buttons.length; j++) {
        var button = buttons[j];
        if (button === active_btn) {
            if(button.classList){
                button.classList.add('active');
            }else{
                // IE 9
                button.setAttribute('class', 'support_btn active');
            }
        } else {
            if(button.classList){
                button.classList.remove('active');
            }else{
                // IE 9
                var list_num = next_list_id.slice(-1);
                if(list_num === 5){
                    button.setAttribute('class', 'support_btn last_right');
                }
                button.setAttribute('class', 'support_btn');
            }
        }
    }
}

// --- support - faq ---

// 질문/답변 open/close
function answer(elem){
    var box = elem;
    var answer = box.querySelector('.faq_item_answer');
    var arrow = box.querySelector('.faq_arrow > img');

    if(window.getComputedStyle(answer)['display'] === 'none'){
        arrow.setAttribute('src', resourceUrl + 'img/support/arr_up.jpg');
        answer.style.display = 'block';
        box.style.background = '#f7f7f7';
    }else{
        arrow.setAttribute('src', resourceUrl + 'img/support/arr_down.jpg');
        answer.style.display = 'none';
        box.style.background = '#fff';
    }
}



// --- admin ---

function admin_sub_open(elem){
    var btn = elem.target;
    var list_box = btn.parentNode;
    var list_all = document.querySelectorAll('.gnb > li');

    for(var i = 0; i < list_all.length; i++){
        var temp = list_all[i];
        if(temp === list_box){
            if(temp.classList){
                temp.classList.add('on');
            }else{
                // IE
                temp.className = 'on';
            }
        }else{
            if(temp.classList){
                temp.classList.remove('on');
            }else{
                // IE
                temp.className = '';
            }
        }
    }
}

function admin_popup_open(type, isDiv){
    if(isDiv){
        var inner_popup = document.querySelector('.admin_popup.type'+type);
        inner_popup.style.display = 'block';
    }else{
        var url = resourceUrl + 'html/popup/admin_popup_type' + type + '.html';
        if(type){
            switch(type){
                case '7':
                    url = '../popup/admin_popup_type7.html';
                break;
                default:
                    url = '../popup/admin_popup_type1.html';
                break;
            }
            
            window.open(url, '_blank', 'width=400, height=500');
        }
    }
}

function admin_popup_close(isDiv){
    var inner_popup = document.querySelector('.admin_popup');
    if(isDiv){
        inner_popup.style.display = 'none';
    }else{
        window.open('about:blank', '_self').close();
    }
}



function qna_answer_open(){
    var elem = document.getElementById('notice_detail_answer');
    elem.style.display = 'block';
}

function qna_answer_close(){
    var elem = document.getElementById('notice_detail_answer');
    elem.style.display = 'none';
}

function review_score(num){
    var elem = document.getElementsByClassName('score');
    for(var i = 0; i < elem.length; i++){
        var temp = elem[i];
        if(i < num){
            temp.style.background = 'url("' + resourceUrl + 'img/course/register_star_active.png") no-repeat';
        }else{
            temp.style.background = 'url("' + resourceUrl + 'img/course/register_star_inactive.png") no-repeat';
        }
    }
}


// PC / MOBILE CHECK
function device_check() {
    var size = {
        width: window.innerWidth || document.body.clientWidth,
        height: window.innerHeight || document.body.clientHeight
    }
    if (size){
        if((size.width <= 420) || ((size.height <= 420) && (size.width > size.height))) {
            window.alert('device - mobile');
        }else{
            window.alert('device - pc');
        }
    }
}
// device_check();


// BASKET POPUP CLOSE
function basket_popup_close(){
    var popup = document.querySelector('.basket_completed_popup');

    popup.style.display = 'none';
}
function basket_popup_open(){
    window.open(resourceUrl + 'html/classroom/basket_popup.html', '_blank', 'width=620, height=500');
}

function windows(){
    window.open(resourceUrl + 'html/classroom/basket_step3.html', '_self');
    basket_popup_open();
}