// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
$(function(){
	//init tabs
	// $("#datacenters").tabs();
	// $("#server_rack_info").tabs();
	$('.tabs').tabs();
	$(".devices_accordion").accordion({collapsible:true, active:false, icons:false, autoHeight:false});
	//Create buttons
	$(".button").button();
	
	
});

