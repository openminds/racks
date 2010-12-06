$(function(){
	$("#term").live("keyup", function(){
		if ($("#term").val().length > 2) {
			$("#resultsplaceholder").load("/search/search?s="+$("#term").val()+" #searchresults", function(){
				$("#searchresults > div[data-role='collapsible']").collapsible();
				$("ul[data-role='listview']").listview();
			});
		};
	})
});