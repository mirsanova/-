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

$('#categories').on('click','.edit_link', function (e) {
	e.preventDefault();	 
	var link_cat = $(this).parent('li').find('a:first');
	var id = link_cat.attr('id');
	var val = link_cat.text();
	var new_html = ('<input value="' + val + '" id="' + id + '">');	

	$(this).css('display','none');
	$(this).next().css('display','inline-block');
	link_cat.replaceWith(new_html);	
	$('ul#categories li input').focus();
 
  });

$('#categories').on('click','.check_link', function (e) {
	e.preventDefault();		
	var id_cat = this.id;
	var id = id_cat.substr(10);
	
	$.ajax({
        type: "POST",
        url: "/deliveries/update",
        dataType: "json",
        data: { category_id: id, description: $('input#del_cat'+id).val()},
        error: function(data, textStatus, xhr){
          console.log('error');
        },
        success: function(data, textStatus, xhr) {
        	
          
          var new_html = ('<a id="del_cat' + data.id  + '" href="/categories/' + data.id + '/edit">'+ data.description +'</a>');	

			
          $('input#del_cat'+data.id).replaceWith(new_html);
                   
         
        }
 	});
 	$(this).css('display','none');
	$(this).prev().css('display','inline-block');

  }); 

 $('#collapseOne').on("change", ":checkbox", function(){

    var $this = $(this);
    var id_del = this.id;
    var id = id_del.substr(7);    
    var status = false;
    var id_parent = $(this).parents().get(1).id;

    if ($this.is(':checked')) {
      status = true;
      $("li[id=" + id + "]").removeClass('list-group-item-danger').addClass('list-group-item-warning');
    }
    else{
      $("li[id=" + id + "]").removeClass('list-group-item-warning').addClass('list-group-item-danger');
    };
    
    $.ajax({
      type: "POST",
      url: "/deliveries/update_status",
      dataType: "json",
      data: { id: id, delivery_status: status, category_id: id_parent.substr(8)},
      error: function(data, textStatus, xhr){
        console.log('error');
      },
      success: function(data, textStatus, xhr) {
        var length = $('#collapseOne div ul li').length;
        var cur_id = 0;

        $('#collapseOne div ul[id='+id_parent+'] li').each(function () { 
          if (cur_id < length) {
            $(this).remove();
          }
          cur_id++;
        });

        for (i in data) {   

          if ( data[i].delivery_status == true )
          {
            $('#collapseOne div ul[id="del_list'+ data[i].category_id +'"]').append('<li class="list-group-item list-group-item-warning" id="'+ data[i].id +'">' +'<a href ="/deliveries/' + data[i].id +'">Доставка ' + data[i].id +'</a>' + '<input type="checkbox" name="status_'+data[i].id+'" id="status_'+data[i].id+'" checked="checked">');
          }
          else{
            $('#collapseOne div ul[id="del_list'+ data[i].category_id +'"]').append('<li class="list-group-item list-group-item-danger" id="'+ data[i].id +'">' +'<a href ="/deliveries/' + data[i].id +'">Доставка ' + data[i].id +'</a>' + '<input type="checkbox" name="status_'+data[i].id+'" id="status_'+data[i].id+'" >');       
          };            
        }
      }
    });
  });   
});


