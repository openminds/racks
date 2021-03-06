// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
$(function(){
  //init tabs
  $('.tabs').tabs();
  $(".devices_accordion").accordion({collapsible:true, active:false, icons:false, autoHeight:false});
  //Select the devices tab by default
  $("#server_rack_info").tabs("option", "selected", 1)
  //Show the device
  if (getParameterByName('device') != '') {
    $('.tabs').tabs({selected: 1});
    $('.devices_accordion').accordion("activate", "#show_device_" + getParameterByName("device"));
  };

  //Create buttons
  $(".button").button();

  //Autocomplete search...
  var itemSelected = false;
  $('#s').catcomplete({
    source: "/search/search.json",
    select: function(event, ui){
      if (ui.item !== undefined) {
      var url = ui.item.url
      window.location = url;
      };
      return false;
    },
    focus: function (event, ui){
      if (ui.item !== undefined) {
        $("#s").val(ui.item.value)
        itemSelected = true;
      }else{
          itemSelected = false
      };
    }
  }).keydown(function(event){
    if (event.keyCode == 13 && !itemSelected) {
      $(this).closest('form').trigger('submit');
    };
  });

  //create the add interface links
  $("#add_interface").live("click", function(){
    newInterfaceRow();
  });
  //create the link to add multiple interfaces
  $("#create_interfaces").live("click", function(){
    if ($("#count_ethernet_interfaces").val().length > 0 || $("#count_power_interfaces").val().length > 0) {
      var ethernetInterfaces = 0
      var powerInterfaces = 0
      if($("#count_ethernet_interfaces").val().length > 0){
        ethernetInterfaces = parseInt($("#count_ethernet_interfaces").val());
      };
      if($("#count_power_interfaces").val().length > 0){
        powerInterfaces = parseInt($("#count_power_interfaces").val());
      };
      var totalInterfaces = ethernetInterfaces + powerInterfaces -1;
      for (var i=0; i < totalInterfaces; i++) {
        newInterfaceRow();
      };
      for (var i=0; i <= totalInterfaces; i++) {
        if (i < ethernetInterfaces) {
          $("#device_interfaces_attributes_"+i+"_interface_type").children('option[value=1]').attr("selected", "selected");
        }else{
          $("#device_interfaces_attributes_"+i+"_interface_type").children('option[value=2]').attr("selected", "selected");
        };
        $("#device_interfaces_attributes_"+i+"_interface_type").trigger('change');
      };
      $("#quickadd").remove();
    };
  });
  //Create the links to load forms using ajax
  $("a.remote").live('click', function(){
    $("#modal_wrapper").load($(this).attr("href") +  " #modal_form", function(response, status, xhr){
      //Everything whith the attribute disabled=false set by rails shuld be removed
      $("option[disabled='false']").attr("disabled", "");
      $("#modal_form").dialog({
        modal: true,
        close: function(event, ui) {
          $("#modal_form > form > div.tabs").tabs("destroy");
          $("#modal_form > form > div.tabs").empty().remove();
          $("#modal_form").dialog("destroy");
          $("#modal_form > form ").empty().remove();
          $("#modal_wrapper").children("*").empty().remove();
        },
        width:1000,
        minHeight:300
      });
      $('#modal_form > form > div.tabs ').tabs();
      createColorAutocomplete();

      // load the company names autocomplete fields, but only if the element exists
      if ($("#device_company_names").length > 0) {
        $.get("/search/company_names.json", function(data){
          //Create the autocomplete list for company names
          $("#device_company_names").autocomplete({
            minLength: 0,
            source: function(request, response){
              response($.ui.autocomplete.filter(data, extractLast(request.term)));
            },
            focus: function() {
              // prevent value inserted on focus
              return false;
            },
            select: function( event, ui ) {
              var terms = split( this.value );
              // remove the current input
              terms.pop();
              // add the selected item
              terms.push( ui.item.value );
              // add placeholder to get the comma-and-space at the end
              terms.push( "" );
              this.value = terms.join( ", " );
              return false;
            }
          });
        });
      };
    });
    return false;
  });
  //Update the forms when an interface_type is selected
  $("select[id$=_interface_type]").live("change", function(){

    var id = $(this).attr("id").split("_")[3];
    var selected = $(this).val();
    disableInterfaces(id);
    var counter = 0;
    //count the interfaces with the selected type
    $("select[id$=_interface_type]").children("option[value='"+selected+"']").each(function (){
      if ($(this).attr("selected") == true){
        counter ++;
      };
    });
    if ($("#device_interfaces_attributes_"+ id + "_name").val() == "" ) {
      if (selected == 1){

        $("#device_interfaces_attributes_"+ id + "_name").val("eth" + counter);
      };
      if (selected == 2){
        $("#device_interfaces_attributes_"+ id + "_name").val("PW" + counter);
      };
    };
    return false;
  });
  // Update the form when a rack is selected
  $("select[id$=_selected_server_rack]").live("change", function(){
    var id = $(this).attr("id").split("_")[3];
    var selected = $(this).val();
    var interface_id
    if ($(this).closest("form").attr("class") == "edit_device") {
      interface_id = $("#device_interfaces_attributes_"+id+"_id").attr("value")
    };
    $("#device_interfaces_attributes_" + id + "_connected_to").children().remove();
    $.ajax({
      url: "/devices/collect_interfaces",
      data: {rack_id: selected, interface_id: interface_id},
      success: function(data){
        for (var i = data.length - 1; i >= 0; i--){
          $("#device_interfaces_attributes_"+id+"_connected_to").append("<option value='"+ data[i].value + "' type='"+data[i].type+"'>"+data[i].label+"</option>");
          if (data[i].selected != null){
            $("#device_interfaces_attributes_"+id+"_connected_to > option[value='"+ data[i].value + "']").attr("selected","selected");
          }
        };
        disableInterfaces(id);
      }
    });
  });
  startKonami();
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
//Disable select items
function disableInterfaces(id){
  // var id = $("select[id$=_interface_type]").attr("id").split("_")[3]
  var selected = $("select[id$="+id+"_interface_type]").children(":selected").val();
  //Disable interfaces with another type
  $("#device_interfaces_attributes_" + id + "_connected_to > option").attr("disabled", "disabled");
  $("#device_interfaces_attributes_" + id + "_connected_to > option[type="+ selected + "]").attr("disabled", "");
  $("#device_interfaces_attributes_" + id + "_connected_to > option[value='null']").attr("disabled", "");

}
function newInterfaceRow(){
  var $interface_table = $('#interface_form:nth-child(2)');
  var $interface_row = $interface_table.children(':last-child').children(':last-child').clone();
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
    //If it is the field for selecrting the rack, the name is equal to the id
    if ($(this).attr("name").indexOf("_selected_server_rack") != -1) {
      $(this).attr("name", new_id)
    }else{
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
    };
  });
  //append the new row
  $interface_table.append('<tr class="interface_row">' + $interface_row.html() + '</tr>')
  createColorAutocomplete();
  return false;
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
function split( val ) {
  return val.split( /,\s*/ );
}
function extractLast( term ) {
  return split( term ).pop();
}
function createColorAutocomplete(){
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
}
function loadJavascript(filename){
  var fileref=document.createElement('script')
  fileref.setAttribute("type","text/javascript")
  fileref.setAttribute("src", filename)
  document.getElementsByTagName("head")[0].appendChild(fileref)
}
function startKonami(){
  var pattern="3838404037393739656613"
  var entered=""
  $("body").live("keyup", function(){
    entered += event.keyCode
    if(event.keyCode == "27"){
      entered="";
    }
    if(entered == pattern){
      entered = "";
      loadJavascript("/javascripts/asteroids.min.js");
    }
  });
}
