// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require foundation
//= require chosen-jquery
//= require_tree .
//= require jquery.ui.datepicker
//= require jquery.ui.slider

$(function(){ $(document).foundation(); });


$(function() {
    $(".new-task").hide();
    $(".new-task-btn").click(function() {
      $(".new-task").slideToggle(0);
    });

    $(".footnote-row").hide();
    $(".streaking").mouseover(function(){
      $(".footnote-row").show;
    });

    $(".chosen").chosen({width: "100%"});



  });