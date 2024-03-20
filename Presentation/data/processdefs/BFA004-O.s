#<HEADER>
#<COPYRIGHT>
#© 2015 SSQ FINANCIAL GROUP.  ALL RIGHTS RESERVED
#</COPYRIGHT>
#<DESCRIPTION>
#CLIEDIS History List
#</DESCRIPTION>
#<HISTORY>
#<RELEASE>
#6.6
#</RELEASE>
#<NUMBER>
#J03978
#</NUMBER>
#<COMMENT>
#Mandat MC18
#J06022 - 26Sep2019 - JFO - List Life Suite Decision historic record (LSSH) - PROJECT MC18
#</COMMENT>
#</HISTORY>
#</HEADER>
# *****************************************************************************************
# **  MANDAT DATE      AUTH  DESCRIPTION                                                 **
# **  J06022 26Sep2019 JFO   List Life Suite Decision historic record (LSSH) - MC18      ** 
#******************************************************************************************
S-STEP BFA004-O
{
    ATTRIBUTES
    {
		BusinessFunctionType = "List";
		DelEmptyRows;
		FocusField = "MIR-POL-ID-BASE";
#		FocusFrme = "ContentFrame";
		Type = "Output";
    }
    IN Title;
    IN TitleBar;
    IN TitleBarSize;
    IN ButtonBar;
    IN ButtonBarSize;
    IN MessageFrame;
    IN MessageFrameSize;
    OUT action
    {
        SType = "Hidden";
    }
    OUT index
    {
        SType = "Hidden";
    }
	# -------------------------- HEADING POLICY INFORMATIONS ------------------------------ 
	INOUT MIR-LS-POL-ID
	{
		DefaultSession = "MIR-POL-ID-BASE";
		Key;
		Label = "Life Suite Policy Id";
		Length = "20";
		SType = "Text";
	}
	INOUT MIR-LSSH-EFF-DT
	{
		Key;
		Label = "life Suite Historic Effective Date";
		Length = "10";
		SType = "Date";
	}
	INOUT MIR-LSSH-SEQ-NUM
	{
		Key;
		Label = "life Suite Historic Sequence Number";
		Length = "03";
		SType = "Text";
	}	
#----------- List of LSSH table --------------------
	IN MIR-LS-POL-ID-T[50]
	{
		FieldGroup = "Table050";
		Index = "1";
		Label = "Life Suite Policy ID";
		Length = "20";
		SType = "Text";
	}
	IN MIR-LSSH-EFF-DT-T[50]
	{
		FieldGroup = "Table050";
		Index = "1";
		Label = "Effective date";
		Length = "10";
		SType = "Date";
	}	
	IN MIR-PREV-UPDT-TS-TIME-T[50]
	{
		FieldGroup = "Table090";
		Index = "1";
		DisplayOnly;
		Label = "Previous Updated TimeStamp Time";
		Length = "8";
		SType = "Time";
	}
	IN MIR-LSSH-SEQ-NUM-T[50]
	{
		FieldGroup = "Table050";
		Index = "1";
		Label = "Sequence Number";
		Length = "03";
		SType = "Text";
	}
	IN MIR-LSSH-ACTV-TYP-ID-T[50]
	{
		CodeSource = "EDIT";
		CodeType = "LSSHCD";
		FieldGroup = "Table050";
		Index = "1";
		Label = "Life Suite Historic Activity Type ID";
		Length = "03";
		SType = "Text";
	}
	IN MIR-MSG-TXT-T[50]
	{
		FieldGroup = "Table050";
		Index = "1";
		Label = "Life Suite Historic Message Text";
		Length = "120";
		SType = "Text";
	}
}