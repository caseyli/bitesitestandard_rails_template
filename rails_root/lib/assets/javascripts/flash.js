$(function(){
	$("#close-flash").click(function(){
		$(".flash").slideUp(100);
		return false;
	});
	
	/* AUTO SLIDE UP OF FLASH MESSAGE */
	if($(".flash").length > 0) {
	  setTimeout(function(){
	    $(".flash").slideUp(100);
	  }, 5000);
	}
});