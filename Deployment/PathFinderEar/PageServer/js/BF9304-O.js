// Converted from PathFinder 2.2 to 3.0 on Jan 20, 2004 2:42:00 PM EST
//******************************************************************************
//* � 2013 SSQ Financial Group.  ALL RIGHTS RESERVED                           *
//******************************************************************************
//* � 2023 SSQ Financial Group.  ALL RIGHTS RESERVED                           *
//******************************************************************************
//*  Component:   BF9304-O.js
//*  Description:
//*
//******************************************************************************
//*  Chg#    Release  Description
//*
//*  J06022  JFO      New for SSQ - PROJECT MC18   
//******************************************************************************
debugger;
var ColHistDecisionLS  = 14;
//-----------------------------------------------------------------------------
//     Functions for the  BF9304-O.htm pages
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

		disabledHistButton();
}
//-----------------------------------------------------------------------------
//
//	Function:       disabledHistButton()
//
//	Description:    This function will disable button the field MIR-POL-ID-T[n]
//                  is empty
//
//	Arguments:      None
//	
//	Returns:        None
//
//-----------------------------------------------------------------------------

function disabledHistButton()
{
	var NumRows = getFdtListInfoTableSize();
	var Atable   = document.getElementById("FdtListInfoTable");
	var histDecisionFound = -1;

	for (rowIndex = 1; rowIndex <= NumRows; rowIndex++)
    {
		row = Atable.rows[rowIndex];
		cell14 = row.cells[ColHistDecisionLS];
		if (document.getElementById("MIR-LSSH-EXIST-IND-T[" + rowIndex + "]").getAttribute("value") != "Y")
		{
			cell14.style.display = "none";	
		}
		else
		{
			cell14.style.display = "";
			histDecisionFound = 0;
		}
	}
	if (histDecisionFound == -1){
		row = Atable.rows[0];
		cell14 = row.cells[ColHistDecisionLS];
		cell14.style.display = "none";
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
	
//	var policyIdBase = document.getElementsByName("MIR-POL-ID-T[" + ROWSlctOn + "]")[0].innerText.substr(0,9)
	var policyIdBase = document.getElementById("MIR-POL-ID-T[" + ROWSlctOn + "]").innerText.substr(0,9)
	
	if ("F" == document.getElementById("LSIR-USER-LANG-CD").innerText)
	{
		URL = "pageserver?ProcessClassID=" + BPFID + "&amp;PageReturn=Blank&amp;LocaleID=F&amp;DisplayInput=FALSE&amp;";
	}
	else
	{
		URL = "pageserver?ProcessClassID=" + BPFID + "&amp;PageReturn=Blank&amp;LocaleID=E&amp;DisplayInput=FALSE&amp;";
	}
	URL = URL +  "&amp;MIR-LS-POL-ID=" + policyIdBase;
	window.open(URL);
}
//-----------------------------------------------------------------------------
//
//     Function:    getFdtListInfoTableSize()
//
//     Description: Returns the Basic Coverage information table's size.
//
//     Arguments:   None.
//
//     Returns:     The number of rows in the Application list information table.
//
//-----------------------------------------------------------------------------

function getFdtListInfoTableSize()
{
    var FdtListInfoTable = document.getElementById("FdtListInfoTable");

    return FdtListInfoTable.rows.length -1;
}