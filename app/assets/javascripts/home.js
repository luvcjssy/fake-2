function sua(id) {
    var x = document.getElementById("titleAnh" + id).innerText;
    $("#titleAnh" + id).css("display", "none");
    $("#txtTitle" + id).css("display", "block");
    document.getElementById("txtTitle" + id).value = x;
    $("#idButt" + id).css("display", "block");
}

function xoa(id) {
    $.ajax({ 
        url: '/home/delete_image',
        type: 'POST',
        headers: {'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')},
        data: {id: id},
        error: function (xhr, ajaxOptions, thrownError) {
                alert(xhr.status);
                alert(thrownError);
        } 
    }).done(
            function () {
                alert("Xóa ảnh thành công");
                location.reload();
    });
}

function huy(id) {
    $("#titleAnh" + id).css("display", "block");
    $("#txtTitle" + id).css("display", "none");
    $("#idButt" + id).css("display", "none");
}

function luu(id) {
    //var token_name = $("[name='csrf-param']").attr('content');
    //var token_value = $("[name='csrf-token']").attr('content');
    var x = document.getElementById("txtTitle" + id).value;
    $.ajax({
        url: '/home/update',
        type: 'POST',
        //beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))},
        headers: {'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')},
        data: {title: x, id: id},
        error: function (xhr, ajaxOptions, thrownError) {
                alert(xhr.status);
                alert(thrownError);
        }
    }).done(function () {
                alert("Cập nhật ảnh thành công thành công");
                $("#titleAnh" + id).css("display", "block");
                document.getElementById("titleAnh" + id).innerText = x;
                $("#txtTitle" + id).css("display", "none");
                $("#idButt" + id).css("display", "none");
            });
}

// $(function(){
//     var f = $('input[type=file]').val();
//     if (f == null ) {alert("No image has been")};
// })(jQuery)

$(function() {
  $('#check_file').click(function(event){
    var f = $('input[type=file]').val();
    if (!(f.length > 0) ) {alert("No image selected.")};
  });
});