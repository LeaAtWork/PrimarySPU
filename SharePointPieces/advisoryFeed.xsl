<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0"
  xmlns:atom="http://www.w3.org/2005/Atom"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output
    method="html"
    media-type="text/html"
    indent="yes"
    encoding="UTF-8"/>

  <!--use with http://alerts.weather.gov/cap/wwaatmget.php?x=WAC033&y=0 -->
  
  
  <xsl:template match="/">
    <html xmlns="http://www.w3.org/1999/xhtml" lang="en" xml:lang="en">
      <header>

        <style>
          table.feedTable, table.feedTable th, table.feedTable td
          {
          border-collapse:collapse;
          border:1px solid black;
          padding:4px;
          font-family:Arial, Helvetica, sans-serif;
          }

          td.feedHeader
          {
          background-color:#6495ED;
          color:white;
          font-weight:bold;
          font-size:12pt;
          text-align:center;
          }

          td.feedEntryTitle
          {
          background-color:white;
          color:black;
          font-weight:bold;
          text-decoration:underline;
          font-size:10pt;
          }
        </style>
      </header>
      
      <body>
        
        <table class="feedTable">
          <tr>
            <td class="feedHeader" colspan="2">
              <xsl:value-of select="atom:feed/atom:title"/>
            </td>
          </tr>
          <xsl:for-each select="atom:feed/atom:entry">
          <tr >
            <td class="feedEntryTitle">
              <a class="feedLink" href="{atom:link/@href}" target="_blank">
                <xsl:value-of select="atom:title"/>
              </a>
            </td>
          </tr>
          <tr>
              <td class="feedEntryBody" colspan="2">
                <xsl:value-of select="atom:summary"/>
              </td>
          </tr>
          </xsl:for-each>
        </table>
      </body>
    </html>
  </xsl:template>


</xsl:stylesheet>


