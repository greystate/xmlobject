<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="xml" omit-xml-declaration="yes" indent="yes" />

<xsl:param name="hidedescriptions">no</xsl:param>
<xsl:param name="advancedview">yes</xsl:param>
<xsl:param name="highlight">none</xsl:param>

<!--
	This XSLT stylesheet (c) 2001-2025 by Chriztian Steinmeier, chriztian@steinmeier.dk
-->
	<xsl:template match="/">
		<html lang="en">
			<head>
				<xsl:if test="not($advancedview = 'no')">
					<link rel="stylesheet" href="/assets/objectstyles.css"></link>
				</xsl:if>
				<meta name="author" content="{//author}"></meta>
				<title>Object Reference</title>
			</head>
			<body>
				<h1>Object Reference Chart</h1>
				<xsl:text>[</xsl:text>
				<a href="?hidedesc=yes">
					<xsl:if test="$advancedview = 'no'"><xsl:attribute name="href">?adv=no&amp;hidedesc=yes</xsl:attribute></xsl:if>
					<xsl:if test="$hidedescriptions = 'yes'"><xsl:attribute name="href">/reference/</xsl:attribute></xsl:if>
					<xsl:if test="$hidedescriptions = 'yes' and $advancedview = 'no'"><xsl:attribute name="href">?adv=no</xsl:attribute></xsl:if>
					<xsl:value-of select="substring('Show|Hide', ($hidedescriptions = 'no') * 5 + 1, 4)" />
					<xsl:text> descriptions</xsl:text>
				</a>
				<xsl:text>][</xsl:text>
				<a href="?adv=no">
					<xsl:if test="$hidedescriptions = 'yes'"><xsl:attribute name="href">?adv=no&amp;hidedesc=yes</xsl:attribute></xsl:if>
					<xsl:if test="$advancedview = 'no'"><xsl:attribute name="href">/reference/</xsl:attribute></xsl:if>
					<xsl:if test="$hidedescriptions = 'yes' and $advancedview = 'no'"><xsl:attribute name="href">?hidedesc=yes</xsl:attribute></xsl:if>
					<xsl:value-of select="substring('Advanced|Simple', not($advancedview = 'no') * 9 + 1, 8)" />
					<xsl:text> output</xsl:text>
				</a>
				<xsl:text>]</xsl:text>

				<xsl:apply-templates select="object" />
			</body>
		</html>
	</xsl:template>

	<xsl:template match="object">
		<header>
			<h2>Object::<xsl:value-of select="name" />()</h2>
			<p class="version">Current version is: <xsl:value-of select="current-version" /></p>
			<xsl:apply-templates select="description" />
		</header>

		<main>
			<xsl:apply-templates select="constructors" />
			<xsl:apply-templates select="properties" />
			<xsl:apply-templates select="methods" />
			<xsl:apply-templates select="constants" />
		</main>

		<footer>
			<xsl:apply-templates select="author" />
		</footer>
	</xsl:template>

	<xsl:template match="author">
		<hr />
		<address>Author: <xsl:value-of select="." /> (<a href="mailto:{@email}"><xsl:value-of select="@email" /></a>)</address>
	</xsl:template>

	<xsl:template match="constructors">
		<section class="memberlist">
			<header>
				<h3>Constructor<xsl:if test="count(constructor) &gt; 1">s</xsl:if></h3>
			</header>

			<dl>
				<xsl:apply-templates select="constructor|function" />
			</dl>
		</section>
	</xsl:template>

	<xsl:template match="properties">
		<section class="memberlist">
			<header><h3>Properties</h3></header>

			<dl>
				<xsl:apply-templates select="property">
					<xsl:sort select="name" data-type="text" order="ascending" />
				</xsl:apply-templates>
			</dl>
		</section>
	</xsl:template>

	<xsl:template match="methods">
		<section class="memberlist">
			<header><h3>Methods</h3></header>
			<dl>
				<xsl:apply-templates select="method">
					<xsl:sort select="name" data-type="text" order="ascending" />
				</xsl:apply-templates>
			</dl>
		</section>
	</xsl:template>

	<xsl:template match="constants">
		<section class="memberlist">
			<header><h3>Constants</h3></header>

			<xsl:apply-templates select="constgroup">
				<xsl:sort select="@caption" data-type="text" />
			</xsl:apply-templates>
		</section>
	</xsl:template>

	<xsl:template match="constgroup">
		<dl class="tight">
			<h4><xsl:value-of select="@caption" />:</h4>
			<xsl:apply-templates select="constant" />
		</dl>
	</xsl:template>

	<xsl:template match="function">
		<dt><code><xsl:attribute name="class">method<xsl:if test="@not-implemented = 'yes'"> unfinished</xsl:if></xsl:attribute><xsl:value-of select="name" />(<xsl:apply-templates select="parameters" />)</code></dt>
		<dd><xsl:apply-templates select="description" /></dd>
	</xsl:template>

	<xsl:template match="constructor">
		<dt><code><xsl:attribute name="class">method<xsl:if test="@not-implemented = 'yes'"> unfinished</xsl:if></xsl:attribute><xsl:value-of select="../../name" />(<xsl:apply-templates select="parameters" />)</code></dt>
		<dd><xsl:apply-templates select="description" /></dd>
	</xsl:template>

	<xsl:template match="property">
		<dt id="{name}"><code><xsl:attribute name="class">property<xsl:if test="name = $highlight"> hilite</xsl:if></xsl:attribute>.<xsl:value-of select="name" /></code></dt>
		<dd><xsl:apply-templates select="description" /></dd>
	</xsl:template>

	<xsl:template match="method">
		<dt id="{name}"><code><xsl:attribute name="class">method<xsl:if test="name = $highlight"> hilite</xsl:if></xsl:attribute>.<xsl:value-of select="name" />(<xsl:apply-templates select="parameters" />)</code></dt>
		<dd><xsl:apply-templates select="description" /></dd>
	</xsl:template>

	<xsl:template match="constant">
		<dt id="{name}"><code><xsl:attribute name="class">constant<xsl:if test="name = $highlight"> hilite</xsl:if></xsl:attribute><xsl:value-of select="name" /><xsl:if test="value"><xsl:apply-templates select="value" /></xsl:if></code></dt>
		<dd><xsl:apply-templates select="description" /></dd>
	</xsl:template>

	<xsl:template match="constant/value">
		<xsl:text> = </xsl:text>
		<span><xsl:attribute name="class">constvalue<xsl:if test="@type = 'boolean'"> keyword</xsl:if></xsl:attribute><xsl:value-of select="." /></span>
	</xsl:template>

	<xsl:template match="constant/value[@type = 'string']">
		<xsl:text> = &quot;</xsl:text>
		<span class="constvalue string"><xsl:value-of select="." /></span>
		<xsl:text>&quot;</xsl:text>
	</xsl:template>

	<xsl:template match="*[self::property or self::method][@not-implemented = 'yes']">
		<dt><code class="{name()} unfinished">.<xsl:value-of select="name" /><xsl:if test="name() = 'method'">(<xsl:apply-templates select="parameters" />)</xsl:if></code></dt>
		<dd><xsl:apply-templates select="description" /></dd>
	</xsl:template>

	<xsl:template match="parameters">
		<xsl:for-each select="*"><xsl:apply-templates select="." /><xsl:if test="not(position()=last()) and not(following-sibling::*[1]/parameter)">, </xsl:if></xsl:for-each>
	</xsl:template>

	<xsl:template match="parameter">
		<span class="parameter {@type}"><xsl:apply-templates /></span>
	</xsl:template>

	<xsl:template match="parameter[@type = 'string']">
		<span class="parameter string"><span class="literal">&quot;</span><xsl:apply-templates /><span class="literal">&quot;</span></span>
	</xsl:template>

	<xsl:template match="parameter[@type = 'enumeration']">
		<span class="parameter"><xsl:for-each select="*"><xsl:apply-templates select="." /><xsl:if test="not(position()=last())">|</xsl:if></xsl:for-each></span>
	</xsl:template>

	<xsl:template match="optional">
		[<xsl:if test="../preceding-sibling::*">, </xsl:if><xsl:for-each select="*"><xsl:apply-templates select="." /><xsl:if test="not(position()=last())">, </xsl:if></xsl:for-each>]
	</xsl:template>

	<xsl:template match="description">
		<xsl:if test="not($hidedescriptions='yes')">
			<xsl:choose>
				<xsl:when test="../@not-implemented = 'yes'"><span class="unfinished"><xsl:apply-templates /></span></xsl:when>
				<xsl:otherwise><xsl:apply-templates /></xsl:otherwise>
			</xsl:choose>
		</xsl:if>
	</xsl:template>

	<xsl:template match="description/property">
		<span class="property">.<xsl:value-of select="." /></span>
	</xsl:template>

	<xsl:template match="description/method">
		<span class="method">.<xsl:value-of select="." />()</span>
	</xsl:template>

	<xsl:template match="term">
		<span class="term" title="{@description}"><xsl:value-of select="." /></span>
	</xsl:template>

	<xsl:template match="literal">
		<span class="literal"><xsl:apply-templates /></span>
	</xsl:template>

	<xsl:template match="value">
		<xsl:apply-templates  />
	</xsl:template>

	<xsl:template match="ul|ol|li">
		<xsl:copy><xsl:apply-templates /></xsl:copy>
	</xsl:template>

	<xsl:template match="note">
		<span class="note"><xsl:apply-templates /></span>
	</xsl:template>

</xsl:stylesheet>
