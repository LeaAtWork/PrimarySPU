<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    exclude-result-prefixes="xsl">
    <xsl:output method="xml" omit-xml-declaration="yes" indent="yes"/>
    <xsl:template match="/">
        <div>
           <xsl:apply-templates select="rss/channel"/>
        </div>
    </xsl:template>
    <xsl:template match="rss/channel">
        <xsl:variable name="link" select="link"/>
        <xsl:variable name="description" select="description"/>

        <ul><xsl:apply-templates select="item"/></ul>
    </xsl:template>
    <xsl:template match="item">
        <xsl:variable name="item_link" select="link"/>
        <xsl:variable name="item_title" select="description"/>
        <li>
            <a href="{$item_link}" title="{$item_title}"><xsl:value-of select="title"/></a>
        </li>
    </xsl:template>
</xsl:stylesheet>

