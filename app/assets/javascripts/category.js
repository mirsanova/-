$(function() {   

  $('#categories_search input').keyup(function (e) {


  	if ( e.keyCode > 46 && e.keyCode < 91 || e.keyCode > 95 && e.keyCode < 112 || e.keyCode == 8 || e.keyCode == 32){

      

	  var count = $(this).val().length,
	      num = 2;
	     
	  if(count > num || count == 0){

	    $.ajax({
	      type: "POST",
	      dataType: "json",
	      url: "/deliveries/search",
	      data: { search: $('#search').val()},
	      error: function(data, textStatus, xhr){
	        console.log('error');
	      },
	      success: function(data, textStatus, xhr) {
	        var length = $('ul#categories li').length,
	        cur_id = 0;        

	        $('ul#categories li').each(function () { 
	          if (cur_id < length-2) {
	            $(this).remove(); 
	          }
	          cur_id++;
	        });

	        for (i in data) {          
	          $('#categories').prepend('<li class="list-group-item" >' + '<a href ="' + data[i].link  + '">' + data[i].description + "</a> </li>");          
	        }  
	      }
		});
	  }
	
	}    
    
  });


$('.del_link' ).on('click', function (e) {
	e.preventDefault();
console.log(this.id );
 	$.ajax({
        type: "POST",
        url: "/deliveries/delete_category",
        dataType: "json",
        data: { category_id: this.id },
        error: function(data, textStatus, xhr){
          console.log('error');
        },
         success: function(data, textStatus, xhr) {
          var length = $('ul#categories li').length,
          cur_id = 0;        

          $('ul#categories li').each(function () { 
            if (cur_id < length-2) {
              $(this).remove(); 
            }
            cur_id++;
          });

          for (i in data) {          
            $('#categories').prepend('<li class="list-group-item" >' + '<a href ="' + data[i].link  + '">' + data[i].description + "</a> </li>");          
          }  
        }






    });
   
    
  });


  
});
