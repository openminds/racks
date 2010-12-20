$(function(){
	$("#term").live("keyup", function(){
		if ($("#term").val().length > 2) {
			$("#resultsplaceholder").load("/search/search?s="+$("#term").val()+" #searchresults", function(){
				$("#searchresults > div[data-role='collapsible']").collapsible();
				$("ul[data-role='listview']").listview();
			});
		};
	});
	
	$("select[id$=_interface_type]").live("change", function(){
		var selected = $(this).val()
		showInterfaceValues(selected);
		$("#interface_connected_to").selectmenu("refresh", true)
		//Fill in a default name
	});
	showInterfaceValues($("select[id$=_interface_type]").val());
});
function showInterfaceValues(selected){
	//Remove options of diffrent type
	$("#interface_connected_to").children("option").each(function(){
		if($(this).attr("type") != undefined && $(this).attr("type") != selected){
			$(this).appendTo("#hiddenOptions");
		}
	});
	$("#hiddenOptions").children("option").each(function(){
		if($(this).attr("type") == undefined || $(this).attr("type") == selected){
			$(this).appendTo("#interface_connected_to");
		}
	});
	//Fill in a default name
	if (selected == 1) {
		$("#interface_name").val("eth" + $("#ethernet").html());
	};
	if (selected == 2) {
		$("#interface_name").val("PW" + $("#power").html());
	};
	return false;
}
