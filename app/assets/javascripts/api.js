$(function() {

  var form = $('#form'),
      msg = $('#msg'),      
      submit = form.find('#test_submit'),
      price = form.find('#price'),
      term_min = form.find('#term_min'),
      term_max = form.find('#term_max');      

  submit.on("click", function(){
   
    $.ajax({
      type: "POST",
      dataType: "json",
      url: "/api",
      data: { from_location: $('#from_location option:selected').val(), to_location: $('#to_location option:selected').val(), weight: $('#weight').val() },
      error: function(){
        alert("error");
        },
      success: function(data, textStatus, xhr) {
        if (data.err_msg == null) {
          msg.children().text('');
          msg.css('display', 'none');
          price.val(data.price);
          term_min.val(data.term_min);
          term_max.val(data.term_max);
        } else {
          msg.children().text(data.err_msg);
          msg.css('display', 'block')
          price.val('');
          term_min.val('');
          term_max.val('');
        };
      }
    });

  });
});
