<script type=text/javascript>
////////////////////////////////////////// User Chosen Parameters ///////////////////////////////////////////////
var displayFirst=true			// Show the first web part on load
var menuTitle="What do you want to see?" 				//Title of the top menu. If empty, spacing will be removed
var keyWord="Info"		//The keyword in the title of all web parts used in this code.  ie any web part with the word 'Tasks' will be hidden and added to the menu
var menuType="List" 		//Enter 'List' or 'DropDown'
//--------------------------------------------------------------------------------------------------------------------------------------------------
</script>

<div class=content id=jLoadDiv></div>

<script type=text/javascript>
if(typeof jQuery=="undefined"){
	var jQPath="http://ajax.googleapis.com/ajax/libs/jquery/1.3.2/";
	document.write("<script src='",jQPath,"jquery.js' type='text/javascript'><\/script>");
}
</script>

<script type=text/javascript>
$("document").ready(function(){
  if(menuTitle!="")
  {$("#jLoadDiv").append("<p class='ms-WPHeader'><H3 class='ms-standardheader ms-WPTitle'>"+menuTitle+"</h3></p>")}
  hideZones(1,displayFirst);
});

function show(item)
{
 hideZones(0,false); //hide all web parts
 var webPart
 if(menuType=="List"){webPart=item.id}
 else if(menuType=="DropDown"&&item!="none"){webPart=item}
 else if(menuType=="DropDown"&&item=="none"){return false;}
 document.getElementById(webPart).style.display=""; //Show selected web part
}

function hideZones(writeMenu,displayFirst)
{
    var menu=""
	var menuDD=""
	if (displayFirst==false)
		{menuDD="<option value='none'>--- Select an Item ---</option>"}
    var listTitle = $("td:contains('"+keyWord+"')");//make an array of the titles of the web parts

    $.each(listTitle, function(i,e)
	{
		var listZone=listTitle[i];
		var wpnum
		if (listTitle[i].title.length!=0){
		//slice off the table title and select the web part number
		wpnum="MSOZoneCell_WebPartWPQ"+listZone.id.substring(15);
        //If not in edit mode, hide the web parts
		if (displayFirst==false)
		{
		  document.getElementById(wpnum).style.display="none";
		}
		else
		{
		  displayFirst=false;
		}
		var Title=listZone.title.split(" - ")// get rid of the description by splitting on the " - " and only showing the first part
		menu=menu+"<li><a href='javascript:show("+wpnum+");'>"+Title[0]+"</a></li>"
		menuDD=menuDD+"<option value="+wpnum+">"+Title[0]+"</a></option>"
		}
	});
    if (writeMenu==1&&menuType=="List")
		{$("#jLoadDiv").append("<ul>"+menu+"</ul>")}
	else if (writeMenu==1&&menuType=="DropDown")
		{$("#jLoadDiv").append("<select onchange='javascript:show(this.value)' id='webShowHide'>"+menuDD+"</select>")}
} //end function
</script>

