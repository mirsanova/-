$(function() {

  var form = $('#form'),
      msg = $('#msg'),
      submit = form.find('#test_submit'),
      price = form.find('#price'),
      term_min = form.find('#term_min'),
      term_max = form.find('#term_max');

  form.submit( function(e){
    e.preventDefault();

    $.ajax({
      type: "POST",
      dataType: "json",
      url: "/search/calculate_ems",
      data: { from_location: $('#from_location option:selected').val(), to_location: $('#to_location option:selected').val(), weight: $('#weight').val() },
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
