/* getElementsByClassName 을 IE8 이하에서 동작하게 하는 코드 */
if (!document.getElementsByClassName) {
    document.getElementsByClassName = function (cn) {
        var rx = new RegExp("(?:^|\\s)" + cn+ "(?:$|\\s)");
        var allT = document.getElementsByTagName("*"), allCN = [],ac="", i = 0, a;
 
        while (a = allT[i=i+1]) {
            ac=a.className;
            if ( ac && ac.indexOf(cn) !==-1) {
                if(ac===cn){ allCN[allCN.length] = a; continue;   }
                    rx.test(ac) ? (allCN[allCN.length] = a) : 0;
                }
        }
        return allCN;
    };
}



var doc = document.documentElement;
doc.setAttribute('data-useragent', navigator.userAgent);

var dropdown_area_pc = document.getElementById('menu_dropdown_pc');
var dropdown_area_mobile = document.getElementById('menu_dropdown_mobile');

// PC menu dropdown
var menu_click_pc = false;
function sub_show_hide_pc(btn) {
    if (dropdown_area_pc && menu_click_pc) {
        dropdown_area_pc.style.display = 'none';
        btn.className = '';
        menu_click_pc = false;
    } else if (dropdown_area_pc) {
        dropdown_area_pc.style.display = 'block';
        btn.className = 'active';
        menu_click_pc = true;
    }
}
// MOBILE menu on/off
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
    var url_up = '';
    var url_down = '';

    switch (page) {
        case 'main':
            url_up = 'url("./img/menu_arr_up.png") #fff 90% 50% no-repeat';
            url_down = 'url("./img/menu_arr_down.png") #fff 90% 50% no-repeat';
            break;
        case 'others':
            url_up = 'url("../../img/menu_arr_up.png") #fff 90% 50% no-repeat';
            url_down = 'url("../../img/menu_arr_down.png") #fff 90% 50% no-repeat';
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



// --- process ---

// register class
function register_class(flag) {
    if (flag) {
        window.open('../course/register_course.html', '_self');
    } else {
        window.open('./register_course.html', '_self');
    }
}


// --- process - register ---
function register_tab(btn, box_name) {
    var clicked_btn = btn;
    var all_box = document.getElementsByClassName('register_tab_content_box');
    var all_btn = document.getElementsByClassName('register_btn');
    var focused_box = document.getElementById(box_name);

    for (var i = 0; i < all_box.length; i++) {
        var temp = all_box[i];

        if (temp === focused_box) {
            temp.style.display = 'block';
        } else {
            temp.style.display = 'none';
        }
    }

    for (var j = 0; j < all_btn.length; j++) {
        var button = all_btn[j];
        if (clicked_btn === button) {
            if (button.classList) {
                button.classList.add('active');
            } else {
                // IE 9
                if (box_name === 'estimate') {
                    button.setAttribute('class', 'register_btn active last_right');
                } else {
                    button.setAttribute('class', 'register_btn active');
                }
            }
        } else {
            if (button.classList) {
                button.classList.remove('active');
            } else {
                //IE 9
                if (box_name === 'estimate') {
                    button.setAttribute('class', 'register_btn last_right');
                } else {
                    button.setAttribute('class', 'register_btn')
                }
            }
        }
    }
}

function thumbnail(event, num) {
    var clicked_item = event.target;
    var all_thumbnail = document.getElementsByClassName('register_image_list_item');
    var change_target = document.querySelector('#register_big_img img');

    for (var i = 0; i < all_thumbnail.length; i++) {
        var temp = all_thumbnail[i];

        if (temp === clicked_item) {
            if (temp.classList) {
                temp.classList.add('active');
            } else {
                // IE 9
                if (i === 2) {
                    temp.setAttribute('class', 'register_image_list_item active last_right');
                } else {
                    temp.setAttribute('class', 'register_image_list_item active');
                }
            }
        } else {
            if (temp.classList) {
                temp.classList.remove('active');
            } else {
                // IE 9
                if (i === 2) {
                    temp.setAttribute('class', 'register_image_list_item last_right');
                } else {
                    temp.setAttribute('class', 'register_image_list_item');
                }
            }
        }
    }

    change_target.src = '../../img/course/register_' + num + '.jpg';
}

function register_select_handler() {
    var select_box = document.getElementById('register_course_select');
    var elems = document.getElementsByClassName('part_only');
    var area = document.querySelector('.register_course_list');
    var area_text = document.querySelector('.register_course_list_text');

    if (select_box.value === 'part') {
        for (var i = 0; i < elems.length; i++) {
            var temp = elems[i];
            temp.style.display = 'table-cell';
            area.style.display = 'block';
            area_text.style.display = 'block';
        }
    } else if (select_box.value === 'all') {
        for (var i = 0; i < elems.length; i++) {
            var temp = elems[i];
            temp.style.display = 'none';
            area.style.display = 'none';
            area_text.style.display = 'none';
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
        } else {
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
            } else {
                // IE 9
                var temp = elem.className;
                if (temp.indexOf(type)) {
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
function open_study() {
    window.open('./study.html', '_blank');
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
    } else {
        // IE 9
        btn.setAttribute('class', 'on');
        inactive_btn.setAttribute('class', '');
    }
    inactive_list.style.display = 'none';
}

// Lecture Study Open
function open_lecture() {
    window.open('../popup/popup_learning.html', 'win_lecture');
}

// Popup Open
function open_popup(page) {
    window.open('../popup/' + page + '.html', 'win_' + page, 'width=800, height=840');
}

// Popup Close
function close_popup(page) {
    var temp = document.getElementById(page);
    temp.style.display = 'none';
}



// --- classroom - study - popup ---

// Popup Open
function new_window(page) {
    window.open('./' + page + '.html', 'mywin', 'width=800, height=840');
}

// Popup Close
function close_popup(page) {
    var temp = document.getElementById(page);
    temp.style.display = 'none';
}



// --- classroom - lecture detail (popup) ---
function lecture_open_popup(page, popup) {
    var url = page + '.html';
    var size = '';
    if (popup) {
        size = 'width=750, height=840';
    }
    window.open(url, 'win_' + page, size);
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
            if (button.classList) {
                button.classList.add('active');
            } else {
                // IE 9
                button.setAttribute('class', 'support_btn active');
            }
        } else {
            if (button.classList) {
                button.classList.remove('active');
            } else {
                // IE 9
                var list_num = next_list_id.slice(-1);
                if (list_num === 5) {
                    button.setAttribute('class', 'support_btn last_right');
                }
                button.setAttribute('class', 'support_btn');
            }
        }
    }
}

// --- support - faq ---

// 질문/답변 open/close
function answer(elem) {
    var box = elem;
    var answer = box.querySelector('.faq_item_answer');
    var arrow = box.querySelector('.faq_arrow > img');

    if (window.getComputedStyle(answer)['display'] === 'none') {
        arrow.setAttribute('src', '../../img/support/arr_up.jpg');
        answer.style.display = 'block';
        box.style.background = '#f7f7f7';
    } else {
        arrow.setAttribute('src', '../../img/support/arr_down.jpg');
        answer.style.display = 'none';
        box.style.background = '#fff';
    }
}



// --- admin ---

function admin_sub_open(elem) {
    var btn = elem.target;
    var list_box = btn.parentNode;
    var list_all = document.querySelectorAll('.gnb > li');

    for (var i = 0; i < list_all.length; i++) {
        var temp = list_all[i];
        if (temp === list_box) {
            if (temp.classList) {
                temp.classList.add('on');
            } else {
                // IE
                temp.className = 'on';
            }
        } else {
            if (temp.classList) {
                temp.classList.remove('on');
            } else {
                // IE
                temp.className = '';
            }
        }
    }
}

function admin_popup_open(type, isDiv) {
    var inner_popup = document.querySelector('.admin_popup.type' + type);
    var flag = true;

    if (type) {
        switch (type) {
            case '0':
                flag = false;
            case '7':
                url = '../popup/admin_popup_type7.html';
                break;
            default:
                url = '../popup/admin_popup_type1.html';
                break;
        }
        if(flag){
            if(isDiv) {
                if(inner_popup){
                    inner_popup.style.display = 'block';
                }
            }else{
                window.open(url, '_blank', 'width=400, height=500');
            }
        }
    }
}

function admin_popup_close(isDiv) {
    var inner_popup = document.querySelector('.admin_popup');
    if (isDiv) {
        inner_popup.style.display = 'none';
    } else {
        window.open('about:blank', '_self').close();
    }
}



function qna_answer_open() {
    var elem = document.getElementById('notice_detail_answer');
    elem.style.display = 'block';
}

function qna_answer_close() {
    var elem = document.getElementById('notice_detail_answer');
    elem.style.display = 'none';
}

function review_score(num) {
    var elem = document.getElementsByClassName('score');
    for (var i = 0; i < elem.length; i++) {
        var temp = elem[i];
        if (i < num) {
            temp.style.background = 'url("../../img/course/register_star_active.png") #fff 90% 50% no-repeat';
        } else {
            temp.style.background = 'url("../../img/course/register_star_inactive.png") #fff 90% 50% no-repeat';
        }
    }
}



// PC / MOBILE CHECK
function device_check() {
    var size = {
        width: window.innerWidth || document.body.clientWidth,
        height: window.innerHeight || document.body.clientHeight
    }
    if (size) {
        if ((size.width <= 420) || ((size.height <= 420) && (size.width > size.height))) {
            window.alert('device - mobile');
        } else {
            window.alert('device - pc');
        }
    }
}
// device_check();


// BASKET POPUP CLOSE
function basket_popup_close() {
    var popup = document.querySelector('.basket_completed_popup');

    popup.style.display = 'none';
}
function basket_popup_open() {
    window.open('./basket_popup.html', '_blank', 'width=620, height=500');
}

function windows() {
    window.open('./basket_step3.html', '_self');
    basket_popup_open();
}


// if (!('remove' in Element.prototype)) {
//     Element.prototype.remove = function() {
//         if (this.parentNode) {
//             this.parentNode.removeChild(this.nextSibling);
//             this.parentNode.removeChild(this);
//         }
//     };
// }


// REGISTER COURSE LIST
function register_list(checkbox) {
    var area = document.querySelector('.register_course_list');
    var parent = getParentByTagName(checkbox, 'td').parentNode;
    var course = parent.querySelector('.register_compose_lecture p');
    var price = parent.querySelector('.last_right.part_only');
    var text = course.innerText;
    var text_price = price.innerText;

    // create html element
    var elem_p = document.createElement('p');
    elem_p.className = 'n_course_list_left';
    var elem_p_price = document.createElement('p');
    elem_p_price.className = 'n_course_list_right';

    // checked
    if (checkbox.checked) {
        var content = document.createTextNode(text);
        var content_price = document.createTextNode(text_price);
        elem_p.appendChild(content);
        elem_p_price.appendChild(content_price);
        area.appendChild(elem_p);
        area.appendChild(elem_p_price);
    } else {
        // unchecked    
        var elems_p = area.getElementsByTagName('p');
        for (var i = 0; i < elems_p.length; i++) {
            var temp = elems_p[i];
            if (temp.innerHTML === text) {
                var next = temp.nextSibling;
                temp.parentNode.removeChild(temp);
                next.parentNode.removeChild(next);
            }

        }
    }

}

// GET PARNET NODE
function getParentByTagName(node, tagname) {
    var parent;
    if (node === null || tagname === '') return;
    parent = node.parentNode;
    tagname = tagname.toUpperCase();

    while (parent.tagName !== "HTML") {
        if (parent.tagName === tagname) {
            return parent;
        }
        parent = parent.parentNode;
    }

    return parent;
}



if (window.performance) {
    console.info("window.performance works fine on this browser");
}
if (performance.navigation.type == 1) {
    console.info("This page is reloaded");
} else {
    console.info("This page is not reloaded");
}



function guide_change(focused, elem){
    var btn_box = document.querySelectorAll('.register_method_tab button');
    var pc_box = document.getElementsByClassName('register_method_pc')[0];
    var mobile_box = document.getElementsByClassName('register_method_mobile')[0];
    for(var i = 0; i < btn_box.length; i++){
        var temp = btn_box[i];
        if(temp === elem){
            temp.className = 'on';
        }else{
            temp.className = '';
        }
    }

    if(focused === 'pc'){
        pc_box.style.display = 'block';
        mobile_box.style.display = 'none';
    }else if(focused === 'mobile'){
        pc_box.style.display = 'none';
        mobile_box.style.display = 'block';
    }
}



function error_msg(e){
    e.preventDefault();
    window.alert('작업중입니다.');
}



// 전체과정 과정 보기 형식(리스트형/이미지형)
function view_type(elem, type){
    var other_btn, target_box, other_box;
    var target = 'list', other = 'image';

    if(type === 'image'){
        target = 'image';
        other = 'list';
    }else{
        target = 'list';
        other = 'image';
    }

    other_btn = document.querySelector('.process_filter_item.'+other+' p');
    target_box = document.querySelector('.process_search_result.'+target);
    other_box = document.querySelector('.process_search_result.'+other);

    elem.className = 'on';
    other_btn.className = '';
    target_box.style.display = 'block';
    other_box.style.display = 'none';
}



// pc header 2depth 메뉴 표시
function dropdown_part(item){
    if(!menu_click_pc){
        var menu = item.querySelector('.menu_over_2depth');
        menu.style.display = 'block';
    }
}

// pc header 2depth 메뉴 숨김
function dropdown_part_out(item){
    var menu = item.querySelector('.menu_over_2depth');
    menu.style.display = 'none';
}



// IE 환경 설정 Tab
function browser_set(btn, type){
    var target, boxes;
    var buttons = document.querySelectorAll('.preference_tab button');
    for(var i = 0; i < buttons.length; i++){
        var item = buttons[i];
        if(item === btn){
            item.className = 'on';
        }else{
            item.className = '';
        }
    }

    if(type === '9' || type === '11'){
        target = document.querySelector('.popup_content.preference.normal');
    }else if(type === '10'){
        target = document.querySelector('.popup_content.preference.privacy_more');
    }else{
        switch(type){
            case 'v9':
                target = document.querySelector('.popup_content.set.type4');
                break;
            case 'v10':
                target = document.querySelector('.popup_content.set.type3');
                break;
            case 'v11':
                target = document.querySelector('.popup_content.set.type2');
                break;
            default:
                target = document.querySelector('.popup_content.set.type1');
                break;
        }
    }

    var boxes_browser = document.querySelectorAll('.popup_content.preference');
    var boxes_player = document.querySelectorAll('.popup_content.set');
    if(boxes_browser.length !== 0){
        boxes = boxes_browser;
    }else{
        boxes = boxes_player;
    }
    for(var j = 0; j < boxes.length; j++){
        var box = boxes[j];
        if(box === target){
            box.style.display = 'block';
        }else{
            box.style.display = 'none';
        }
    }
}