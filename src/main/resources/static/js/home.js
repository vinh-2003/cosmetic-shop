function submitSearchForm() {
    $("#searchForm").submit();
}

function getCartItemQuantityByProductId(productId) {
    return new Promise((resolve, reject) => {
        let csrfToken = $('meta[name="_csrf"]').attr('content');
        let csrfHeader = $('meta[name="_csrf_header"]').attr('content');

        $.ajax({
            type: "GET",
            url: "/api/cartItems",
            data: {
                productId: productId,
            },
            beforeSend: function (xhr) {
                xhr.setRequestHeader(csrfHeader, csrfToken); // Thêm CSRF token vào header
            },
            success: function (response) {
                console.log("Số lượng đã thêm vào giỏ hàng: " + response);
                resolve(response); // Trả về giá trị khi thành công
            },
            error: function (xhr, status, error) {
                reject(error); // Trả về lỗi nếu có
            }
        });
    });
}

function getStockQuantityByProductId(productId) {
    return new Promise((resolve, reject) => {
        let csrfToken = $('meta[name="_csrf"]').attr('content');
        let csrfHeader = $('meta[name="_csrf_header"]').attr('content');

        $.ajax({
            type: "GET",
            url: "/api/products",
            data: {
                productId: productId,
            },
            beforeSend: function (xhr) {
                xhr.setRequestHeader(csrfHeader, csrfToken); // Thêm CSRF token vào header
            },
            success: function (response) {
                console.log("Số lượng còn lại trong kho: " + response);
                resolve(response); // Trả về giá trị khi thành công
            },
            error: function (xhr, status, error) {
                reject(error); // Trả về lỗi nếu có
            }
        });
    });
}

function addOneProductToCart(productId) {
    let csrfToken = $('meta[name="_csrf"]').attr('content');
    let csrfHeader = $('meta[name="_csrf_header"]').attr('content');

    // Sử dụng Promise để đảm bảo có giá trị đúng
    Promise.all([
        getStockQuantityByProductId(productId),
        getCartItemQuantityByProductId(productId)
    ]).then(([maxQuantity, availQuantityInCart]) => {
        let availQuantity = maxQuantity - availQuantityInCart;
        console.log(1, maxQuantity, availQuantityInCart, availQuantity);

        if (availQuantity < 1) {
            swal("Cảnh báo!", "Vượt giới hạn sản phẩm có thể thêm!", "warning");
            return;
        }

        // Gửi yêu cầu thêm sản phẩm vào giỏ hàng
        $.ajax({
            type: "POST",
            url: "/api/cart/add",
            data: { productId: productId, quantity: 1 },
            beforeSend: function (xhr) {
                xhr.setRequestHeader(csrfHeader, csrfToken); // Thêm CSRF token vào header
            },
            success: function (response) {
                swal("Thành công!", response, "success");
            },
            error: function (xhr, status, error) {
                console.error("Lỗi khi thêm sản phẩm vào giỏ hàng:", error);
                swal("Lỗi!", "Có lỗi xảy ra khi thêm sản phẩm vào giỏ hàng.", "error");
            }
        });
    }).catch(error => {
        console.error("Lỗi:", error);
    });
}


function addToCart(productId) {
    // Lấy giá trị số lượng từ input dựa trên productId
    let quantity = $('#quantity_' + productId).val().trim();
    let maxQuantity = parseInt($('#quantity_' + productId).attr('max'));

    // Sử dụng Promise để lấy giá trị số lượng trong giỏ hàng
    getCartItemQuantityByProductId(productId).then(availQuantityInCart => {
        let availQuantity = maxQuantity - availQuantityInCart;
        console.log(quantity, maxQuantity, availQuantityInCart, availQuantity);

        // Kiểm tra nếu input trống
        if (quantity === "") {
            swal("Cảnh báo!", "Vui lòng nhập số lượng!", "warning");
            $('#quantity_' + productId).val(1);
            return;
        }

        // Chuyển đổi quantity sang số nguyên
        quantity = parseInt(quantity, 10);

        // Kiểm tra nếu quantity là NaN hoặc nhỏ hơn 1
        if (isNaN(quantity) || quantity < 1) {
            swal("Cảnh báo!", "Vui lòng nhập số lượng hợp lệ!", "warning");
            return;
        }

        // Kiểm tra số lượng có thể thêm vào giỏ hàng
        if (quantity > availQuantity) {
            swal("Cảnh báo!", "Vượt giới hạn sản phẩm có thể thêm!", "warning");
            $('#quantity_' + productId).val(availQuantity); // Cập nhật input với số lượng có sẵn
            return;
        }

        // CSRF token setup
        var csrfToken = $('meta[name="_csrf"]').attr('content');
        var csrfHeader = $('meta[name="_csrf_header"]').attr('content');

        // Gửi yêu cầu Ajax
        $.ajax({
            type: "POST",
            url: "/api/cart/add",
            data: { productId: productId, quantity: quantity },
            beforeSend: function (xhr) {
                xhr.setRequestHeader(csrfHeader, csrfToken); // Thêm CSRF token vào header
            },
            success: function (response) {
                swal("Thành công!", response, "success");
            },
            error: function (xhr, status, error) {
                console.error("Lỗi khi thêm sản phẩm vào giỏ hàng:", error);
                swal("Lỗi!", "Có lỗi xảy ra khi thêm sản phẩm vào giỏ hàng.", "error");
            }
        });
    }).catch(error => {
        console.error("Lỗi khi lấy số lượng sản phẩm trong giỏ hàng:", error);
    });
}


