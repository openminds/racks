// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
$(function(){
	//init tabs
	$("#datacenters").tabs();
	$("#server_rack_info").tabs();
	$(".devices_accordion").accordion({collapsible:true, active:false, icons:false, autoHeight:false});
	//create the add interface links
	$('#add_interface').click(function(){
		//var interface_row = $('.interface_row').fi.html();
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
		
		$interface_table.append('<tr class="interface_row">' + $interface_row.html() + '</tr>')
	});
	
});

