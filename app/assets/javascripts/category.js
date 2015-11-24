$(function() {


$('#categories_search input').keyup(function(e) {

  e.preventDefault();
  search = $('#search').val()
 $.ajax({
      type: "POST",
      dataType: "json",
      url: "/deliveries/search",
      data: { search: $('#search').val()},
      error: function(data, textStatus, xhr){
         console.log('error');
        },
      success: function(data, textStatus, xhr) {

        // $('#categories').html("");
        //

        var length = $('ul#categories li').length;
        var cur_id = 0
        // for(var i=0; i < length-2; i++) {
        //     $("li'").remove();
        // }
        // 
        console.log(length);

        $('ul#categories li').each(function () { // loops through all li
            if (cur_id < length-2) {
              $(this).remove(); // Remove li one by one
            }
            
            cur_id++;
        });

        for (i in data) {
          
           $('#categories').prepend('<li class="list-group-item" >' + '<a href ="' + data[i].link  + '">' + data[i].description + "</a> </li>");
    //            <li class="list-group-item">
    //   <%= link_to "#{category.description}", edit_category_path(category) %>
    //           $('#categories').append(" <li class='" + data[i].name + " fsadfdsa");
    // </li>
          // $('#categories').append(data[i].link);
          //  $('#categories').append(data[i].name);          
        }







   //   data.categories.forEach(function(category){
   //   $user_html = $("<div class='user'>" + category.name + "<!-- etc --!/></div>");
   //   $('#usersList').append($user_html);
   // });
      }
    });

});


});
