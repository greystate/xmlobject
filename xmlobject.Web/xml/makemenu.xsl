<?xml version="1.0" encoding="iso-8859-1"?>
<xsl:transform xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:output method="xml" omit-xml-declaration="yes" indent="yes" />

	<xsl:template match="/">
		<div id="divmenushadow"></div>
		<div id="divmenu">
			<xsl:apply-templates />
		</div>
	</xsl:template>
	
	<xsl:template match="menu">
    	<a href="{url}" class="menu"
			onmouseover="CS_status('{description}'); return true;"
			onmouseout="CS_status()"
			title="{description}">&#160;<xsl:value-of select="caption" />&#160;</a>
    </xsl:template>
	
	<xsl:template match="menu[url/@type = 'javascript']">
    	<a href="#" class="menu"
			onclick="{url}; return false;"
			onmouseover="CS_status('{description}'); return true;"
			onmouseout="CS_status()"
			title="{description}">&#160;<xsl:value-of select="caption" />&#160;</a>
    </xsl:template>
	
	<xsl:template match="separator">
    	<hr class="menuseparator" />
    </xsl:template>
		
</xsl:transform>