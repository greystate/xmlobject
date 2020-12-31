<%
/* -----------------------------------------
	Standard SendMail Function				
											
	Form fields:							
		f = "from"							
		t = "to"							
		s = "subject"						
		b = "body"							
------------------------------------------*/
function SendMail(strTo, strFrom, strSubject, strBody) {
	
	if (Request.ServerVariables("SERVER_NAME") != "aptiva") {
		var objJMail = Server.CreateObject("JMail.SMTPMail");
		
		objJMail.ServerAddress = "mail.greystate.dk"; // This nolonger works, just FYI
		objJMail.Sender = strFrom;
		objJMail.AddRecipient(strTo);
		objJMail.Subject = strSubject;
		objJMail.Body = strBody;
		
		objJMail.Priority = 3; // Normal
		
		try {
			objJMail.Execute();
		} catch (e) {
			Response.Write("Error: " + e.description);
		}
	}
}

%>
