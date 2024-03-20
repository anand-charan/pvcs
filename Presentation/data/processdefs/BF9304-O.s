#<HEADER>
#<COPYRIGHT>
#</COPYRIGHT>
#<HISTORY>
#<RELEASE>
#6.6
#</RELEASE>
# J03978 15JUN2015 JPA - Ajouter l'heure limite de traitement
# J06022 - 26Sep2019 - JFO - List Life Suite Decision historic record (LSSH) - PROJECT MC18
#<NUMBER>
#RC001
#</NUMBER>
#<COMMENT>
#</COMMENT>
#</HISTORY>
#</HEADER>
S-STEP BF9304-O
{
	ATTRIBUTES
	{
		BusinessFunctionType = "List";
		DelEmptyRows;
		FocusField = "MIR-FLDR-ID";
		FocusFrame = "ContentFrame";
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
	INOUT MIR-POL-ID-BASE
	{
		DefaultSession = "MIR-POL-ID-BASE";
		Key;
		Label = "Policy Id";
		Length = "9";
		SType = "Text";
	}
	INOUT MIR-POL-ID-SFX
	{
		DefaultSession = "MIR-POL-ID-SFX";
		Key;
		Label = "Suffix";
		Length = "1";
		SType = "Text";
	}
	INOUT MIR-ACTV-TYP-CD
	{
		CodeSource = "EDIT";
		CodeType = "ACTIVTYP";
		Label = "Activity type code";
		Length = "40";
		Key;
		SType = "Selection";
	}
	INOUT MIR-SERV-CD
	{
		CodeSource = "EDIT";
		CodeType = "SERVCD";
		Label = "Service code";
		Length = "25";
		Key;
		SType = "Selection";
	}

	INOUT MIR-NXT-USER-ID
	{
		CodeSource = "EDIT";
		CodeType = "ANALYSTALL";
		Label = "User ID";
		Length = "8";
		Key;
		SType = "Selection";
	}
	INOUT MIR-NXT-STEP-CD
	{
		CodeSource = "EDIT";
		CodeType = "NXTSTEP";
		Label = "Next step";
		Length = "1";
		Key;
		SType = "Selection";
	}
	INOUT MIR-POL-BUS-CLAS-CD
	{
		CodeSource = "EDIT";
		CodeType = "CLASS";
		Label = "Class of Business";
		Length = "1";
		Key;
		SType = "Selection";
	}
	IN MIR-ACTV-EFF-DT-T[100]
	{
		DisplayOnly;
		FieldGroup = "Table100";
		Index = "1";
		Label = "Activity date";
		Length = "10";
		SType = "Date";
	}
	IN MIR-PROC-LIMIT-DT-T[100]
	{
		DisplayOnly;
		FieldGroup = "Table100";
		Index = "1";
		Label = "Limit process date";
		Length = "10";
		SType = "Date";
	}
	# J03978 Ajouter l'heure limite de traitement.
	IN MIR-PROC-LIMIT-TIME-T[100]
	{
		DisplayOnly;
		FieldGroup = "Table100";
		Index = "1";
		Label = "Limit process time";
		Length = "08";
		SType = "Time";
	}
	# J03978 Ajouter le code VIP du contrat.
	IN MIR-POL-CNTCT-VIP-IND-T[100]
	{
		DisplayOnly;
		FieldGroup = "Table100";
		Index = "1";
		Label = "VIP Indicator";
		Length = "1";
		SType = "Text";
	}
	IN MIR-POL-ID-T[100]
	{
		DisplayOnly;
		FieldGroup = "Table100";
		Index = "1";
		Label = "Policy ID";
		Length = "10";
		SType = "Text";
	}
	IN MIR-ACTV-TYP-CD-T[100]
	{
		CodeSource = "EDIT";
		CodeType = "ACTIVTYP";
		DisplayOnly;
		FieldGroup = "Table100";
		Index = "1";
		Label = "Activity Type";
		Length = "40";
		SType = "Text";
	}
	IN MIR-SECOND-ACTV-TYP-CD-T[100]
	{
		CodeSource = "EDIT";
		CodeType = "ACTIVTYP2";
		DisplayOnly;
		FieldGroup = "Table100";
		Index = "1";
		Label = "Second Activity Type";
		Length = "40";
		SType = "Text";
	}
	IN MIR-SERV-CD-T[100]
	{
		CodeSource = "EDIT";
		CodeType = "SERVCD";
		DisplayOnly;
		FieldGroup = "Table100";
		Index = "1";
		Label = "Service";
		Length = "40";
		SType = "Text";
	}
	IN MIR-COMM-CD-T[100]
	{
		CodeSource = "EDIT";
		CodeType = "COMUNTYP";
		DisplayOnly;
		FieldGroup = "Table100";
		Index = "1";
		Label = "Communication type";
		Length = "40";
		SType = "Text";
	}
	IN MIR-PROC-USER-ID-T[100]
	{
		CodeSource = "EDIT";
		CodeType = "ANALYSTALL";
		DisplayOnly;
		FieldGroup = "Table100";
		Index = "1";
		Label = "Processing user id";
		Length = "40";
		SType = "Text";
	}
	IN MIR-POL-BUS-CLAS-CD-T[100]
	{
		CodeSource = "EDIT";
		CodeType = "CLASS";
		DisplayOnly;
		FieldGroup = "Table100";
		Index = "1";
		Label = "Business class";
		Length = "40";
		SType = "Text";
	}
	IN MIR-NXT-USER-ID-T[100]
	{
		CodeSource = "EDIT";
		CodeType = "ANALYSTALL";
		DisplayOnly;
		FieldGroup = "Table100";
		Index = "1";
		Label = "Next user id";
		Length = "40";
		SType = "Text";
	}
	IN MIR-NXT-STEP-CD-T[100]
	{
		CodeSource = "EDIT";
		CodeType = "NXTSTEP";
		DisplayOnly;
		FieldGroup = "Table100";
		Index = "1";
		Label = "Next step";
		Length = "40";
		SType = "Text";
	}
	IN MIR-CONTEST-IND-T[100]
	{
		CodeSource = "DataModel";
		CodeType = "CONTEST-IND";
		Label = "Contestability indicator";
		DisplayOnly;
		FieldGroup = "Table100";
		Index = "1";
		Length = "40";
		SType = "Text";
	}
#J06022 project MC18
	IN MIR-LSSH-EXIST-IND-T[100]
	{
		Label = "Historic Life Suite Decision indicator";
		DisplayOnly;
		FieldGroup = "Table100";
		Index = "1";
		Length = "1";
		SType = "Text";
	}
#J06022 project MC18
	IN HistLifeSuiteDecision-T[100]
	{
		FieldGroup = "Table090";
		Index = "1";
		DisplayOnly;
		Label = "Historic Life Suite Decision indicator";
		Length = "1";
		SType = "Indicator";
	}
}