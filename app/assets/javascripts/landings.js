Stripe.setPublishableKey('pk_test_VEJnk6XajqyeuvrihwCjdoXn');

 var stripeResponseHandler = function(status, response) {
      var $form = $('#payment-form');

      if (response.error) {
        // Show the errors on the form
        $form.find('.payment-errors').text(response.error.message);
        $form.find('button').prop('disabled', false);
      } else {
        // token contains id, last4, and card type
        var token = response.id;
        // Insert the token into the form so it gets submitted to the server
        $form.append($('<input type="hidden" name="stripeToken" />').val(token));
        // and re-submit
        $form.get(0).submit();
      }
    };

    jQuery(function($) {
      $('#payment-form').submit(function(e) {
        e.preventDefault();
        var $form = $(this);

        $(".card-number").removeAttr("name");
        $(".card-cvc").removeAttr("name");
        $(".card-expiry").removeAttr("name");

        // Disable the submit button to prevent repeated clicks
        $form.find('button').prop('disabled', true);

        // console.log($form);

        Stripe.card.createToken({
            number: $('.card-number').val(),
            cvc: $('.card-cvc').val(),
            exp_month: $('.card-expiry').val().slice(0,2),
            exp_year: $('.card-expiry').val().slice(5,7)
        }, stripeResponseHandler);

        // Prevent the form from submitting with the default action
        return false;
      });
    });