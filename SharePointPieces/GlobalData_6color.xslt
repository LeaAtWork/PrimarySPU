<?xml version="1.0" encoding="iso-8859-1"?>
<xsl:stylesheet version="1.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:template match="/">
        <html>
            <script src="http://spu-sharepoint/DWWQ/Teams/SOPA/Sub/jquery182.js" />
            <script>
                <![CDATA[        

            $(document).ready(function(){
            $(".dataValue").text(function(i, o){
            var onumber=o.valueOf();
           
            var x=onumber/25.4;
            
            if (x>0.001 && x<0.1)
            {
                $(this).addClass("Rainfall_1");
                return "T";
            }
            else if (x>=0.1 && x<0.2)
            {
              $(this).addClass("Rainfall_2");
            }
            else if (x>=0.2 && x<0.3)
            {
              $(this).addClass("Rainfall_3");
            }
            else if (x>=0.3 && x<0.4)
            {
              $(this).addClass("Rainfall_4");
            }
            else if (x>=0.4)
            {
              $(this).addClass("Rainfall_5");
            }
            else
            {
              $(this).addClass("Rainfall_0");           
            }
            
           
            
            
            return x.toFixed(2);
            
            });

            });

            ]]>

            </script>
            <style>
                .floatingTables, .floatingTables tr, .floatingTables th, .floatingTables td
                {
                float:left;
                border-collapse:collapse;
                border:1px solid black;
                text-align:center;
                }

                .timeTable, .timeTable th, .timeTable td
                {
                float:left;
                border-collapse:collapse;
                border:1px solid black;
                }

                .timeTable, .timeTable th, .timeTable td, .floatingTables th
                {
                background-color:4682B4;
                color:white;
                }

                .timeTable th, .floatingTables th
                {
                padding:5px;
                }

                .forecastHeader
                {
                padding:15px;
                }

                td.Rainfall_0
                {
                background-color:D3D3D3;
                }

                td.Rainfall_1
                {
                font-weight:bold;
                background-color:A9A9A9;
                }

                td.Rainfall_2
                {
                font-weight:bold;
                background-color:32CD32;
                }

                td.Rainfall_3
                {
                font-weight:bold;
                background-color:FFD700;
                }

                td.Rainfall_4
                {
                font-weight:bold;
                background-color:FF8C00;
                }

                td.Rainfall_5
                {
                font-weight:bold;
                background-color:800000;
                }

            </style>


            <h3>Table shows:  <xsl:value-of select="forecast/site [@name='SPU.RG01']/siteforecast/variable/@name"/></h3>
            <h3>
                Units have been converted to inches
            </h3>
            <div class="forecastHeader">This Forecast was generated on:  <xsl:value-of select="forecast/@modelrundatetime"></xsl:value-of></div>
            
            <table class="timeTable">
                <tr>
                    <th>Date and Time</th>
                </tr>
                <xsl:for-each select="forecast/site[@name='SPU.RG01']/siteforecast">
                    <tr>
                        <td>
                            <xsl:value-of select="@validdatetime"/>
                        </td>
                    </tr>
                </xsl:for-each>
            </table>
                <xsl:for-each select="forecast/site">
                    
                        <table class="floatingTables">
                            <tr class="topRow">
                                <th>
                                    <xsl:value-of select="@name"/>
                                </th>
                            </tr>


                            <xsl:for-each select="siteforecast">
                                <tr>
                                    <td class="dataValue">
                                        <xsl:value-of select="variable/@value"/>
                                    </td>
                                </tr>
                            </xsl:for-each>
                        </table>
                   
            </xsl:for-each>
            
        </html>
    </xsl:template>
</xsl:stylesheet>