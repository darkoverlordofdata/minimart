
/*
 *  js/catalog/index.js
 *
 */

(function () {

    var ref,
        updateCart = function (id, qty, price) {
            $.post("/Cart/Update", { "productId": id, "quantity": qty, "price": price },
                function (data) {
                    $("#message").addClass("alert alert-success");
                    $("#message").html("Order updated");
                    if ((ref = $("#product0" + id)) != null) {
                        if (ref.modal != null)
                            ref.modal('hide');
                    }
                }).fail(function () {
                    $("#message").addClass("alert alert-warning");
                    $("#message").html("Your order did not update");
                    if ((ref = $("#product0" + id)) != null) {
                        if (ref.modal != null)
                            ref.modal('hide');
                    }
                });
            ;
        };

    $(".update-cart").bind('click', function (e) {
        if (e.target.nodeName === 'BUTTON') {
            $select = $(this).find('select');
            updateCart($select.attr('data-id'), $select.val(), $select.attr('data-price'));
        }
    });

}());

