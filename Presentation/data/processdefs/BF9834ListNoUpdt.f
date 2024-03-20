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
#D02235 Corriger le suivi si on change l'info
#J05005 14Sep2016 JFO Ajouter hyperlien sur la colonne MIR-FOLWUP-STAT-CHNG-DT-T[n] pour interrogation
#SADP-5941 19FEV2019 CRICHARD	Nouveau flow pour SAC
#</COMMENT>
#</HISTORY>
#</HEADER>
PROCESS BF9834ListNoUpdt
{

	VARIABLES
    	{
		IN MIR-USER-ID;
	}
	Title = STRINGTABLE.IDS_TITLE_BF9834List;
	TitleBar = "TitleBar";
	TitleBarSize = "70";
	ButtonBar = "ButtonBarOKCancel";
	ButtonBarSize = "50";
	MessageFrame = "MessagesDisp";
	MessageFrameSize = "70";

#DR0062 Start
	WS-BROWSE-CTR = 0;
#DR0062 End


	# Entrer la clef.
	STEP InputKey
	{
		USES S-STEP "BF9834-I";
		UPPER(MIR-USER-ID) -> MIR-FOLWUP-USER-ID;
                "01" -> MIR-FLD-TYP;
	}

#DR0062 Start
	WS-FLDR-ID              = MIR-FLDR-ID;
	WS-FOLWUP-STAT-CHNG-DT  = MIR-FOLWUP-STAT-CHNG-DT;
	WS-FOLWUP-CD            = MIR-FOLWUP-CD;
	WS-FOLWUP-STAT-CD       = MIR-FOLWUP-STAT-CD;
	WS-FOLWUP-USER-ID       = MIR-FOLWUP-USER-ID;
#DR0062 End

	IF action == "ACTION_BACK"
	{
		EXIT;	
	}

	# Récupérer les enregistrements.
	STEP RetrieveRecords
	{
		USES P-STEP "BF9834-P";
#DR0062 Start
		WS-BROWSE-CTR -> MIR-BROWSE-CTR;
		WS-BROWSE-CTR <- MIR-BROWSE-CTR;
#DR0062 End
	}

	IF LSIR-RETURN-CD != "00"
	{
#SADP-5941 début
		ButtonBar = "ButtonBarOKCancel";
#SADP-5941 fin
#DR0062 Start
		WS-BROWSE-CTR = 0;
#DR0062 End
		BRANCH InputKey;
	}
#SADP-5941 début
	ButtonBar = "ButtonBarListsR";
#SADP-5941 fin

	# Afficher les enregistrements.
	STEP DisplayRecords
	{
		USES S-STEP "BF9834-O";
                "01" -> MIR-FLD-TYP;
	}
	
#DR0062 Start
	IF (MIR-FLDR-ID != WS-FLDR-ID) || (MIR-FOLWUP-STAT-CHNG-DT != WS-FOLWUP-STAT-CHNG-DT) || (MIR-FOLWUP-CD != WS-FOLWUP-CD) || (MIR-FOLWUP-STAT-CD != WS-FOLWUP-STAT-CD) || (MIR-FOLWUP-USER-ID != WS-FOLWUP-USER-ID)
	{
		WS-BROWSE-CTR = 0;	
	}
#DR0062 End

	IF action == "ACTION_BACK"
	{
		EXIT;	
	}

	# Récupérer un enregistrement.
	IF action == "ACTION_INQUIRE" || action == "SelectFolwup"

	{
		WS-FLDR-ID              = MIR-FLDR-ID;
		WS-FOLWUP-STAT-CHNG-DT  = MIR-FOLWUP-STAT-CHNG-DT;
		WS-FOLWUP-CD            = MIR-FOLWUP-CD;
		WS-FOLWUP-STAT-CD       = MIR-FOLWUP-STAT-CD;
		WS-FOLWUP-USER-ID       = MIR-FOLWUP-USER-ID;
		WS-FLDR-ID-T            = MIR-FLDR-ID-T[index];
		WS-FOLWUP-DT-T          = MIR-FOLWUP-DT-T[index];
		WS-FOLWUP-SEQ-NUM-T     = MIR-FOLWUP-SEQ-NUM-T[index];
		STEP ActionInquire
		{
			USES PROCESS "BF9830Retrieve";
			ATTRIBUTES
			{
				GetMessages = "NO";
			}
		}
		MIR-FLDR-ID             = WS-FLDR-ID;
		MIR-FOLWUP-STAT-CHNG-DT = WS-FOLWUP-STAT-CHNG-DT;
		MIR-FOLWUP-CD           = WS-FOLWUP-CD;
		MIR-FOLWUP-STAT-CD      = WS-FOLWUP-STAT-CD;
		MIR-FOLWUP-USER-ID      = WS-FOLWUP-USER-ID;
		BRANCH RetrieveRecords;
	}


#D02235 Start
	IF (action == "ACTION_MORE") && (WS-BROWSE-CTR != 0)
#D02235 End
	{
#DR0062 Start
		MIR-FLDR-ID             = WS-FLDR-ID;
		MIR-FOLWUP-STAT-CHNG-DT = WS-FOLWUP-STAT-CHNG-DT;
		MIR-FOLWUP-CD           = WS-FOLWUP-CD;
		MIR-FOLWUP-STAT-CD      = WS-FOLWUP-STAT-CD;
		MIR-FOLWUP-USER-ID      = WS-FOLWUP-USER-ID;
#DR0062 End
		BRANCH RetrieveRecords;	
	}

#D02235 Start
	BRANCH RetrieveRecords;
#D02235 End
}


