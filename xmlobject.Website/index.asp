<% @language = "jscript" %>
<% Response.Expires = "0" %>
<!--#include file="include/xmlobject.asp"-->
<%

XMLOBJ_ALWAYS_RELOAD_PROCESSORS = true;

var xmlHistory = new XMLObject("xml/history.xml", "xml/makehistory.xsl", XMLOBJ_USE_XSLTEMPLATE);
var xmlMenu = new XMLObject("xml/menus.xml", "xml/makemenu.xsl", XMLOBJ_USE_XSLTEMPLATE);
var xmlPages = new XMLObject("xml/pages.xml", "xml/transform.xsl", "pg->pagechosen");

%><!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<title>XMLObject :: Website</title>
	<meta http-equiv="content-type" content="text/html; charset=iso-8859-1">
	<!--
		Hi there, code peeker!
	
		Please notice the DOCTYPE used in this document.
		It switches on Standards Compliant Mode in Netscape 6
		and Internet Explorer 6, which means that you can use
		Standard HTML4.01 and CSS2 code that validates,
		and expect to see almost identical results in compliant
		browsers.
	-->
	<style type="text/css" media="all">
	<!--
		@import "xmlobject.css";
	-->
	</style>
	<script type="text/javascript" src="funcs.js"></script>
</head>

<body>
<div class="noncompliant">
	If you can read this, it's time you upgrade that browser of yours to one
	that supports the <a href="http://www.webstandards.org/upgrade">Web Standards</a>.<br>
</div>
<div id="divlogo"><img src="images/biglogo.gif" width="600" height="114" border="0" title="The thing is big because it's a big thing!!!" alt="XMLObject() logo"></div>
<%= xmlMenu.output %>
<%= xmlPages.output %>
<%= xmlHistory.output %>
<a style="position:absolute; color:#399; top:0px; right:0px;" target="_blank" href="http://validator.w3.org/check/referer">HTML 4.01</a>&#160;
<a style="position:absolute; color:#399; top:30px; right:0px;" target="_blank" href="http://jigsaw.w3.org/css-validator/check/referer">CSS</a>
</body>
</html>
