
window.addEventListener("load", function (event) {
    var average_num = document.querySelector('#percentage_average').innerHTML;
    var my_num = document.querySelector('#percentage_my').innerHTML;
    var average_only_num = average_num.replace(/%/,'');
    var my_only_num = my_num.replace(/%/,'');

    average_only_num *= 1;
    my_only_num *= 1;

});