<?xml version="1.0" encoding="iso-8859-1"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:fn="http://www.w3.org/2005/xpath-functions">

    <xsl:template match="/">
        <html>
            <xsl:choose>
                <xsl:when test="function-available('substring')">
                    <p>function is supported</p>
                </xsl:when>
                <xsl:otherwise>
                    <p>function is NOT supported</p>
                </xsl:otherwise>
            </xsl:choose>
            <xsl:apply-templates/>
        </html>
    </xsl:template>

    <xsl:template match="site">
        <h2>
            Site Name: <xsl:value-of select="@name"/>
        </h2>
        <p>
            <table>
                <xsl:apply-templates select="siteforecast"/>
            </table>
        </p>
    </xsl:template>

    <xsl:template match="siteforecast">
        <tr>
            <td>
                <xsl:call-template name="JustTheDate"/>
            </td>

        </tr>

    </xsl:template>


    <xsl:template name="JustTheDate" match="@validdatetime">
        <xsl:value-of select="substring-before(@validdatetime,' ')"/>
    </xsl:template>

    <xsl:template name="JustTheTime" match="@validdatetime">
        <xsl:value-of select="substring-after(@validdatetime,' ')"/>
    </xsl:template>

    <xsl:template name="FormattedResultsValue" match="variable">
        <xsl:choose>
            <xsl:when test="@value=0">
                <div style="color:green">
                    <xsl:value-of select="@value"/>
                </div>
            </xsl:when>
        </xsl:choose>
    </xsl:template>

</xsl:stylesheet>

