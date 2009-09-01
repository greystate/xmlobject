

function CS_status(msg) {
    window.status = (typeof(msg) == "undefined" ? defaultStatus : msg);
}

function findItem(strItem) {
	objrefWin = window.open("object-reference.asp?hi=" + strItem + "#member-" + strItem, null, "scrollbars=1,width=650,height=300,statusbar=1");
	objrefWin.focus();
}

function showItem(strItem) {
    alert("In-the-works!");
}

function toggleHistory() {
	var obj;
	if (document.getElementById)
		obj = document.getElementById("divhistory").style;
    else if (document.all)
		obj = document.all["divhistory"].style;
	
	obj.visibility = (obj.visibility != "hidden" ? "hidden" : "visible" );
}

function validateForm(formpage, objForm) {
    if (objForm["emailupdates"].checked) {
		if (CS_checkEmail(objForm["email"].value))
			return true;
		else {
			alert("If you want to receive e-mail,\nyou have to fill-in your e-mail address.");
			objForm["email"].focus();
			return false;
		}
	} else
		return true;
}

// Check email against Regular Expression
function CS_checkEmail(fieldValue) {
	return (String(fieldValue.match( /^[A-Za-z0-9][-\w\.]*@[-\w]+[-\w\.]*\.\w{2,3}$/ )) != "null");
}