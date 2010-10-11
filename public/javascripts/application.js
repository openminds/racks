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
	
	//Autocomplete search...
	$('#s').catcomplete({
		source: "/search/ajax_search",
		select: function(event, ui){
			var url = ui.item.url
			alert(url);
			window.location = url;
			return false;
		}
	});
	
	
});
//A custom search autocomplete (using categories)
$.widget( "custom.catcomplete", $.ui.autocomplete, {
	_renderMenu: function( ul, items ) {
		var self = this,
		currentCategory = "";
		$.each( items, function( index, item ) {
			if ( item.category != currentCategory ) {
				ul.append( "<li class='ui-autocomplete-category'>" + item.category + "</li>" );
				currentCategory = item.category;
			}
			self._renderItem( ul, item );
		});
	}
});

