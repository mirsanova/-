$(function() {


$("#categories_search input").keyup(function() {

    $.get($("#categories_search").attr("action"), $("#categories_search").serialize(), null, "script");
    return false;
  });




});