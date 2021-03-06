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
            
            if (x>0.000 && x<0.01)
            {
                $(this).addClass("Rainfall_1");
                return "T";
            }
            else if (x>=0.01 && x<0.1)
            {
              $(this).addClass("Rainfall_2");
            }
            else if (x>=0.2 && x<0.5)
            {
              $(this).addClass("Rainfall_3");
            }
            else if (x>=0.5 && x<1.0)
            {
              $(this).addClass("Rainfall_4");
            }
            else if (x>=1.0 && x<1.5)
            {
              $(this).addClass("Rainfall_5");
            }
            else if (x>=1.5 && x<2.0)
            {
              $(this).addClass("Rainfall_6");
            }
            else if (x>=2.0 && x<2.5)
            {
              $(this).addClass("Rainfall_7");
            }
            else if (x>=2.5 && x<3.0)
            {
              $(this).addClass("Rainfall_8");
            }
            else if (x>=3.0 && x<3.5)
            {
              $(this).addClass("Rainfall_9");
            }
            else if (x>=3.5 && x<4.0)
            {
              $(this).addClass("Rainfall_10");
            }
            else if (x>4.0 && x<5.0)
            {
              $(this).addClass("Rainfall_11");
            }
            else if (x>=5.0 && x<6.0)
            {
              $(this).addClass("Rainfall_12");
            }
            else if (x >= 6.0)
            {
              $(this).addClass("Rainfall_13");
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
                background-color:A9A9A9;
                }

                td.Rainfall_3
                {
                font-weight:bold;
                background-color:696969;
                }

                td.Rainfall_4
                {
                font-weight:bold;
                background-color:7CFC00;
                }

                td.Rainfall_5
                {
                font-weight:bold;
                background-color:32CD32;
                }

                td.Rainfall_6
                {
                font-weight:bold;
                background-color:228B22;
                }

                td.Rainfall_7
                {
                font-weight:bold;
                background-color:006400;
                }

                td.Rainfall_8
                {
                font-weight:bold;
                background-color:FFD700;
                }

                td.Rainfall_9
                {
                font-weight:bold;
                background-color:FF8C00;
                }

                td.Rainfall_10
                {
                font-weight:bold;
                background-color:FF4500;
                }

                td.Rainfall_11
                {
                font-weight:bold;
                background-color:FF0000;
                }

                td.Rainfall_12
                {
                font-weight:bold;
                background-color:B22222;
                }

                td.Rainfall_13
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