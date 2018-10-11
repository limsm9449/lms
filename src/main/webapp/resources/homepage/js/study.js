
// Graph view handler
window.addEventListener("load", function (event) {
    var average_num = document.querySelector('#percentage_average').innerHTML;
    var my_num = document.querySelector('#percentage_my').innerHTML;
    var average_only_num = average_num.replace(/%/, '');
    var my_only_num = my_num.replace(/%/, '');

    average_only_num *= 1;
    my_only_num *= 1;

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
    if(btn.classList){
        btn.classList.add('on');
        inactive_btn.classList.remove('on');
    }
    inactive_list.style.display = 'none';
}


// Popup Open
function new_window(page) {
    window.open('../popup/' + page + '.html', 'mywin_' + page, 'width=800, height=840');
}

// Popup Close
function close_popup(page) {
    var temp = document.getElementById(page);
    temp.style.display = 'none';
}