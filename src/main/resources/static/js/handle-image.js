$(document).ready(function () {
    // Hàm xử lý khi chọn hình ảnh
    $('#image_url').on('change', function () {
        var input = this;

        // Kiểm tra xem có file được chọn không
        if (input.files && input.files[0]) {
            var reader = new FileReader();

            // Khi file được load, cập nhật src cho thẻ img
            reader.onload = function (e) {
                $('#image-preview').attr('src', e.target.result).show(); // Hiển thị hình ảnh
            };

            // Đọc file hình ảnh
            reader.readAsDataURL(input.files[0]);
        }
    });

    // Kiểm tra xem thẻ img có src từ product.imageUrl không
    if ($('#image-preview').attr('src') === "") {
        // Nếu không có src từ cơ sở dữ liệu (tức là trang thêm sản phẩm mới), ẩn ảnh
        $('#image-preview').hide();
    } else {
        // Nếu có src từ product.imageUrl (tức là trang cập nhật), hiển thị ảnh
        $('#image-preview').show();
    }
});
