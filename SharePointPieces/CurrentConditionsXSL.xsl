<?xml version="1.0" encoding="ISO-8859-1"?>
<xsl:stylesheet version="1.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:template match="/">
	<html>
	<head>
		<script type="text/javascript">
            function loadingScripts()
            {
            weatherCode();
            myFunction();

            }

            function myFunction()
            {
            var temptext =document.getElementById("temperature_value").innerHTML
            var x =tIcon(temptext);
            document.getElementById("tempicon").src=x;
            }

            function tIcon(t)
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
            return i;
            }
            function weatherCode()
            {
            var str = document.getElementById("weather").innerHTML

            var reg1 =new RegExp("/Fog|Haze|Clear|Fair|Mostly Cloudy|A Few Clouds|Overcast|Partly Cloudy|Rain|Freezing Rain|Drizzle|Freezing Drizzle|Light Rain|Showers|Rain Showers|Showers Rain|Snow|Ice Pellets|Hail|Thunderstorm/");

            y=reg1.exec(str);

            z=wIcon(y[0]);

            document.getElementById("weather_icon").src=z;
            }

            function wIcon(c)
            {

            var w
            switch (c)
            {
            case "Fog"||"Haze":
            w="http://spu-sharepoint/DWWQ/Teams/SOPA/Graphics/fg.jpg";
            break;
            case "Fair"||"Clear":
            w="http://spu-sharepoint/DWWQ/Teams/SOPA/Graphics/skc.jpg";
            break;
            case "Mostly Cloudy":
            w="http://spu-sharepoint/DWWQ/Teams/SOPA/Graphics/bkn.jpg";
            break;
            case "A Few Clouds":
            w="http://spu-sharepoint/DWWQ/Teams/SOPA/Graphics/sct.jpg";
            break;
            case "Partly Cloudy":
            w="http://spu-sharepoint/DWWQ/Teams/SOPA/Graphics/pcloudy.jpg";
            break;
            case "Overcast":
            w="http://spu-sharepoint/DWWQ/Teams/SOPA/Graphics/ovc.jpg";
            break;
            case "Rain":
            w="http://spu-sharepoint/DWWQ/Teams/SOPA/Graphics/shra.jpg";
            break;
            case "Light Rain"||"Drizzle":
            w="http://spu-sharepoint/DWWQ/Teams/SOPA/Graphics/ra1.jpg";
            break;
            case "Freezing Rain"||"Freezing Drizzle":
            w="http://spu-sharepoint/DWWQ/Teams/SOPA/Graphics/fzrara.jpg";
            break;
            case "Rain Showers"||"Showers"||"Showers Rain":
            w="http://spu-sharepoint/DWWQ/Teams/SOPA/Graphics/shra.jpg";
            break;
            case "Snow":
            w="http://spu-sharepoint/DWWQ/Teams/SOPA/Graphics/sn.jpg";
            break;
            case "Thunderstorm":
            w="http://spu-sharepoint/DWWQ/Teams/SOPA/Graphics/tsra.jpg";
            break;
            case "Ice Pellets"||"Hail":
            w="http://spu-sharepoint/DWWQ/Teams/SOPA/Graphics/ip.jpg";
            break;
            default:
            w=c;
            break;
            }
            return w;
            }
        </script>
		<script type="text/javascript">
				
		</script>
		<style>
			.formtable
				{
				
				}
			.widgit_area
				{
				border-style:solid;
				border-color:#A394FF;
				}
			.widgit_banner
				{
				postion:relative;
				left:0px;
				top:0px;
				z-index:-1;
				text-align:center;
				background-color:#A394FF;
				font-size:200%;
				font-weight:bold;
				color:white;
				height:30px;
				}
			.float_left
				{
				float:left;
				margin:5px;
				}
			.float_right
				{
				float:right;
				margin:5px;
				}
		</style>
	</head>			
	<body>
		
		
		<div id="currentconditions_container" class="widgit_area" style="width:500px;">
			<div id="currentconditions_header">
				<div><img id="header_icon" class="float_left" src="http://spu-sharepoint/DWWQ/Teams/SOPA/Graphics/UmbrellaGuy_mini.png" onload="loadingScripts()" /></div>
				<div id="header_banner" class="widgit_banner">Current Conditions</div>
			</div>
			<div id="location_info" style="text-align:center">
				<div id="location_name" style="font-size:125%; font-weight:bold;"><xsl:value-of select="current_observation/location"/></div>
				<div id="location_position">Lat: <xsl:value-of select="current_observation/latitude" />  Lon: <xsl:value-of select="current_observation/longitude" /></div>
				<div id="observation_time"><xsl:value-of select="current_observation/observation_time" /></div>
				<br />
			</div>
			
				
			<div name="temperatureiconmodule" class="float_left" style="width:200px; border-style:none; border-width:1px">
				<div id="temperature_value" style="display:none;"><xsl:value-of select="current_observation/temp_f"/></div>
				<table id="formatting" class="formtable" style="text-align:center; font-weight:bold;">
                    <tr>
                        <td style="padding:10px;">
                            <table id="weatherdescription" style="text-align:center;font-weight:bold;">
                                <tr>
                                    <td>
                                        <img id="weather_icon" src="image" ></img>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <div id="weather" >
                                            <xsl:value-of select="current_observation/weather"/>
                                        </div>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    
                        <td>
                            <table id="temperturetable" style="text-align:center;font-weight:bold;">
                                <tr>
                                    <td style="padding:5px;white-space:wrap;vertical-align:text-bottom;" id="temperature_pretty">
                                        <xsl:value-of select="current_observation/temperature_string"/>
                                    </td>
                                </tr>
                                <tr>

                                    <td>
                                        <div style="display:inline;">
                                            <img id="tempicon"  src="image"></img>
                                        </div>
                                    </td>
                                </tr>

                            </table>
                        </td>

                    </tr>
                    
					
				</table>
				
			</div>
			<table id="observation_table" class="float_right">

				<colgroup>
					<col span="1" style="width:100;text-align:left;
						font-weight:bold;" />
					<col span="1" style="width:200;text-align:right;
						font-weight:normal;" />
				</colgroup>
				<tr name="humidity" style="background-color:#f0f0f0;">
					<th>Humidity:</th>
					<td><xsl:value-of select="current_observation/relative_humidity"/>%</td>
				</tr>
				<tr name="windspeed" style="background-color:white;">
					<th>Wind Speed:</th>
					<td><xsl:value-of select="current_observation/wind_string"/></td>
				</tr>
				<tr name="pressure" style="background-color:#f0f0f0;">
					<th>Barometer:</th>
					<td><xsl:value-of select="current_observation/pressure_in"/> in (<xsl:value-of select="current_observation/pressure_mb"/> mb)</td>
				</tr>
				<tr name="dewpoint" style="background-color:white;">
					<th>Dewpoint:</th>
					<td><xsl:value-of select="current_observation/dewpoint_string"/> </td>
				</tr>
				<tr name="visibility" style="background-color:#f0f0f0;">
					<th>Visibility</th>
					<td><xsl:value-of select="current_observation/visibility_mi"/> mi.</td>
				</tr>

			</table>
			
		</div>
	</body>
	</html>
</xsl:template>
</xsl:stylesheet>