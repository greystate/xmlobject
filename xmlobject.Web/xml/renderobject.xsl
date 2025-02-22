<?xml version="1.0" encoding="iso-8859-1"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="xml" omit-xml-declaration="yes" indent="yes" />

<xsl:param name="hidedescriptions">no</xsl:param>
<xsl:param name="advancedview">yes</xsl:param>
<xsl:param name="highlight">none</xsl:param>

<!-- 
	This XSLT stylesheet ©2001 by Chriztian Steinmeier
	====================[COPYRIGHT]===================
							chriztian@steinmeier.dk
-->

	<xsl:template match="/">
		<html>
			<head>
				<xsl:if test="$advancedview != 'no'">
					<style type="text/css" media="screen">
					<xsl:comment>
						@import "objectstyles.css";
					</xsl:comment>
					</style>
				</xsl:if>
				<meta name="author" content="{//author}"></meta>
				<title>Object Reference</title>
			</head>
			<body>
				<h1>Object Reference Chart</h1>
				[ <xsl:choose>
                    <xsl:when test="$hidedescriptions = 'yes'">
						<a href="?hidedesc=no&amp;adv={$advancedview}">View descriptions</a>
					</xsl:when>
                    <xsl:otherwise>
						<a href="?hidedesc=yes&amp;adv={$advancedview}">Hide descriptions</a>
					</xsl:otherwise>
                </xsl:choose> ][
				<xsl:choose>
                    <xsl:when test="$advancedview = 'no'">
						<a href="?adv=yes&amp;hidedesc={$hidedescriptions}">Advanced output</a>
					</xsl:when>
                    <xsl:otherwise>
						<a href="?adv=no&amp;hidedesc={$hidedescriptions}">Simple output</a>
					</xsl:otherwise>
                </xsl:choose> ]
				<xsl:apply-templates select="object" />
			</body>
		</html>
	</xsl:template>

	<xsl:template match="object">
    	<h2>Object::<xsl:value-of select="name" />()</h2>
		<p class="version">Current version is: <xsl:value-of select="current-version" /></p>
		<xsl:apply-templates select="description" />
		<xsl:apply-templates select="constructors" />
		<xsl:apply-templates select="properties" />
		<xsl:apply-templates select="methods" />
		<xsl:apply-templates select="constants" />
		<xsl:apply-templates select="author" />
    </xsl:template>

	<xsl:template match="author">
		<hr />
		<address>Author: <xsl:value-of select="." /> (<a href="mailto:{@email}"><xsl:value-of select="@email" /></a>)</address>
    </xsl:template>
	
	<xsl:template match="constructors">
    	<div id="divconstructors">
			<h3>Constructor<xsl:if test="count(constructor) &gt; 1">s</xsl:if></h3>
			<dl>
				<xsl:apply-templates select="constructor|function" />
			</dl>
		</div>
    </xsl:template>
	
	<xsl:template match="properties">
    	<div id="divproperties">
			<h3>Properties</h3>
			<dl>
				<xsl:apply-templates select="property">
					<xsl:sort select="name" data-type="text" order="ascending" />
				</xsl:apply-templates>
			</dl>
		</div>
    </xsl:template>
	
	<xsl:template match="methods">
    	<div id="divmethods">
			<h3>Methods</h3>
			<dl>
				<xsl:apply-templates select="method">
					<xsl:sort select="name" data-type="text" order="ascending" />
				</xsl:apply-templates>
			</dl>
		</div>
    </xsl:template>
	
	<xsl:template match="constants">
    	<div id="divconstants">
			<h3>Constants</h3>
			<xsl:apply-templates select="constgroup">
				<xsl:sort select="@caption" data-type="text" />
			</xsl:apply-templates>
		</div>
    </xsl:template>
	
	<xsl:template match="constgroup">
		<dl>    	
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
		<a name="member-{name}"> </a>
		<dt><code><xsl:attribute name="class">property<xsl:if test="name = $highlight"> hilite</xsl:if></xsl:attribute>.<xsl:value-of select="name" /></code></dt>
		<dd><xsl:apply-templates select="description" /></dd>
    </xsl:template>
	
	<xsl:template match="method">
    	<a name="member-{name}"> </a>
		<dt><code><xsl:attribute name="class">method<xsl:if test="name = $highlight"> hilite</xsl:if></xsl:attribute>.<xsl:value-of select="name" />(<xsl:apply-templates select="parameters" />)</code></dt>
		<dd><xsl:apply-templates select="description" /></dd>
    </xsl:template>
	
	<xsl:template match="constant">
		<a name="member-{name}"> </a>
    	<dt><code><xsl:attribute name="class">constant<xsl:if test="name = $highlight"> hilite</xsl:if></xsl:attribute><xsl:value-of select="name" /><xsl:if test="value"><xsl:apply-templates select="value" /></xsl:if></code></dt>
		<dd><xsl:apply-templates select="description" /></dd>
    </xsl:template>
	
	<xsl:template match="constant/value">
    	= <span><xsl:attribute name="class">constvalue<xsl:if test="@type = 'boolean'"> keyword</xsl:if></xsl:attribute><xsl:value-of select="." /></span>
    </xsl:template>
	
	<xsl:template match="constant/value[@type = 'string']">
    	= &quot;<span class="constvalue string"><xsl:value-of select="." /></span>&quot;
    </xsl:template>
	
	<xsl:template match="(property|method)[@not-implemented = 'yes']">
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