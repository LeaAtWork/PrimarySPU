function getTempIcon(t)
{
var i
var firstchar

firstchar=t.charAt(0)

switch (firstchar)
{
	case "3":
		i="http://spu-sharepoint/DWWQ/Teams/SOPA/Graphics/30-40.png";
		break;
	case "4":
		i="http://spu-sharepoint/DWWQ/Teams/SOPA/Graphics/40-50.png";
		break;
	case "5":
		i="http://spu-sharepoint/DWWQ/Teams/SOPA/Graphics/50-60.png";
		break;
	case "6":
		i="http://spu-sharepoint/DWWQ/Teams/SOPA/Graphics/60-70.png";
		break;
	case "7":
		i="http://spu-sharepoint/DWWQ/Teams/SOPA/Graphics/70-80.png";
		break;
	case "8":
		i="http://spu-sharepoint/DWWQ/Teams/SOPA/Graphics/80-90.png";
		break;
	case "9":
		i="http://spu-sharepoint/DWWQ/Teams/SOPA/Graphics/90-100.png";
		break;
	default:
		i="out of range";
		break;
}
return i

}

