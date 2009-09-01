<?xml version="1.0" encoding="iso-8859-1"?>
<xsl:transform version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="xml" omit-xml-declaration="yes" indent="yes" />

	<xsl:template match="/">
		<xsl:apply-templates select="history" />
	</xsl:template>
	
	<xsl:template match="history">
		<div id="divhistory">
			<h4>History</h4>
			<xsl:apply-templates select="entry">
			   	<xsl:sort select="@version" data-type="text" order="descending" />
				<xsl:sort select="position()" data-type="number" order="ascending" />
			</xsl:apply-templates>
		</div>
    </xsl:template>
	
	<xsl:template match="entry">
    	<div>
			<xsl:attribute name="class">
				<xsl:choose>
                    <xsl:when test="position() mod 2 = 0">even</xsl:when>
                    <xsl:otherwise>odd</xsl:otherwise>
                </xsl:choose>
			</xsl:attribute>
			<dl>
				<dt>@<xsl:value-of select="@timestamp" />&#160;(<span class="version">v<xsl:value-of select="@version" /></span>)</dt>
				<dd>
					<xsl:apply-templates select="description" />
				</dd>
			</dl>
		</div>
    </xsl:template>
	
	<xsl:template match="description">
    	<xsl:apply-templates />
    </xsl:template>
	
	<xsl:template match="method | property">
		<xsl:param name="message">View item in reference...</xsl:param>
    	<span class="{name()}" onmouseover="CS_status('{$message}');return true;" onmouseout="CS_status();" title="{$message}" onclick="if (typeof(findItem) == 'function') {{ findItem('{.}');return false; }}">.<xsl:value-of select="." /><xsl:if test="name() = 'method'">()</xsl:if></span>
    </xsl:template>
	
	<xsl:template match="file | constant">
    	<span class="{name()}"><xsl:value-of select="." /></span>
    </xsl:template>
	
</xsl:transform>