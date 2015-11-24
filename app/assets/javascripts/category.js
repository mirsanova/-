$(function() {


$('#categories_search input').keyup(function(e) {

  e.preventDefault();
  search = $('#search').val()
 $.ajax({
      type: "POST",
      dataType: "json",
      url: "/deliveries/search",
      data: { category_id: $('#search').val()},
      error: function(data, textStatus, xhr){
         console.log('error');
        },
      success: function(data, textStatus, xhr) {
      	console.log('succes');
      	console.log($('#search').val());

         


      }
    });


});
});