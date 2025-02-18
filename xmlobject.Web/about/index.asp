<% @language = "jscript" %>
<%
Response.Codepage = 65001;
Response.Expires = 0;
%>
<!-- #include file="../include/xmlobject.asp" -->
<%
XMLOBJ_ALWAYS_RELOAD_PROCESSORS = true;

var xmlHistory = new XMLObject("../xml/history.xml", "../xml/makehistory.xsl", XMLOBJ_USE_XSLTEMPLATE);
var xmlMenu = new XMLObject("../xml/menus.xml", "../xml/makemenu.xsl", XMLOBJ_NO_TRANSFORM);
var xmlPages = new XMLObject("../xml/pages.xml", "../xml/transform.xsl", XMLOBJ_NO_TRANSFORM);

xmlMenu.AddParameter("pagechosen", "about");
xmlPages.AddParameter("pagechosen", "about");

xmlMenu.transform();
xmlPages.transform();

%><!DOCTYPE html>
<html lang="en">
<head>
	<!-- #include file="../include/head_content.inc" -->
</head>
<body>

<!-- #include file="../include/logo.inc" -->

<%= xmlMenu.output %>
<%= xmlPages.output %>
<%= xmlHistory.output %>

</body>
</html>
