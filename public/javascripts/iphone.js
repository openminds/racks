$(function(){
  //Search stuff
  $("#term").live("keyup", function(){
    if ($("#term").val().length > 2) {
      $("#resultsplaceholder").load("/search/search?s="+$("#term").val()+" #searchresults", function(){
        $("#searchresults > div[data-role='collapsible']").collapsible();
        $("ul[data-role='listview']").listview();
      });
    };
  });
  //Show the correct values when an interface type is selected
  $("select[id$=_interface_type]").live("change", function(){
    var selected = $(this).val()
    showInterfaceValues(selected);
    //only refresh the menu when it is already loaded
    if ($("#interface_connected_to-button").length > 0) {
      $("#interface_connected_to").selectmenu("refresh", true)
    };
  });
  //Trigger the event onload to only display possible values
  $("select[id$=_interface_type]").trigger("change");
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
  if ($("#interface_name").val().length == 0 || $("form[class='new_interface']").length == 1) {
    if (selected == 1) {
      $("#interface_name").val("eth" + $("#ethernet").html());
    };
    if (selected == 2) {
      $("#interface_name").val("PW" + $("#power").html());
    };
  };
  return false;
}
