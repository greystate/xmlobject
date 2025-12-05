<?xml version="1.0" encoding="utf-8"?>
<xsl:transform xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<xsl:output method="xml" omit-xml-declaration="yes" indent="yes" />

	<xsl:param name="pagechosen" select="'index'" />

	<xsl:template match="/">
		<nav class="navigation" aria-label="Main">
			<ul>
				<xsl:apply-templates />
			</ul>
		</nav>
	</xsl:template>

	<xsl:template match="menu">
		<li>
			<a href="{url}" class="menu" title="{description}">
				<xsl:if test="contains(url, $pagechosen) or (url = '/' and $pagechosen = 'index')">
					<xsl:attribute name="aria-current">page</xsl:attribute>
				</xsl:if>
				<xsl:value-of select="caption" />
			</a>
		</li>
	</xsl:template>

	<xsl:template match="menu[url/@type = 'javascript']">
		<li>
			<a href="#" class="menu" onclick="{url}; return false;" title="{description}">
				<xsl:value-of select="caption" />
			</a>
		</li>
	</xsl:template>

	<xsl:template match="separator">
		<li><hr class="menuseparator" /></li>
	</xsl:template>

</xsl:transform>
