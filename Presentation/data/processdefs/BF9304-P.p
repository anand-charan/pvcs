#<HEADER>
#<COPYRIGHT>
#</COPYRIGHT>
#<HISTORY>
#<RELEASE>
#6.6
#</RELEASE>
#<NUMBER>
#RC001
#</NUMBER>
#<COMMENT>
#DR0062 Corriger la logique du bouton 'Avancer'
# J03978 15JUN2015 JPA - Ajouter l'heure limite de traitement
# J06022 - 26Sep2019 - JFO - List Life Suite Decision historic record (LSSH) - PROJECT MC18
#</COMMENT>
#</HISTORY>
#</HEADER>
P-STEP BF9304-P
{
	ATTRIBUTES
	{
		BusinessFunctionId = "9304";
		BusinessFunctionType = "List";
		MirName = "CCWM9304";
	}
	OUT LSIR-RETURN-CD;
	OUT MIR-RETRN-CD;
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
		Key;
		Label = "User ID";
		Length = "8";
		SType = "Selection";
	}
	INOUT MIR-NXT-STEP-CD
	{
		CodeSource = "EDIT";
		CodeType = "NXTSTEP";
		Key;
		Label = "Next step";
		Length = "1";
		SType = "Text";
	}
	INOUT MIR-POL-BUS-CLAS-CD
	{
		CodeSource = "EDIT";
		CodeType = "CLASS";
		Key;
		Label = "Class of Business";
		Length = "1";
		SType = "Selection";
	}
	OUT MIR-ACTV-EFF-DT-T[100]
	{
		DisplayOnly;
		FieldGroup = "Table100";
		Index = "1";
		Label = "Activity date";
		Length = "10";
		SType = "Date";
	}
	OUT MIR-PROC-LIMIT-DT-T[100]
	{
		DisplayOnly;
		FieldGroup = "Table100";
		Index = "1";
		Label = "Limit process date";
		Length = "10";
		SType = "Date";
	}
	# J03978 Ajouter l'heure limite de traitement.
	OUT MIR-PROC-LIMIT-TIME-T[100]
	{
		DisplayOnly;
		FieldGroup = "Table100";
		Index = "1";
		Label = "Limit process time";
		Length = "08";
		SType = "Time";
	}
	# J03978 Ajouter le code VIP du contrat.
	OUT MIR-POL-CNTCT-VIP-IND-T[100]
	{
		DisplayOnly;
		FieldGroup = "Table100";
		Index = "1";
		Label = "VIP Indicator";
		Length = "1";
		SType = "Text";
	}
	OUT MIR-POL-ID-T[100]
	{
		DisplayOnly;
		FieldGroup = "Table100";
		Index = "1";
		Label = "Policy ID";
		Length = "10";
		SType = "Text";
	}
	OUT MIR-ACTV-TYP-CD-T[100]
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
	OUT MIR-SECOND-ACTV-TYP-CD-T[100]
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
	OUT MIR-SERV-CD-T[100]
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
	OUT MIR-COMM-CD-T[100]
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
	OUT MIR-PROC-USER-ID-T[100]
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
	OUT MIR-POL-BUS-CLAS-CD-T[100]
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
	OUT MIR-NXT-USER-ID-T[100]
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
	OUT MIR-NXT-STEP-CD-T[100]
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
	OUT MIR-CONTEST-IND-T[100]
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
	OUT MIR-LSSH-EXIST-IND-T[100]
	{
		Label = "Historic Life Suite Decision indicator";
		DisplayOnly;
		FieldGroup = "Table100";
		Index = "1";
		Length = "1";
		SType = "Text";
	}
	#DR0062 Start
	INOUT MIR-BROWSE-CTR
	{
		Label = "Browse Counter";
		Length = "4";
		SType = "Number";
	}
	#DR0062 End
}