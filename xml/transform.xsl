<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="xml" omit-xml-declaration="yes" indent="yes" />

<xsl:param name="pagechosen">index</xsl:param>

	<xsl:template match="/">
		<div id="divcontents">
			<xsl:apply-templates select="XMLObjectContent/page[@section = $pagechosen]" />
		</div>
	</xsl:template>
	
	<xsl:template match="page">
		<xsl:apply-templates />
	</xsl:template>
	
	<xsl:template match="header">
		<h2><xsl:value-of select="." /></h2>
	</xsl:template>
	
	<!-- <xsl:template match="emdash"><xsl:text disable-output-escaping="yes"><![CDATA[&mdash;]]></xsl:text></xsl:template> -->
	
	<xsl:template match="para">
		<p>
			<xsl:apply-templates />
		</p>
	</xsl:template>
	
	<xsl:template match="mdash">
		<xsl:text disable-output-escaping="yes"><![CDATA[&mdash;]]></xsl:text>
	</xsl:template>

	
	<xsl:template match="emph">
		<b><xsl:apply-templates /></b>
	</xsl:template>
	
	<xsl:template match="hyperlink">
		<a href="{@url}">
			<xsl:attribute name="target">
				<xsl:choose>
					<xsl:when test="@target"><xsl:value-of select="@target" /></xsl:when>
					<xsl:otherwise>_blank</xsl:otherwise>
				</xsl:choose>
			</xsl:attribute>
			<xsl:apply-templates />
		</a>
	</xsl:template>
	
	<xsl:template match="maillink">
		<a href="mailto:{@addr}" class="maillink"><xsl:apply-templates /></a>
	</xsl:template>
	
	<xsl:template match="filename">
		<code class="filename"><xsl:value-of select="." /></code>
	</xsl:template>
	
	<xsl:template match="faqitem">
		<dl class="faq">
			<dt><xsl:apply-templates select="question" /></dt>
			<dd><xsl:apply-templates select="answer" /></dd>
		</dl>
	</xsl:template>
	
	<xsl:template match="code-ex">
		<div class="codeexample" id="codeex-{@id}">
			<a name="ex{@id}"></a>
			<xsl:apply-templates />
		</div>
<!-- 		<xsl:if test="../@section = 'examples'">
			<xsl:call-template name="createCodeExLinks" />
		</xsl:if> -->
	</xsl:template>
	
	<xsl:template match="code-ex/code">
		<div class="codeblock">
			<xsl:apply-templates />
		</div>
	</xsl:template>
	
	<xsl:template match="code-ex/code">
		<pre><xsl:value-of select="." /></pre>
	</xsl:template>
	
	<xsl:template match="code-ex/caption">
		<h5><xsl:value-of select="." /></h5>
	</xsl:template>
	
	<xsl:template match="code-ex/description">
		<xsl:choose>
			<xsl:when test="para"><xsl:apply-templates /></xsl:when>
			<xsl:otherwise>
				<p><xsl:apply-templates /></p>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	
	<xsl:template match="method | property">
		<xsl:param name="message">View item in reference...</xsl:param>
		<span class="{name()}" onmouseover="CS_status('{$message}');return true;" onmouseout="CS_status();" title="{$message}" onclick="if (typeof(findItem) == 'function') {{ findItem('{.}');return false; }}">.<xsl:value-of select="." /><xsl:if test="name() = 'method'">()</xsl:if></span>
	</xsl:template>

	<!-- This one allows for raw HTML output -->
	<xsl:template match="html_raw">
		<xsl:value-of select="." disable-output-escaping="yes" />
	</xsl:template>
	
	<xsl:template name="createCodeExLinks">
		<div class="linksToExamples">
			<xsl:for-each select="//page[@section = 'examples']/code-ex">
				<xsl:sort select="caption" data-type="text" order="ascending" />
				<a href="#ex{@id}"><xsl:value-of select="caption" /></a>
				<xsl:if test="not(position()=last())"> | </xsl:if>
			</xsl:for-each>
		</div>
	</xsl:template>
	
</xsl:stylesheet>
