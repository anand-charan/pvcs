#<HEADER>
#<COPYRIGHT>
#© 2019 SSQ Insurance Company Inc.  ALL RIGHTS RESERVED
#</COPYRIGHT>
#<HISTORY>
#<COMMENT>
#Mandat MC18
#J06022 - 12JUL2019 - JFO - Update GDA vs Life SUite UnderWriting Decision - PROJECT MC18
#</COMMENT>
#</HISTORY>
#</HEADER>
PROCESS BFA002Update
{
	Title = STRINGTABLE.IDS_TITLE_BFA002Update;
	TitleBar = "TitleBar";
	TitleBarSize = "70";
	ButtonBar = "ButtonBarOKCancel";
	ButtonBarSize = "40";
	MessageFrame = "MessagesDisp";
	MessageFrameSize = "70";
	# Initialize variable used for message handling in logical locking situations.
	RetrieveMessages = "YES";
	
	# Enter the key(s) for the value that you'd like to create
	STEP Input
	{
		USES S-STEP "BFA000-I";
	}

	IF action == "ACTION_BACK"
	{
		EXIT;

	}
	# Update the record who's data was just entered.
	STEP Update
	{
		USES P-STEP "BFA002-P";
	}

	IF LSIR-RETURN-CD != "00"
	{
		BRANCH Input;
	}

	ButtonBar = "ButtonBarOK";
	# Display the output of the update process
	STEP Output
	{
		USES S-STEP "BFA000-O";
	}

}
