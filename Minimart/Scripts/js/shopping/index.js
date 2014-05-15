/*
 *  js/shopping/index.js
 *
 */
$(function () {

    var ref = null,
        template = null,
        updateCart = function (id, qty, price) {
            console.log('updateCart ' + id + ', ' + qty + ', ' + price);
            $.post("/Cart/Update", { "productId": id, "quantity": qty, "price": price },
                function (data) {
                    $("#message").addClass("alert alert-success");
                    $("#message").html("Order updated");
                    $.post("/Cart", displayCart);
                    if ((ref = $("#row_" + id)) != null) {
                        if (ref.modal != null) {
                            ref.modal('hide');
                            $('.modal-backdrop').remove();
                        }
                    }

                }).fail(function () {
                    $("#message").addClass("alert alert-warning");
                    $("#message").html("Your order did not update");
                    if ((ref = $("#row_" + id)) != null) {
                        if (ref.modal != null) {
                            ref.modal('hide');
                            $('.modal-backdrop').remove();
                        }
                    }
                });

        },

        displayCart = function (data) {
            var i, total;

            total = 0;
            for (i in data) {
                data[i].extended = (data[i].price * data[i].quantity);
                total += data[i].extended;
            }

            $("#cartTable").html(template.render({ total: total, cart: data }));

            $(".update-cart").bind('click', function (e) {
                if (e.target.nodeName === 'BUTTON') {
                    $select = $(this).find('select');
                    updateCart($select.attr('data-id'), $select.val(), $select.attr('data-price'));
                }
            });

            $(".delete-cart").bind('click', function (e) {
                if (e.target.nodeName === 'BUTTON') {
                    $this = $(this);
                    updateCart($this.attr('data-id'), $this.attr('data-quantity'), '0.00');
                }
            });

            $(".delete-all").bind('click', function (e) {
                $.post("/Cart/Delete", function () {
                    $("#message").addClass("alert alert-success");
                    $("#message").html("Cart Deleted");
                    $.post("/Cart", displayCart);
                });
            });
        };

    /**
     * Register a decimal format filter
     */
    Filters = function(){};
    Filters.decimal = function (input) {
        return Number(input).toFixed(2);
    }
    Liquid.Template.registerFilter(Filters);

    $.get("/Content/templates/shopping/index.html", function (data) {
        template = Liquid.Template.parse(data);
        $.post("/Cart", displayCart);
    });

});
