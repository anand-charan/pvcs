// Converted from PathFinder 2.2 to 3.0 on Jan 20, 2004 2:42:00 PM EST
//******************************************************************************
//* � 2013 SSQ Financial Group.  ALL RIGHTS RESERVED                           *
//******************************************************************************
//* � 2023 SSQ Financial Group.  ALL RIGHTS RESERVED                           *
//******************************************************************************
//*  Component:   BF9354-O.js
//*  Description:
//*
//******************************************************************************
//*  Chg#    Release  Description
//*
//*  SE-301  JFO      New for SSQ   
//*  J03978  JFO      Improvement of Activity Management. 
//*  J05102  GAB      IE11 Natif
//*  J00825  JFO      Ajouter le form type AF16 aux conditions pour l'affichage
//*					  des boutons de lien.
//******************************************************************************
//debugger;
var ColLifeTrad         = 10;
var ColLifeUL			= 11;
var ColSecur		 	= 12;
//-----------------------------------------------------------------------------
//     Functions for the  BF9354-O.htm pages
//-----------------------------------------------------------------------------
//
//     Functions:      onLoadCustom()
//
//     Description:    1.  Initialise screen 
//
//     Arguments:         None
//
//     Returns:         Nothing
//
//-----------------------------------------------------------------------------
function onLoadCustom()
{

		disabledApplButton();
}
//-----------------------------------------------------------------------------
//
//	Function:       disabledApplButton()
//
//	Description:    This function will disable button the field MIR-POL-ID-T[n]
//                  is empty
//
//	Arguments:      None
//	
//	Returns:        None
//
//-----------------------------------------------------------------------------

