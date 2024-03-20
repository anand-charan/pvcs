#<HEADER>
#<COPYRIGHT>
#© 2019 SSQ Insurance Company Inc.  ALL RIGHTS RESERVED
#</COPYRIGHT>
#<HISTORY>
#<COMMENT>
#Mandat MC18
#J06022 - 26Sep2019 - JFO - List Life Suite Decision historic record (LSSH) - PROJECT MC18
#</COMMENT>
#</HISTORY>
#</HEADER>
# *****************************************************************************************
# **  MANDAT	DATE      AUTH  	DESCRIPTION                                          **
#******************************************************************************************
PROCESS BFA004List
{
	VARIABLES
	{
#J03978 - Receive polict ID from the caller
		IN MIR-LS-POL-ID;
		IN DisplayInput;
	}
	Title = STRINGTABLE.IDS_TITLE_BFA004List;
	TitleBar = "TitleBar";
	TitleBarSize = "70";
	ButtonBar = "ButtonBarOKCancel";
	ButtonBarSize = "40";
	MessageFrame = "MessagesDisp";
	MessageFrameSize = "70";
	MIR-LIST-MORE-IND = "";

	IF DisplayInput == "FALSE"
	{
		BRANCH TARGET0001;
	}
	# Ask the user where they'd like to start the list
	STEP ListStart
	{
		USES S-STEP "BFA000-I";
	}

	IF action == "ACTION_BACK"
	{
		EXIT;

	}
	TARGET0001:
	STEP RetrieveList
	{
		USES P-STEP "BFA004-P";
	}

	IF LSIR-RETURN-CD != "00"
	{
		BRANCH ListStart;
	}

	ButtonBar = "ButtonBarLists";
	STEP DisplayList
	{
		USES S-STEP "BFA004-O";
	}

	IF action == "ACTION_BACK"
	{
		EXIT;
	}

	# If the user has pressed the more button, go back and reget the list
	IF action == "ACTION_MORE"
	{
		BRANCH RetrieveList;
	}
	# The user has indicated that they want to reverse an entry on the list
	# The user hasn't selected an item to work with.  Go back.
	IF index == "0"
	{
		BRANCH DisplayList;
	}

	# We need save the start key in order to go back at screen list
	ws-pol-id-base = MIR-POL-ID-BASE;
	ws-lssh-eff-dt = MIR-LSSH-EFF-DT;
	ws-lssh-seq-num =  MIR-LSSH-SEQ-NUM;

	# Build the key ID from the row that the user selected
	# You will have to build all of the key variables that will be required
	# by the following steps and pass them to each step. 
	MIR-POL-ID-BASE = MIR-LS-POL-ID-T[index];
	# action will be "SelectItem" if the user clicks on a hyperlink in the
	# row.  It will be ACTION_INQUIRE if they pressed the inquire button.
	IF action == "ACTION_INQUIRE" || action == "SelectItem"
	{
		STEP ACTION_INQUIRE
		{
			USES PROCESS "BFA000Retrieve";
			ATTRIBUTES
			{
				Explicit;
				GetMessages = "No";
			}
			MIR-POL-ID-BASE -> MIR-POL-ID-BASE;
			"FALSE" -> DisplayInput;
		}

		BRANCH RetrieveList;
	}
}
