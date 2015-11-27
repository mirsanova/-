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
	          $('#categories').prepend('<li class="list-group-item" id="li_'+data[i].id+'">' + '<a href ="' + data[i].link+'" id ="del_cat' + data[i].id+'">' + data[i].description +"</a>" +'<i class="fa fa-pencil"></i>'+'<a id ="' + data[i].id+ '" class="del_link" href ="/deliveries">'+'<i class="fa fa-times"></i>'+"</a>"+"</li>");
	          
	        }  
	      }
		});
	  }
	
	}    
    
  });

$('#categories').on('click','.del_link', function (e) {
	e.preventDefault();
	var id_cat = this.id;

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

         
          $("li[id=li_" + id_cat + "]").remove();
          

          $("div[id=" + id_cat + "]").remove();

          $("ul[id=del_list" + id_cat + "]").remove();          
         
        }

    });    
  });







  
});


