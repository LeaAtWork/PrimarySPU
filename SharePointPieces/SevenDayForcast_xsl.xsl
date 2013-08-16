<?xml version="1.0" encoding="ISO-8859-1"?>
<xsl:stylesheet version="1.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:template match="/">
    <!--This is a little odd because the xml feed has the date offset from the time period by 12 hours.-->
	<html>
        <head>
          <script src="http://spu-sharepoint/DWWQ/Teams/SOPA/Sub/jquery182.js" />
          <script>
            <![CDATA[

            $(document).ready(function(){
            $(".rainfall").text(function(i, o){
            var onumber=+o;

            if (onumber>0.09 && onumber<0.25)
            {
              $(this).addClass("SomeRainfall");
            }
            else if (onumber >= 0.25)
            {
              $(this).addClass("HeavyRainfall");
            }
            else
            {
              $(this).addClass("NoRainfall");           
            }
            
            });

            });
            ]]>
          </script>
        </head>
        <body>
          <script>
            $(document).ready(function(){
            $(".TimeCode").html(function(n,t){
            switch(t)
            {
            case "00":
            x="5pm";
            break;
            case "06":
            x="11pm";
            break;
            case "12":
            x="5am";
            break;
            case "18":
            x="11am";
            break;
            default:
            x="xxx";
            break;
            }
            return x;
            });
            });
          </script>
          <script>
            <!-- North = 0, West = 270, South = 180, East = 90-->
            <![CDATA[
            $(document).ready(function(){
            $('.windAngle').html(function(n,h){
            var angle = +h
            var imgPath="http://spu-sharepoint/DWWQ/Teams/SOPA/Graphics/"
            var imgName
            var d
            
            if (angle<12 || angle>=348)
            {
              imgName="arrow_0.png";
              d="N";
            }
            else if (angle>=12 && angle <35)
            {
              imgName="arrow_22.png";
              d="NNE";
            }
            else if (angle>=35 && angle<56)
            {
              imgName="arrow_45.png";
              d="NE";
            }
            else if (angle>=56 && angle<78)
            {
              imgName="arrow_67.png";
              d="ENE";
            }
            else if (angle>=78 && angle<100)
            {
              imgName="arrow_90.png";
              d="E";
            }
            else if (angle>=100 && angle<123)
            {
              imgName="arrow_112.png";
              d="ESE";
            }
            else if (angle>=123 && angle<145)
            {
              imgName="arrow_135.png";
              d="SE";
            }
            else if (angle>=145 && angle<168)
            {
              imgName="arrow_157.png";
              d="SSE";
            }
            else if (angle>=168 && angle<190)
            {
              imgName="arrow_180.png";
              d="S";
            }
            else if (angle>=190 && angle<213)
            {
              imgName="arrow_202.png";
              d="SSW";
            }
            else if (angle>=213 && angle<235)
            {
              imgName="arrow_225.png";
              d="SW";
            }
            else if (angle>=235 && angle<257)
            {
              imgName="arrow_247.png";
              d="WSW";
            }
            else if (angle>=257 && angle<280)
            {
              imgName="arrow_270.png";
              d="W";
            }
            else if (angle>=280 && angle<302)
            {
              imgName="arrow_292.png";
              d="WNW";
            }
            else if (angle>=302 && angle<325)
            {
              imgName="arrow_315.png";
              d="NW";
            }
            else if (angle>=325 && angle<348)
            {
              imgName="arrow_337.png";
              d="NNW";
            }
            else
            {
              imgName="";
              d="";
            }
            
            return '<img src="'+ imgPath + imgName +'"/><div>'+d+'</div>';
            });
            });
            ]]>
          </script>

          <style>
            table.weatherTable th
            {
            background-color:#ABD9FF ;
            }
            table.weatherTable, table.weatherTable th, table.weatherTable td
            {
            border-collapse:collapse;
            border:1px solid black;
            text-align:center;
            font-size:10pt;
            padding:4px;
            }

            td.SomeRainfall
            {
            font-weight:bold;
            color:black;
            }
            td.HeavyRainfall
            {
            font-weight:bold;
            color:red;
            }

            td.NoRainfall
            {
            font-weight:normal;
            color:black;
            }

          </style>
          
            <span id="multi-dayForecastBanner" class="widgitBanner">
                <div>Forecast For Lat: <xsl:value-of select="griddedForecast/latitude"/> Lon: <xsl:value-of select="griddedForecast/longitude"/>
                </div>
                <div>Seattle, WA</div>
            </span>
            
            <table id="ForecastTable" class="weatherTable">
                
              <tr name="rowDate">
                  <th class="firstColumn">Date</th>
                    <xsl:for-each select="griddedForecast/forecastDay">
                        <xsl:if test="position() &lt; 8">
                            <!--Only want the first 7 dates listed-->
                    <th colspan="4">
                        <xsl:value-of select="validDate"/>
                    </th>
                        </xsl:if>
                    </xsl:for-each>
                </tr>

              
                <!--The construct with the position greaterthan 2 is because the time is offset by 2 (2x6=12) from the date.  The first 2 entries for each day actually belong to the day before.-->
                
              <tr name="rowTimePeriod">
                  <th class="firstColumn">Period Ending</th>
                    <xsl:for-each select="griddedForecast/forecastDay/period">
                        <xsl:variable name="seed" select="position()"/>

                        <xsl:if test="$seed &gt; 2">
                            <td class="TimeCode">
                                <xsl:value-of select="validTime"/>
                            </td>
                                
                        </xsl:if>
                    </xsl:for-each>
                </tr>
              
              <tr name="rowTemperature">
                  <th class="firstColumn">Temperature (F)</th>
                    <xsl:for-each select="griddedForecast/forecastDay/period">
                        <xsl:variable name="tseed" select="position()"/>
                        <xsl:if test="$tseed &gt; 2">
                            <td>
                                <xsl:value-of select="temperature"/>
                            </td>
                        </xsl:if>
                    </xsl:for-each>
                </tr>

              <tr name="rowChanceOfPrecip">
                <th class="firstColumn">Chance of Precipitaiton</th>
                <xsl:for-each select="griddedForecast/forecastDay/period">
                  <xsl:variable name="qpfseed" select="position()"/>
                  <xsl:if test="$qpfseed &gt; 2">
                    <td>
                      <xsl:value-of select="pop"/>%
                    </td>
                  </xsl:if>
                </xsl:for-each>
              </tr>
              
              <tr name="rowQPF">
                <th class="firstColumn">Precipitaiton (in.)</th>
                <xsl:for-each select="griddedForecast/forecastDay/period">
                  <xsl:variable name="qpfseed" select="position()"/>
                  <xsl:if test="$qpfseed &gt; 2">
                    <td class="rainfall">
                      <xsl:value-of select="qpf"/>
                    </td>
                  </xsl:if>
                </xsl:for-each>
              </tr>

              <tr name="rowWindSpeed">
                <th class="firstColumn">Wind Speed (mph)</th>
                <xsl:for-each select="griddedForecast/forecastDay/period">
                  <xsl:variable name="wsseed" select="position()"/>
                  <xsl:if test="$wsseed &gt; 2">
                    <td>
                      <xsl:value-of select="windSpeed"/>
                    </td>
                  </xsl:if>
                </xsl:for-each>
              </tr>

              <tr name="rowWindDirection">
                <th class="firstColumn">Wind Direction</th>
                <xsl:for-each select="griddedForecast/forecastDay/period">
                  <xsl:variable name="wsseed" select="position()"/>
                  <xsl:if test="$wsseed &gt; 2">
                    <td class="windAngle">
                      <xsl:value-of select="windDirection"/>
                      
                    </td>
                  </xsl:if>
                </xsl:for-each>
              </tr>



            </table>
          
            
        </body>
	<!--12=5am  18=11am 00=5pm 06=11pm-->
	</html>
</xsl:template>
</xsl:stylesheet>