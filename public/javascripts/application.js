// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
$(function(){
	//init tabs
	// $("#datacenters").tabs();
	// $("#server_rack_info").tabs();
	$('.tabs').tabs();
	$(".devices_accordion").accordion({collapsible:true, active:false, icons:false, autoHeight:false});
	if (getParameterByName('device') != '') {
		$('.tabs').tabs({selected: 1});
		$('.devices_accordion').accordion("activate", "#show_device_" + getParameterByName("device"));
	};
	if (getParameterByName('datacenter') != '') {
		$('.tabs').tabs("select", "#datacenter" + getParameterByName('datacenter'));
	};

	//Create buttons
	$(".button").button();

	//Autocomplete search...
	$('#s').catcomplete({
		source: "/search/ajax_search",
		select: function(event, ui){
			var url = ui.item.url
			window.location = url;
			return false;
		}
	});
	//create the add interface links
	$('#add_interface').click(function() {addInterface()});
	
	//Create the links to load forms using ajax
	$("a.remote").live('click', function(){
		// alert($(this).attr("href"));
		$("#modal_wrapper").load($(this).attr("href") +  " #modal_form", function(response, status, xhr){
			$("#modal_form").dialog({
				modal: true,
				close: function(event, ui) { 
					$("#modal_form > form > div.tabs").tabs("destroy");
					$("#modal_form > form > div.tabs").empty().remove();
					$("#modal_form").dialog("destroy");
					$("#modal_form > form ")().empty().remove();
					$("#modal_wrapper").children("*").empty().remove();
				},
				width:900
			});
			$('#modal_form > form > div.tabs ').tabs();
			$('#add_interface').click(function() {addInterface()});
			$("select[id$=_interface_type]").change(function(){updateSelectableInterfaces($(this))});
			$(".connection_color").autocomplete({
				source: function(request, response){
					$.ajax({
						url: "/search/find_colors",
						data: {term: request.term},
						success: function(data){
							response(data);
						}
					})
				}
			});
		});
		return false;
	});
	//Update the forms when an interface_type is selected
	$("select[id$=_interface_type]").change(function(){updateSelectableInterfaces($(this))});
});
//A custom search autocomplete (using categories)
$.widget( "custom.catcomplete", $.ui.autocomplete, {
	_renderMenu: function( ul, items ) {
		var self = this,
		currentCategory = "";
		$.each( items, function( index, item ) {
			if ( item.category != currentCategory ) {
				ul.append( "<li class='ui-menu-item ui-corner-all ui-autocomplete-category'>" + item.category + "</li>" );
				currentCategory = item.category;
			}
			self._renderItem( ul, item );
		});
	}
});
//Creation of "add_interface" links to add a new interface row to the table
function addInterface(){
	var $interface_table = $('#interface_form:nth-child(2)');
	var $interface_row = $interface_table.children(':last-child').children(':last-child').clone();
	//alert($interface_row.html());
	$interface_row.find('*[id*=device_interfaces_attributes_]').each(function(index){
		//set the correct ID
		var current_id = $(this).attr('id').split('_');
		current_id[3] = parseInt(current_id[3])+1;
		var new_id = ''
		for (var i = current_id.length - 1; i >= 0; i--){
			new_id =  current_id[i] + new_id 
			if (i>0) {
				new_id = '_' + new_id 
			};
		};
		$(this).attr("id", new_id)

		//set the correct name
		var current_name = $(this).attr('name').split('][');
		current_name[1] = parseInt(current_name[1])+1;
		var new_name = ''
		for (var i = current_name.length - 1; i >= 0; i--){
			new_name =  current_name[i] + new_name
			if (i > 0) {
				new_name = '][' + new_name
			};
		};
		$(this).attr("name", new_name)
	});
	//append the new row
	$interface_table.append('<tr class="interface_row">' + $interface_row.html() + '</tr>')
	//append the action for the cbo's
	$("select[id$=_interface_type]").change(function(){updateSelectableInterfaces($(this))});
}
function updateSelectableInterfaces(interface){
	var id = interface.attr("id").split("_")[3]
	var selected = interface.children(":selected").val();
	$("#device_interfaces_attributes_" + id + "_connected_to > option").attr("disabled", "disabled");
	$("#device_interfaces_attributes_" + id + "_connected_to > option[type="+ selected + "]").attr("disabled", "");
	$("#device_interfaces_attributes_" + id + "_connected_to > option[value='']").attr("disabled", "");
}
//get parameters from the querystring
function getParameterByName( name )
{
	name = name.replace(/[\[]/,"\\\[").replace(/[\]]/,"\\\]");
	var regexS = "[\\?&]"+name+"=([^&#]*)";
	var regex = new RegExp( regexS );
	var results = regex.exec( window.location.href );
	if( results == null )
	return "";
	else
	return decodeURIComponent(results[1].replace(/\+/g, " "));
}

