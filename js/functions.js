$(function() {
    
	
	$('#navigation ul li:first-child').addClass('first')
	$('#navigation ul li:last-child').addClass('last')
	$('section:last').addClass('last-section')
	
	$('#navigation a').hover(function()
	{
    	$(this).addClass('hover');
    }, function() {
    	$(this).removeClass('hover');
    });  	

    $('#slider .slides').nivoSlider({
    	effect:"sliceUpDownLeft",
    	directionNav:true,
        directionNavHide:false,
        captionOpacity: 1
    });
	
	$();
});