<?xml version="1.0" encoding="iso-8859-1"?>
<xsl:stylesheet version="1.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:template match="/">
    <!--layout key = k-p12h-n13-1; k-p12h-n15-1; k-p12h-n14-1 -->
    <html>
      <head>
        <script src="http://spu-sharepoint/DWWQ/Teams/SOPA/Sub/jquery182.js" />
        
        <script>

          $(document).ready(function(){
          $('.weatherIcon').html(function(n,h){
            return '<img width="60" height="60" src="'+ h +'"/>';
          });
          });          
          
        </script>
        <style>
          table.weatherTable, table.weatherTable th, table.weatherTable td
          {
          <!--border-collapse:collapse;-->
          border:1px solid black;
          text-align:center;
          font-size:9pt;
          padding:4px;
          }
        </style>
      </head>
      <body>
        <table name="pictureForecastTable" class="weatherTable">
          <tr name="rowTime">
            <xsl:for-each select="dwml/data[@type='forecast']/time-layout[layout-key='k-p12h-n13-1' or layout-key='k-p12h-n15-1' or layout-key='k-p12h-n14-1']">
              <xsl:for-each select="start-valid-time">
                  <th>
                    <xsl:value-of select="@period-name"/>
                  </th>
                
              </xsl:for-each>
            </xsl:for-each>
          </tr>
          <tr name="rowWeatherType">
            <xsl:for-each select="dwml/data[@type='forecast']/parameters/weather/weather-conditions">
              <td>
                <xsl:value-of select="@weather-summary"/>
              </td>
            </xsl:for-each>            
          </tr>

          <tr id="rowIconLinks">
            <xsl:for-each select="dwml/data[@type='forecast']/parameters/conditions-icon/icon-link">
              <td class="weatherIcon">
                <xsl:value-of select="."/>
              </td>
            </xsl:for-each>  
          </tr>


          

        </table>
        
      </body>
    </html>
    </xsl:template>
</xsl:stylesheet>
