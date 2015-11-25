$(function() {

  var form = $('#new_delivery'),
      msg = $('#msg'),
      calculate = form.find('#calculate'),
      price = form.find('#delivery_price'),
      term_min = form.find('#delivery_term_min'),
      term_max = form.find('#delivery_term_max');


$('#calculate').on('click',function(e) {

  e.preventDefault();
  $.ajax({
      type: "POST",
      dataType: "json",
      url: "/deliveries/calculate_ems",
      data: { category_id: $('#delivery_category_id').val(), from_location: $('#delivery_from_location option:selected').val(), to_location: $('#delivery_to_location option:selected').val(), weight: $('#delivery_weight').val() },
      error: function(data, textStatus, xhr){
          msg.children().text(data.responseJSON.text);
          msg.css('display', 'block')
          price.val('');
          term_min.val('');
          term_max.val('');
        },
      success: function(data, textStatus, xhr) {
        msg.children().text('');
        msg.removeAttr('style');
        price.val(data.price);
        term_min.val(data.term_min);
        term_max.val(data.term_max);
      }
    });

  });
});