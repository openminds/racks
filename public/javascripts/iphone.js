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
		hideDifferentTypes(selected);
		$("#interface_connected_to").selectmenu("refresh", true)
	});
	hideDifferentTypes($("select[id$=_interface_type]").val());
});
function hideDifferentTypes(selected){
	$("#interface_connected_to").children("option").each(function(){
		if($(this).attr("type") != undefined && $(this).attr("type") != selected){
			$(this).appendTo("#hiddenOptions");
		}
	});
	$("#hiddenOptions").children("option").each(function(){
		if($(this).attr("type") == undefined || $(this).attr("type") == selected){
			$(this).appendTo("#interface_connected_to");
		}
	})
	return false;
}