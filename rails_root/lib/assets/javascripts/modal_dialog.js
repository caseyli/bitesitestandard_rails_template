$(function(){
	$("#close-generic-modal-dialog-link").click(hideGenericModalDialog);
});

function showGenericModalDialog() {
	showGenericModalDialog("");
	return false;
}

function showGenericModalDialog(ihtml) {
	
	positionGenericModalDialog();
	
	var bodyHeight = $(document).height();
	$("#generic-modal-dialog-background").height(bodyHeight);
	$("#generic-modal-dialog-background").fadeIn(300);
	if(ihtml != "") {
		$("#generic-modal-dialog-content").html(ihtml);
	}
	return false;
}

function hideGenericModalDialog() {
	$("#generic-modal-dialog-background").fadeOut(300);
	return false;
}

function positionGenericModalDialog() {
	var _top = $("body").scrollTop();

	/* IE Fix */
	if(_top == 0) {
		_top = (document.documentElement && document.documentElement.scrollTop) || 
		              document.body.scrollTop;
	}

	_top = _top + 100;
	_top = _top.toString() + "px";
	$('#generic-modal-dialog-body').css('margin-top', _top);
}
