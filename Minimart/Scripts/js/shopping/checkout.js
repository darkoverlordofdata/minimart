/*
 *  js/shopping/checkout.js
 *
 */
$(function () {
    var template = Liquid.Template.parse(
            "<option value=\"\" selected=\"selected\"></option>" +
            "{% for state in states %}" +
            "<option value=\"{{ state.code }}\">{{ state.name }}</option>" +
            "{% endfor %}"
            ),
        states = {
            US: [
                { code: 'AL', name: "Alabama"},
                { code: 'AK', name: "Alaska"},
                { code: 'AZ', name: "Arizona"},
                { code: 'AR', name: "Arkansas"},
                { code: 'CA', name: "California"},
                { code: 'CO', name: "Colorado"},
                { code: 'CT', name: "Connecticut"},
                { code: 'DE', name: "Delaware"},
                { code: 'DC', name: "District of Columbia"},
                { code: 'FL', name: "Florida"},
                { code: 'GA', name: "Georgia"},
                { code: 'HI', name: "Hawaii"},
                { code: 'ID', name: "Idaho"},
                { code: 'IL', name: "Illinois"},
                { code: 'IN', name: "Indiana"},
                { code: 'IA', name: "Iowa"},
                { code: 'KS', name: "Kansas"},
                { code: 'KY', name: "Kentucky"},
                { code: 'LA', name: "Louisiana"},
                { code: 'ME', name: "Maine"},
                { code: 'MD', name: "Maryland"},
                { code: 'MA', name: "Massachusetts"},
                { code: 'MI', name: "Michigan"},
                { code: 'MN', name: "Minnesota"},
                { code: 'MS', name: "Mississippi"},
                { code: 'MO', name: "Missouri"},
                { code: 'MT', name: "Montana"},
                { code: 'NE', name: "Nebraska"},
                { code: 'NV', name: "Nevada"},
                { code: 'NH', name: "New Hampshire"},
                { code: 'NJ', name: "New Jersey"},
                { code: 'NM', name: "New Mexico"},
                { code: 'NY', name: "New York"},
                { code: 'NC', name: "North Carolina"},
                { code: 'ND', name: "North Dakota"},
                { code: 'OH', name: "Ohio"},
                { code: 'OK', name: "Oklahoma"},
                { code: 'OR', name: "Oregon"},
                { code: 'PA', name: "Pennsylvania"},
                { code: 'RI', name: "Rhode Island"},
                { code: 'SC', name: "South Carolina"},
                { code: 'SD', name: "South Dakota"},
                { code: 'TN', name: "Tennessee"},
                { code: 'TX', name: "Texas"},
                { code: 'UT', name: "Utah"},
                { code: 'VT', name: "Vermont"},
                { code: 'VA', name: "Virginia"},
                { code: 'WA', name: "Washington"},
                { code: 'WV', name: "West Virginia"},
                { code: 'WI', name: "Wisconsin"},
                { code: 'MY', name: "Wyoming" }

            ],
            CA: [
                { code: 'AB', name: 'Alberta' },
                { code: 'BC', name: 'British Columbia'},
                { code: 'MB', name: 'Manitoba'},
                { code: 'NB', name: 'New Brunswick'},
                { code: 'NL', name: 'Newfoundland and Labrador'},
                { code: 'NT', name: 'Northwest Territories'},
                { code: 'NS', name: 'Nova Scotia'},
                { code: 'NU', name: 'Nunavut'},
                { code: 'ON', name: 'Ontario'},
                { code: 'PE', name: 'Prince Edward Island'},
                { code: 'QC', name: 'Quebec'},
                { code: 'SK', name: 'Saskatchewan'},
                { code: 'YT', name: 'Yukon'}
            ]
        };

    $("#state").html(template.render({ states: states[$("#country").val()] }));

    $("#country").bind('change', function (e) {
        $("#state").html(template.render({ states: states[$(e.target).val()] }));
    });


    $("#order_form").validate({
        submitHandler: function(form) {
            form.submit();
        },

        rules: {
            name: "required",
            email: {
                required: true,
                email: true
            },
            phone: "required",
            ship_to: "required",
            phone: "required",
            address1: "required",
            city: "required",
            country: "required",
            state: "required",
            zip: "required"
        },
        messages: {
            name: "Please enter your name",
            email: "Please enter a valid email address",
            phone: "Please enter a valid phone number",
            ship_to: "Please enter the ship to name",
            address1: "Please enter the ship to address",
            city: "Please enter the ship to city",
            country: "Please enter the ship to country",
            state: "Please enter the ship to state",
            zip: "Please enter the ship to zip"
        }
    });

});
