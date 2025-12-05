<% @language = "jscript" %>
<% Response.Expires = "10" %><!--#include file="include/bendsail.asp"--><% 

var objForm = Request.Form;

var blnSubmitted = (objForm("download") > "")? true : false;

if (blnSubmitted) {
	var strMyMail = "XMLObject() version " + objForm("v") + " downloaded " + Date()
				+ 	"\n\nReceive updates = " + objForm("emailupdates")
				+	"\nEmail: " + objForm("email")
				+	"\n\nUSER_AGENT: " + Request.ServerVariables("HTTP_USER_AGENT")
				+	"\nREMOTE_ADDR: " + Request.ServerVariables("REMOTE_ADDR")
				+	"\nREMOTE_HOST: " + Request.ServerVariables("REMOTE_HOST");

	SendMail("xmlobject@greystate.dk", "xmlobject@greystate.dk", "XMLObject() download", strMyMail);
	
}

var strFile = "downloads/" + objForm("obj") + "_v" + String(objForm("v")).replace(/\./g, "_") + ".zip";

Response.Redirect(strFile);
%>
