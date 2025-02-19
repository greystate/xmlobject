<?xml version="1.0" encoding="utf-8"?>
<xsl:transform version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:output method="xml" omit-xml-declaration="yes" indent="yes" />

	<xsl:template match="/">
		<xsl:apply-templates select="history" />
	</xsl:template>

	<xsl:template match="history">
		<section class="history text">
			<h2>History</h2>
			<xsl:apply-templates select="entry">
				<xsl:sort select="@timestamp" data-type="text" order="descending" />
			   	<xsl:sort select="@version" data-type="text" order="descending" />
			</xsl:apply-templates>
		</section>
	</xsl:template>

	<xsl:template match="entry">
		<xsl:variable name="ts" select="@timestamp" />
		<xsl:variable name="formatted" select="concat(substring($ts, 9, 2), '-', substring($ts, 6, 2), '-', substring($ts, 1, 4), ' ', substring(substring-after($ts, 'T'), 1, 5))" />
		<dl class="entry">
			<dt>
				<time datetime="{@timestamp}">@<xsl:value-of select="$formatted" /></time>
				<xsl:text> (</xsl:text>
				<span class="version">v<xsl:value-of select="@version" /></span>
				<xsl:text>)</xsl:text>
			</dt>
			<dd>
				<xsl:apply-templates select="description" />
			</dd>
		</dl>
	</xsl:template>

	<xsl:template match="description">
		<xsl:apply-templates />
	</xsl:template>

	<xsl:template match="method | property">
		<xsl:param name="message">View item in reference...</xsl:param>
		<a class="{name()}" title="{$message}" href="/reference/?member={.}">
			<xsl:value-of select="concat('.', .)" />
			<xsl:if test="name() = 'method'">()</xsl:if>
		</a>
	</xsl:template>

	<xsl:template match="file | constant">
		<span class="{name()}"><xsl:value-of select="." /></span>
	</xsl:template>

</xsl:transform>
