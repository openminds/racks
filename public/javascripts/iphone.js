$.jQTouch({
	icon: 'jqtouch.png',
	backSelector: 'kjirrekjiwere',
	fixedViewPort:true,
	fullScreen:true,
	initializeTuch: 'a',
	useAnimation:true,
	preloadImages: [
	'/stylesheets/iphone/img/backButton.png',
	'/stylesheets/iphone/img/blueButton.png',
	'/stylesheets/iphone/img/cancel.png',
	'/stylesheets/iphone/img/chevron.png',
	'/stylesheets/iphone/img/grayButton.png',
	'/stylesheets/iphone/img/listArrowSel.png',
	'/stylesheets/iphone/img/listGroup.png',
	'/stylesheets/iphone/img/loading.gif',
	'/stylesheets/iphone/img/on_off.png',
	'/stylesheets/iphone/img/pinstripes.png',
	'/stylesheets/iphone/img/selection.png',
	'/stylesheets/iphone/img/thumb.png',
	'/stylesheets/iphone/img/toggle.png',
	'/stylesheets/iphone/img/toggleOn.png',
	'/stylesheets/iphone/img/toolbar.png',
	'/stylesheets/iphone/img/toolButton.png',
	'/stylesheets/iphone/img/whiteButton.png'
	]
});
$(function(){
	$("a").tap(function(){
		$("#content").load($(this).attr("href"), "#content");
		
	});
});