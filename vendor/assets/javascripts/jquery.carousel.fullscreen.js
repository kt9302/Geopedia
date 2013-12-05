/******************************************************************************
	Transforms the basic Twitter Bootstrap Carousel into Fullscreen Mode
	@author Fabio Mangolini
     http://www.responsivewebmobile.com
******************************************************************************/

jQuery(document).ready(function($) {

	var windowHeight = $(window).outerHeight();
	var windowWidth = $(window).outerWidth();
	$('.carousel div.item').css({'position': 'fixed', 'width': '100%', 'height': '100%'});
	$('.carousel-inner img').each(function() {
		var imgSrc = $(this).attr('src');
		console.log(imgSrc);
		$(this).parent().css({'background': 'url('+imgSrc+') center center no-repeat', 'background-size': 'cover', '-moz-background-size': 'cover'});
		$(this).remove();
	});
	
	$(window).on('resize', function() {
		resizeItems();
	});

});