$(function(){
	$(".main-visual-slide").bxSlider({
		auto:true,
		autoHover:true,
		autoControls:true,
		autoControlsCombine:true
		/*pause:2000,
		autoHover:true,
		autoControls:true,
		autoControlsCombine:true*/
	});

	$('.grid').isotope({
		// options
		itemSelector: '.grid-item',
		layoutMode: 'fitRows'
	});    
});