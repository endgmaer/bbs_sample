$(document).on('change', '#sort_link_url', function () {  // フォームの値が変わったときになにかするよ！
    if ($(this).val() != '') {
        window.location.href = $(this).val();
    }
});
