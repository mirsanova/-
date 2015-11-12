$(function() {
  $('#test_submit').on("click", function(){
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
          $('#price').val(data.price)
          $('#term_min').val(data.term_min)
          $('#term_max').val(data.term_max)
        } else {
          alert(data.err_msg);
          $('#price').val('')
          $('#term_min').val('')
          $('#term_max').val('')
        };
      }
    });

  });
});
