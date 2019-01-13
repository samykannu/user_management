
// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require gentelella/vendors/jquery/dist/jquery
//= require jquery.remotipart
//= require jquery-ui
//= require jquery_ujs
//= require bootstrap/dist/js/bootstrap
//= require bootstrap3-typeahead
//= require parsleyjs/dist/parsley.min
//= require metisMenu/dist/metisMenu
//= require sb-admin-2
//= require jquery.dataTables
//= require dataTables.bootstrap
//= require bootstrap-multiselect
//= require gentelella/src/js/helpers/smartresize
//= require gentelella/src/js/custom
//= require admin_custom
//= require bootstrap-editable.min
//= require bootbox.min
//= require moment
//= require bootstrap-datetimepicker

var info = L.control();
var ward_ajax, ward_geojson, district_ward_geojson;
var ready = function() {
    setTimeout(function () {
        $('.leaflet-control-zoom-out').text('|');
        $('.leaflet-control-zoom-out').css({'font-size': "14px"});
    }, 100);

    // var pos = $(".side-menu .active").position().top;
    // console.log("Actual : " + pos);
    // pos = pos - 221 ;
    // console.log("Now : " + pos);
    // $('.menu_section').animate({scrollTop:pos}, 'slow');
}

$(document).on('click', '.close-flash', function(){
   $('.notice').remove();
});

$(document).ready(ready);
$(document).on('turbolinks:load', ready);
