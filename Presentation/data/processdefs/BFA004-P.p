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
P-STEP BFA004-P
{
	ATTRIBUTES
	{
		BusinessFunctionId = "A004";
		BusinessFunctionType = "List";
		MirName = "CCWMA002";
	}
	OUT LSIR-RETURN-CD;
	OUT MIR-RETRN-CD;
	# -------------------------- HEADING POLICY INFORMATIONS ------------------------------ 
	INOUT MIR-LS-POL-ID
	{
		DefaultSession = "MIR-POL-ID-BASE";
		Key;
		Label = "Life Suite Policy Id";
		Length = "20";
		Mandatory;
		SType = "Text";
	#	MixedCase;
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
	OUT MIR-MSG-REF-INFO
	{
		Label = "Message reference Number";
		Length = "10";
		SType = "Text";
	}
	OUT MIR-MSG-TXT
	{
		Label = "Current Policy Status";
		Length = "120";
		SType = "Text";
		MixedCase;
	}
#----------- List of LSSH table --------------------
	OUT MIR-LS-POL-ID-T[50]
	{
		FieldGroup = "Table050";
		Index = "1";
		Label = "Life Suite Policy ID";
		Length = "20";
		SType = "Text";
	}
	OUT MIR-LSSH-EFF-DT-T[50]
	{
		FieldGroup = "Table050";
		Index = "1";
		Label = "Effective date";
		Length = "10";
		SType = "Date";
	}	
	OUT MIR-PREV-UPDT-TS-TIME-T[50]
	{
		FieldGroup = "Table090";
		Index = "1";
		DisplayOnly;
		Label = "Previous Updated TimeStamp Time";
		Length = "8";
		SType = "Time";
	}
	OUT MIR-LSSH-SEQ-NUM-T[50]
	{
		FieldGroup = "Table050";
		Index = "1";
		Label = "Sequence Number";
		Length = "03";
		SType = "Text";
	}
	OUT MIR-LSSH-ACTV-TYP-ID-T[50]
	{
		FieldGroup = "Table050";
		Index = "1";
		Label = "Life Suite Historic Activity Type ID";
		Length = "03";
		SType = "Text";
	}
	OUT MIR-MSG-TXT-T[50]
	{
		FieldGroup = "Table050";
		Index = "1";
		Label = "Life Suite Historic Message Text";
		Length = "120";
		SType = "Text";
	}
}
