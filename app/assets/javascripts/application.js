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
//= require jquery.ui.all
//= require jquery_nested_form
//= require foundation
//= require_tree .
//= require underscore
//= require gmaps/google
//= require jquery.toggle.buttons



$(function(){ $(document).foundation(); });


// Flash fade
$(function() {
   $('.alert-box').fadeIn('normal', function() {
      $(this).delay(3000).fadeOut();
   });
});


// Datepicker code
$(function() {
  $(".datepicker").datepicker({
    format: 'mm/dd/YYYY'
  });
});


// Google Map API
// $('.control-label.checkbox').toggleButtons();



// make button toggles update hidden field
// $('.btn-group a').on('click', function(event){
//   event.preventDefault();
//   var input = $(this).siblings('.control-group').find('input[type=hidden]');
//   if(input.length>0){
//     if(input.val().toString() !== $(this).data('value').toString()){
//       input.val($(this).data('value')).trigger('change');
//     }
//   }
// });



$(function () {  
  $('#products th a').live('click', function () {  
    $.getScript(this.href);  
    return false;  
  });  
})  




    
