// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require bootstrap-sprockets
//= require_tree .


// Turbo links events are used here 

$(document).on("ready page:load", function(){
	
	//Notice : Fadein and fadeout
	$('#notice').addClass('animated fadeInLeft');
	setTimeout(function(){
		$('#notice').addClass('animated fadeOutRight');
	},3000);

	//Error & warning messages : Shake
	$('#error').addClass('animated shake');
	$('#warning').addClass('animated shake');
	//hide loading on page loads
	$('.loading').hide();
});



 $(document).on('page:change', function() {
	 $('.loading').hide();
	 $('.blur-all').removeClass('blur-all');
 });

// Loading Animation when page is fetched
 $(document).on('page:fetch', function() {
 		$('.loading').show();
 		//make everything in section blurred
 		$('section > *').wrap('<div class="blur-all">');
 });
