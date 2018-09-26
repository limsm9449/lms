
// 팝업 표시
function popup(page){
    var temp = document.getElementById(page);
    temp.style.display = 'block';
}

function new_window(page){
    window.open('./html/popup/'+page+'.html', 'mywin', 'width=800, height=760');
}

// 팝업 닫기
function close_popup(page){
    var temp = document.getElementById(page);
    temp.style.display = 'none';
}