function disabledApplButton()
{
	var NumRows = getApplListInfoTableSize();
	var Atable   = document.getElementById("ApplListInfoTable");

	for (rowIndex = 1; rowIndex <= NumRows; rowIndex++)
    {
		row = Atable.rows[rowIndex];
		cell10 = row.cells[ColLifeTrad];
		cell11 = row.cells[ColLifeUL];
		cell12 = row.cells[ColSecur];
//J05102 if (document.getElementById("MIR-POL-ID-T[" + rowIndex + "]").innerText != "")
		if (document.getElementsByName("MIR-POL-ID-T[" + rowIndex + "]")[0].innerText != "")
		{
//			document.getElementById("AppMainCdnTrad-T[" + rowIndex + "]").disabled = true;
//			document.getElementById("AppMainCdnUL-T[" + rowIndex + "]").disabled = true;
//			document.getElementById("AppMainCdnSecu-T[" + rowIndex + "]").disabled = true;
			cell10.style.display = "none";	
			cell11.style.display = "none";	
			cell12.style.display = "none";			}
		else
		{
//J05102			if (document.getElementById("MIR-APP-FORM-TYP-CD-T[" + rowIndex + "]").value == "AF03")
//J05102			if (document.getElementById("MIR-APP-FORM-TYP-CD-T[" + rowIndex + "]").innerText == "AF03")		
			if (document.getElementById("MIR-APP-FORM-TYP-CD-T[" + rowIndex + "]").getAttribute("value") == "AF03")				
			{
//J05102		document.getElementById("AppMainCdnTrad-T[" + rowIndex + "]").disabled = true;
//J05102		document.getElementById("AppMainCdnSecu-T[" + rowIndex + "]").disabled = true;	
				
				document.getElementsByName("AppMainCdnTrad-T[" + rowIndex + "]")[0].disabled = true;
				document.getElementsByName("AppMainCdnSecu-T[" + rowIndex + "]")[0].disabled = true;
			}
//J05102			if (document.getElementById("MIR-APP-FORM-TYP-CD-T[" + rowIndex + "]").value == "AF06")
			if (document.getElementById("MIR-APP-FORM-TYP-CD-T[" + rowIndex + "]").getAttribute("value") == "AF06") 				
			{
//J05102		document.getElementById("AppMainCdnUL-T[" + rowIndex + "]").disabled = true;
//J05102		document.getElementById("AppMainCdnSecu-T[" + rowIndex + "]").disabled = true;	
				
				document.getElementsByName("AppMainCdnUL-T[" + rowIndex + "]")[0].disabled = true;
				document.getElementsByName("AppMainCdnSecu-T[" + rowIndex + "]")[0].disabled = true;	
			}			
//J05102			if (document.getElementById("MIR-APP-FORM-TYP-CD-T[" + rowIndex + "]").value == "AF05")
//J05102			if (document.getElementById("MIR-APP-FORM-TYP-CD-T[" + rowIndex + "]").innerText == "AF05")
//J05102			if (document.getElementById("MIR-APP-FORM-TYP-CD-T[" + rowIndex + "]").innerText == "AF05")
			if (document.getElementById("MIR-APP-FORM-TYP-CD-T[" + rowIndex + "]").getAttribute("value") == "AF05" || document.getElementById("MIR-APP-FORM-TYP-CD-T[" + rowIndex + "]").getAttribute("value") == "AF16")			
			{
//J05102		document.getElementById("AppMainCdnTrad-T[" + rowIndex + "]").disabled = true;
//J05102		document.getElementById("AppMainCdnUL-T[" + rowIndex + "]").disabled = true;
				
				document.getElementsByName("AppMainCdnTrad-T[" + rowIndex + "]")[0].disabled = true;
				document.getElementsByName("AppMainCdnUL-T[" + rowIndex + "]")[0].disabled = true;
			}
//J05102			if (document.getElementById("MIR-APP-FORM-TYP-CD-T[" + rowIndex + "]").value == "AF01" || document.getElementById("MIR-APP-FORM-TYP-CD-T[" + rowIndex + "]").value == "AF02")
//J05102			if (document.getElementById("MIR-APP-FORM-TYP-CD-T[" + rowIndex + "]").innerText == "AF01" || document.getElementById("MIR-APP-FORM-TYP-CD-T[" + rowIndex + "]").innerText == "AF02")
			if (document.getElementById("MIR-APP-FORM-TYP-CD-T[" + rowIndex + "]").getAttribute("value") == "AF01" || document.getElementById("MIR-APP-FORM-TYP-CD-T[" + rowIndex + "]").innerText == "AF02")
			{
//J05102		document.getElementById("AppMainCdnSecu-T[" + rowIndex + "]").disabled = true;	
//J05102		document.getElementById("AppMainCdnUL-T[" + rowIndex + "]").disabled = true;
				
				document.getElementsByName("AppMainCdnSecu-T[" + rowIndex + "]")[0].disabled = true;	
				document.getElementsByName("AppMainCdnUL-T[" + rowIndex + "]")[0].disabled = true;
			}	
		}
	}
}
//-----------------------------------------------------------------------------
//
//	Function:       CallApplicationEntry()
//
//	Description:    This function will populate the field MIR-ADDL-INFO-RQST-DT-T
//                  by the process date if one document has been selected
//
//	Arguments:      None
//	
//	Returns:        None
//
//-----------------------------------------------------------------------------
function CallApplicationEntry(selectedRowIndex,BPFID) 
{
	var ROWSlctOn = parseInt(selectedRowIndex);
//J05102 var appFormId = document.getElementById("MIR-APP-FORM-ID-T[" + ROWSlctOn + "]").innerText
//J05102 var gdtObjId = document.getElementById("MIR-GDT-OBJ-ID-T[" + ROWSlctOn + "]").innerText
//J05102 var policyIdBase = document.getElementById("MIR-POL-ID-T[" + ROWSlctOn + "]").innerText.substr(0,9)
//J05102 var policyIdSfx = document.getElementById("MIR-POL-ID-T[" + ROWSlctOn + "]").innerText.substr(9,1)
	
	var appFormId = document.getElementsByName("MIR-APP-FORM-ID-T[" + ROWSlctOn + "]")[0].innerText
	var gdtObjId = document.getElementsByName("MIR-GDT-OBJ-ID-T[" + ROWSlctOn + "]")[0].innerText
	var policyIdBase = document.getElementsByName("MIR-POL-ID-T[" + ROWSlctOn + "]")[0].innerText.substr(0,9)
	var policyIdSfx = document.getElementsByName("MIR-POL-ID-T[" + ROWSlctOn + "]")[0].innerText.substr(9,1)
	
	if ("F" == document.getElementById("LSIR-USER-LANG-CD").innerText)
	{
		URL = "pageserver?ProcessClassID=" + BPFID + "&amp;PageReturn=Blank&amp;LocaleID=F&amp;DisplayInput=FALSE&amp;";
	}
	else
	{
		URL = "pageserver?ProcessClassID=" + BPFID + "&amp;PageReturn=Blank&amp;LocaleID=E&amp;DisplayInput=FALSE&amp;";
	}
	URL = URL + "&amp;MIR-POL-APP-FORM-ID=" + appFormId + "&amp;MIR-GDT-OBJ-ID=" + gdtObjId + "&amp;MIR-POL-ID-BASE=" + policyIdBase + "&amp;MIR-POL-ID-BASE=" + policyIdSfx + "&amp;MIR-DV-CALL-FROM-GAAP-IND=" + "Y";
	window.open(URL);
}
//-----------------------------------------------------------------------------
//
//     Function:    getApplListInfoTableSize()
//
//     Description: Returns the Basic Coverage information table's size.
//
//     Arguments:   None.
//
//     Returns:     The number of rows in the Application list information table.
//
//-----------------------------------------------------------------------------

function getApplListInfoTableSize()
{
    var ApplListInfoTable = document.getElementById("ApplListInfoTable");

    return ApplListInfoTable.rows.length -1;
}