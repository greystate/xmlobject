<% @language = "jscript" %>
<% Response.Expires = "0"
%><!--#include file="include/xmlobject.asp"--><%

var oXML = new XMLObject("xml/xmlobj_reference.xml", "xml/renderobject.xsl", "hidedesc->hidedescriptions;adv->advancedview;hi->highlight");

%><!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%= oXML.output %>
