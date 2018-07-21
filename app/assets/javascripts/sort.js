function dropsort() {
    var browser = document.sort_form.sort.value;
    location.href = browser
}

$(document).on('change', '#sort_order', function () {  // フォームの値が変わったときになにかするよ！
    if ($(this).val() != '') {
        window.location.href = $(this).val();
    }
});