function deleteProduct(orderId) {
    var csrfToken = $('meta[name="_csrf"]').attr('content');
    var csrfHeader = $('meta[name="_csrf_header"]').attr('content');

    // Gọi API xóa sản phẩm bằng AJAX
    $.ajax({
        url: "/api/orders/" + orderId, // Đường dẫn đến API với ID sản phẩm
        type: 'DELETE',
        beforeSend: function (xhr) {
            xhr.setRequestHeader(csrfHeader, csrfToken); // Thêm CSRF token vào header
        },
        success: function () {
        },
        error: function (xhr, status, error) {
        }
    });
}

function returnHomeAndCancelOrder(orderId) {
    deleteProduct(orderId);
    window.location.href = '/home';
}

function updateCartItemQuantity(cartItemId) {
    var csrfToken = $('meta[name="_csrf"]').attr('content');
    var csrfHeader = $('meta[name="_csrf_header"]').attr('content');

    let quantity = $("#cartItemId_" + cartItemId).val().trim();
    quantity = parseInt(quantity, 10);

    $.ajax({
        type: "PUT",
        url: "/api/cartItems",
        contentType: 'application/json',
        dataType: "json",
        data: JSON.stringify({
            cartItemId: cartItemId,
            quantity: quantity,
        }),
        beforeSend: function (xhr) {
            xhr.setRequestHeader(csrfHeader, csrfToken); // Thêm CSRF token vào header
        },
        success: function (response) {
            let price = Math.round(response.price);
            let total = Math.round(response.price * response.quantity);
            let cartTotalPrice = Math.round(response.totalOfCartContainThisCartItem);

            $("#cartItemPrice_" + cartItemId).text(price + 'đ');
            $("#cartItemTotal_" + cartItemId).text(total + 'đ');
            $("#cartTotalPrice").text(cartTotalPrice + 'đ')
            // alert("don gia: " + response.price + "Tong tien: " + response.price * response.quantity);
        },
        error: function (xhr, status, error) {
        }
    });
}

function increaseQuantity(cartItemId) {
    let currentVal = parseInt($('#cartItemId_' + cartItemId).val()); // Lấy giá trị hiện tại từ ô input tương ứng
    let maxQuantity = parseInt($('#cartItemId_' + cartItemId).attr('max')); // Lấy giá trị tối đa từ thuộc tính max của ô input

    if (currentVal < maxQuantity) {
        $('#cartItemId_' + cartItemId).val(currentVal + 1); // Tăng giá trị lên 1
        // Gọi hàm cập nhật số lượng trên server
        updateCartItemQuantity(cartItemId);
    } else {
        swal("Cảnh báo!", "Vượt số lượng sản phẩm còn lại!", "warning");
        $('#cartItemId_' + cartItemId).val(maxQuantity); // Đặt lại giá trị tối đa nếu vượt quá
        updateCartItemQuantity(cartItemId);
    }
}


function decreaseQuantity(cartItemId) {
    let currentVal = parseInt($('#cartItemId_' + cartItemId).val()); // Lấy giá trị hiện tại từ ô input tương ứng
    let maxQuantity = parseInt($('#cartItemId_' + cartItemId).attr('max')); // Lấy giá trị tối đa từ thuộc tính max của ô input

    if (currentVal > 1 && currentVal <= maxQuantity) {
        $('#cartItemId_' + cartItemId).val(currentVal - 1); // Giảm giá trị đi 1
        // Gọi hàm cập nhật số lượng trên server
        updateCartItemQuantity(cartItemId);
    } else {
        swal("Cảnh báo!", "Số lượng không thể nhỏ hơn 1!", "warning"); // Hiển thị thông báo nếu giảm xuống dưới 1
        $('#cartItemId_' + cartItemId).val(1); // Đặt lại giá trị tối thiểu là 1
        updateCartItemQuantity(cartItemId);
    }
}

function handleInputQuantity(cartItemId) {
    let inputVal = parseInt($('#cartItemId_' + cartItemId).val()); // Lấy giá trị từ ô input
    let maxQuantity = parseInt($('#cartItemId_' + cartItemId).attr('max')); // Lấy giá trị tối đa từ thuộc tính max

    // Kiểm tra nếu giá trị nhập vào không hợp lệ
    if (isNaN(inputVal) || inputVal < 1) {
        swal("Cảnh báo!", "Số lượng phải lớn hơn 0!", "warning");
        $('#cartItemId_' + cartItemId).val(1); // Đặt lại giá trị là 1 nếu không hợp lệ
        updateCartItemQuantity(cartItemId);
    } else if (inputVal > maxQuantity) {
        swal("Cảnh báo!", "Vượt số lượng sản phẩm còn lại!", "warning");
        $('#cartItemId_' + cartItemId).val(maxQuantity); // Đặt lại giá trị là maxQuantity nếu vượt quá
        updateCartItemQuantity(cartItemId);
    } else {
        // Gọi hàm cập nhật số lượng trên server
        updateCartItemQuantity(cartItemId);
    }
}

function handleVoucher(orderId) {
    let csrfToken = $('meta[name="_csrf"]').attr('content');
    let csrfHeader = $('meta[name="_csrf_header"]').attr('content');

    let code = $("#voucher_code").val().trim();

    $.ajax({
        type: "PUT",
        url: "/api/orders",
        contentType: "application/json",
        dataType: "json",
        data: JSON.stringify({ orderId: orderId, code: code }),
        beforeSend: function (xhr) {
            xhr.setRequestHeader(csrfHeader, csrfToken);
        },
        success: function (response) {
            console.log(response);
            $("#voucher_respone").text(response.voucherStatus);
            $("#voucher_discount").text('-' + response.discount + 'đ');
            $("#decreasedPrice").text(response.total - response.discount + 'đ');
        },
        error: function (xhr, status, error) {
        }
    });
}