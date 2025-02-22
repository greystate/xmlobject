<% @language = "jscript" %>
<%
Response.Codepage = 65001;
Response.Expires = 0;
%>
<!-- #include file="../include/xmlobject.asp" -->
<%
XMLOBJ_ALWAYS_RELOAD_PROCESSORS = true;

var oXML = new XMLObject("../xml/xmlobj_reference.xml", "../xml/renderobject.xsl", "hidedesc->hidedescriptions;adv->advancedview;member->highlight");

%><!DOCTYPE html>

<%= oXML.output %>
