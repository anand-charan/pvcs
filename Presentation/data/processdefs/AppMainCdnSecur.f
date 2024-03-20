#<HEADER>
#<COPYRIGHT>
#� 2001 INSURANCE SOFTWARE SOLUTIONS CORP.  ALL RIGHTS RESERVED
#</COPYRIGHT>
#</HEADER>
# Converted from PathFinder 2.2 to 3.0 on Jan 20, 2004 1:42:08 PM EST
# Converted to Enterprise Designer 1.1 format on Oct 4, 2002 1:51:22 PM EDT
#-----------------------------------------------------------------------------
# Mandat Date      Auth. Description
# D02046 19MAY2011 JFO   Don't need to BF1353-P because the BF1354 has 
#                        called by the option "Automatic Settle" ("S" -> MIR-DV-AUTO-SETL-CD)
# D02070 31May2011 JFO   Do call step "ApplicationCvgCliInfoRetrieve" a second time if
#                        a Owner has change.
# D02599 14mar2012 CRICHARD	Attribution du num�ro de contrat par le syst�me	
# J03226  25Apr2013 JFO   Sur ajout de propri�taire ne pas rendre la date de naissance obligatoire.	
# J03240  30AUG2013 SEBASTIN Executer une fois pour le papier et une fois
#                            pour le PDF.
# J03558  24Oct2013 JFO  Passer le message d'attention au dernier ecran.
#                        Ajouter le bouton ACTION_CANCEL  et ACTION_PREVIOUS sur le dernier ecran. 
# J03245  10Feb2014 JFO  add new field "PrimaryInsrd..." in order to transfert the Primary insured's address
#                        and contact information into AppIndivCreateCdn.f.
# J03693  21Feb2014 JFO  Remettre le champ MIR-CLI-ADDR-TYP-CD � blanc une fois l'adresse de l'assur� principal trouv�e.
# J03395  24Feb2014 JFO   Add Title for Payor search/List/Update/Create by Application screen.
# J03978  27Jul2015 JFO  Ajouter une validation entre la premi�re page de saisie vs la table GAAP (Gestion d'activit� (Proposiiton).
#                        Ajouter le num�ro du ID T�moin � l'�cran de saisie.
#                        Laisser entrer en param�tre la valeur des variables  MIR-GDT-OBJ-ID & MIR-POL-APP-FORM-ID 
#                        lorsque l'appel du processflow est appeler par la page BF9354-O.htm 
#					JFO  bypass the next validation concerning the replacement vs connected policy, cvg,reasn
# J04714 18Mar2016  JFO  Passer en param�tre "SYSTEM" -> MIR-TRNXT-RPT-DSTRB-CD lors de l'appel du P-STEP BF0214-P
#						 pour l'impression du contrat en PDF. Cette mani�re l'impression se fait au 20 minutes.
# J05204  02Feb2017 JFO  Ajouter la recherche pour client signataires autoris�s.
# J05311  06Jun2017 JFO  changement obligatoire et conformit�.
# J00825  05Aou2019 JPA  Initialiser certains champs pour assurer que l'impression s'ex�cute
# modified 2023
#-----------------------------------------------------------------------------
PROCESS AppMainCdnSecur
{
#J03978 Eegin
	VARIABLES
	{
#J03978 - Receive Object Id & Application Form Id from the caller
		IN MIR-GDT-OBJ-ID;
		IN MIR-POL-APP-FORM-ID;
		IN MIR-DV-CALL-FROM-GAAP-IND;
	}
#J03978 Ended
	# 
	Title = "Application Entry";
	TitleBar = "TitleBar";
	TitleBarSize = "70";
	ButtonBar = "AppButtonBar";
	ButtonBarSize = "40";
	MessageFrame = "MessagesDisp";
	MessageFrameSize = "70";
	BannerBar = "AppBannerBar";
	BannerBarSize = "40";
	MIR-POL-CLI-INSRD-CD-T[1] = "SAME";
	# Initialize variable used for message handling in logical locking situations.
	# MD007K Empecher la modification du genre de proposition lorsqu'un proprietaire est ajoute
	AppFormTypeID = "L";
	MIR-CLI-INDV-GR-CD = "AL";
	MIR-CLI-CO-GR-CD = "AL";
	MIR-DV-LANG-GR-DISPLAY-CD-1 = "A";
	MIR-DV-LANG-GR-DISPLAY-CD-2 = "A";
	MIR-DV-LANG-GR-DISPLAY-CD-3 = "A";
	MIR-DV-LANG-GR-DISPLAY-CD-4 = "A";
	MIR-DV-LANG-GR-DISPLAY-CD-5 = "A";
	RetrieveMessages = "YES";
#J03978 begin
	MirUserId = SESSION.MIR-USER-ID;
	SGEDTUpdtIdObjectSw = 0;
#J03978 ended
	# *****************************************************************
	# Collect Client Search information.  A sub-process will be
	# invoked to allow for re-use. Returning from the search will be
	# a client number that can be retained for later use.
	# *****************************************************************
	# send values to the sub-flow for preservation
	# of data should the user cancel from that sub-flow
	# return values from search and assign to insured values
	STEP IndividualSearchPrimaryInsured
	{
		USES PROCESS "AppIndivSearchCdn";
		STRINGTABLE.IDS_TITLE_AppSearchPrimaryInsured -> SearchTitle;
		STRINGTABLE.IDS_TITLE_AppListPrimaryInsured -> ListTitle;
		STRINGTABLE.IDS_TITLE_AppCreatePrimaryInsured -> CreateTitle;
		STRINGTABLE.IDS_TITLE_AppUpdatePrimaryInsured -> UpdateTitle;
		MIR-INSRD-CLI-ID-T[1] -> MIR-CLI-ID;
		MIR-DV-INSRD-CLI-NM -> MIR-DV-CLI-NM;
		MIR-INSRD-CLI-ID-T[1] <- MIR-CLI-ID;
		MIR-DV-INSRD-CLI-NM <- MIR-DV-CLI-NM;
	}
	#J05311 begin
	MIR-DV-PRIMARY-INSRD-CLI-NM = MIR-DV-INSRD-CLI-NM;
	MIR-DV-PRIMARY-INSRD-CLI-ID = MIR-INSRD-CLI-ID-T[1];
	#J05311 ended
#J03245 ---------------------------- Begin change ------------------------------
#J03245 Get the primary insured address and Contact information in order to pass it 
#J03245 into the "AppIndivCreateCdn.f".
	STEP PrimaryInsrdAddrList
	{
		USES P-STEP "BF0494-P";
		ATTRIBUTES
		{
			GetMessages = RetrieveMessages;
		}
		MIR-INSRD-CLI-ID-T[1] -> MIR-CLI-ID;
		"PR" -> MIR-CLI-ADDR-TYP-CD;
		"" -> MIR-CLI-ADDR-EFF-DT;
	}
	IF LSIR-RETURN-CD == "00" && MIR-CLI-ADDR-TYP-CD-T[1] == "PR"
	{
		STEP PrimaryInsrdAddrRetrieve
		{
			USES P-STEP "BF0490-P";
			ATTRIBUTES
			{
				GetMessages = RetrieveMessages;
			}
			MIR-CLI-ADDR-EFF-DT-T[1] -> MIR-CLI-ADDR-EFF-DT;
			"PR" -> MIR-CLI-ADDR-TYP-CD;
			MIR-INSRD-CLI-ID-T[1] -> MIR-CLI-ID;
			PrimaryInsrd-Addr-Ln-1-Txt <- MIR-CLI-ADDR-LN-1-TXT-T[1];
			PrimaryInsrd-Addr-Ln-2-Txt <- MIR-CLI-ADDR-LN-2-TXT-T[1];
			PrimaryInsrd-Addr-Ln-3-Txt <-  MIR-CLI-ADDR-LN-3-TXT-T[1];
			PrimaryInsrd-Addr-Yr-Dur <- MIR-CLI-ADDR-YR-DUR-T[1];
			PrimaryInsrd-City-Nm-Txt <-  MIR-CLI-CITY-NM-TXT-T[1];
			PrimaryInsrd-Crnt-Loc-Cd <-  MIR-CLI-CRNT-LOC-CD-1;
			PrimaryInsrd-Ctry-Cd <- MIR-CLI-CTRY-CD-1;
			PrimaryInsrd-Pstl-Cd <-  MIR-CLI-PSTL-CD-1;
			PrimaryInsrd-Res-Num <- MIR-CLI-RES-NUM-T[1];
			PrimaryInsrd-Res-Typ-Cd <- MIR-CLI-RES-TYP-CD-T[1];
		}	
		STEP PrimaryInsrdCntctRetrieve
		{
			USES P-STEP "BF1074-P";
			ATTRIBUTES
			{
				GetMessages = RetrieveMessages;
			}
			MIR-INSRD-CLI-ID-T[1] -> MIR-CLI-ID;
		}	
		ws-sub = 1;
		WHILE ( ws-sub <= 10 )
		{
			IF MIR-CLI-CNTCT-ID-CD-T[ws-sub] == "HO"
			{
				PrimaryInsrd-Cntct-Id-Cd = MIR-CLI-CNTCT-ID-CD-T[ws-sub];
				PrimaryInsrd-Cntct-Id-Txt = MIR-CLI-CNTCT-ID-TXT-T[ws-sub];
			}
			MIR-CLI-CNTCT-ID-CD-T[ws-sub] = "";
			MIR-CLI-CNTCT-ID-TXT-T[ws-sub] = "";
			ws-sub = ws-sub + 1;
		}
		PrimaryInsrdName = MIR-DV-INSRD-CLI-NM;
		PrimaryInsrdNameInput = MIR-DV-INSRD-CLI-NM;
	}
	MIR-CLI-ADDR-TYP-CD = "";
#J03245 --------------- END OF CHANGE ------------

	# MD007K ANO-212 Keep info in storage
	# MD007K DDC-069 10 couvertures pour la proposition traditionnelle
	ConnPolId1       = "";
	ConnPolId2       = "";
	ConnPolId3       = "";
	ConnPolId4       = "";
	ConnPolId5       = "";
	ConnPolId6       = "";
	ConnPolId7       = "";
	ConnPolId8       = "";
	ConnPolId9       = "";
	ConnPolId10      = "";
	ConnCvgNum1      = "";
	ConnCvgNum2      = "";
	ConnCvgNum3      = "";
	ConnCvgNum4      = "";
	ConnCvgNum5      = "";
	ConnCvgNum6      = "";
	ConnCvgNum7      = "";
	ConnCvgNum8      = "";
	ConnCvgNum9      = "";
	ConnCvgNum10     = "";
	CvgConnReasnCd1  = "";
	CvgConnReasnCd2  = "";
	CvgConnReasnCd3  = "";
	CvgConnReasnCd4  = "";
	CvgConnReasnCd5  = "";
	CvgConnReasnCd6  = "";
	CvgConnReasnCd7  = "";
	CvgConnReasnCd8  = "";
	CvgConnReasnCd9  = "";
	CvgConnReasnCd10 = "";
	tempCashAmount = "";
	temp-prem-on-repl-pct-1 = "";
	temp-prem-on-repl-pct-2 = "";
	temp-prem-on-repl-pct-3 = "";


	# if the user had cancelled the search process because they inadvertently
	# initiated the flow, exit the flow entirely.  But if the user has
	# re-executed the search sub-process to correct errors,
	# but then cancelled out of that process, return to the point where
	# they asked for the correction in the first place.
	IF ReturnToList == "FALSE" || DataCorrection == "FALSE"
	{
		BRANCH ApplicationDataInput;
	}

	IF LastAction == "ACTION_CANCEL"
	{
		EXIT;

	}
	# 
	BannerPrimaryInsured = MIR-DV-INSRD-CLI-NM;
	# add initial defaults for product filter and owner table information
	# these values are used to provide the basis for the user to start
	# the entry process.  they are only ever set once and not executed again.
	index = "0";
	MIR-POL-ISS-LOC-CD = MIR-CLI-CRNT-LOC-CD-1;
	MIR-POL-CTRY-CD = MIR-CLI-CTRY-CD-1;
	# if the owner and primary insured are the same person
	# then default the primary insured to the owner.  This is
	# ok for the first time thru the process.
	# If on a return trip thru the process however, and the user
	# has indicated that the owner is not the same as the insured
	# then do not redefault the owner from the insured and leave
	# intact any relationship the user may have created.
	IF MIR-POL-CLI-INSRD-CD-T[1] == "SAME"
	{
		# 
		MIR-DV-OWN-CLI-NM-T[1] = MIR-DV-INSRD-CLI-NM;
		MIR-CLI-TAX-ID-T[1] = MIR-CLI-TAX-ID;
		MIR-CLI-ID-T[1] = MIR-INSRD-CLI-ID-T[1];
	}



	# to produce the entry page, retrieve the mailing address in the
	# format it would be used for mailing purposes.
	STEP MailingAddressRetrieve
	{
		USES PROCESS "AppAddressMailRetrieve";
		ATTRIBUTES
		{
			GetMessages = "NO";
		}
		MailName <- MIR-DV-OWN-CLI-NM-T[1];
	}

	# preserve the name and address for the primary insured, just in case
	# the user changes owner to other, and then back again.  Page script
	# will perform the moving of these variables to and from their
	# originating names, based on the user selecting the "SAME" or other
	# value from the selection box for this field.
	IF MIR-POL-CLI-INSRD-CD-T[1] == "SAME"
	{
		# 
		PrimaryInsuredMailAddressLine-T[1] = MailAddressLine-T[1];
		PrimaryInsuredMailAddressLine-T[2] = MailAddressLine-T[2];
		PrimaryInsuredMailAddressLine-T[3] = MailAddressLine-T[3];
		PrimaryInsuredMailAddressLine-T[4] = MailAddressLine-T[4];
		PrimaryInsuredMailAddressLine-T[5] = MailAddressLine-T[5];
		PrimaryInsuredMailAddressLine-T[6] = MailAddressLine-T[6];
		PrimaryInsuredTAX-ID-T[1] = MIR-CLI-TAX-ID-T[1];
		PrimaryInsuredName = MIR-DV-OWN-CLI-NM-T[1];
		PrimaryInsuredMailName = MailName;
		PrimaryInsuredADDR-TYP-CD-T[1] = MIR-CLI-ADDR-TYP-CD-T[1];
		PrimaryInsuredOwnerClientID = MIR-CLI-ID-T[1];
	}



	# *****************************************************************
	# RM202A S�CURIGROUPE : Ajouter l'�cran pour visualiser couvertures existantes
	# *****************************************************************

	MIR-CLI-ID = PrimaryInsuredOwnerClientID;

	IF AdditionalOwnerClientID-T[1] != ""
	{
		MIR-CLI-ID = AdditionalOwnerClientID-T[1];
	}
	temp-CLI-ID-1 = MIR-CLI-ID-T[1];
	temp-CLI-ID-2 = MIR-CLI-ID-T[2];
	temp-CLI-ID-3 = MIR-CLI-ID-T[3];
	temp-CLI-ID-4 = MIR-CLI-ID-T[4];
	temp-CLI-ID-5 = MIR-CLI-ID-T[5];

#D02070 START
	IF MIR-POL-CLI-INSRD-CD-T[1] != "SAME"
	{
		BRANCH ApplicationDataInput;
	}
#D02070 END

	MIR-CLI-ID = PrimaryInsuredOwnerClientID;

	STEP ApplicationCvgCliInfoRetrieve
	{
		USES P-STEP "BF1002-P";
		PrimaryInsuredOwnerClientID -> MIR-CLI-ID;
       	}

	MIR-CLI-ID-T[1] = temp-CLI-ID-1;
	MIR-CLI-ID-T[2] = temp-CLI-ID-2;
	MIR-CLI-ID-T[3] = temp-CLI-ID-3;
	MIR-CLI-ID-T[4] = temp-CLI-ID-4;
	MIR-CLI-ID-T[5] = temp-CLI-ID-5;

	IF LSIR-RETURN-CD == "01" || LSIR-RETURN-CD == "02" || LSIR-RETURN-CD == "05"
	{
		# 
		MIR-CLI-ID = "";
		BRANCH IndividualSearchPrimaryInsured;
	}

	IF MIR-POL-ID-BASE-T[1] != ""
	{
		STEP ApplicationCvgCliInfoDisplay
		{
			USES S-STEP "BF1002-O";
			STRINGTABLE.IDS_TITLE_BF1002Insdtl -> Title;
			"ButtonBarPrevNextMore" -> ButtonBar;
		}	


		# 
		BannerClientID = MIR-CLI-ID-BASE;
	
		IF action == "ACTION_PREVIOUS"
		{
			BRANCH IndividualSearchPrimaryInsured;
		}


		# If the user has pressed the more button, go back and reget the list
		IF action == "ACTION_MORE" 
		{
			MIR-DV-PRCES-STATE-CD = "2";
			BRANCH ApplicationCvgCliInfoRetrieve;
		}
	}
	MIR-AGT-ID-T[1] = "";
	MIR-AGT-ID-T[2] = "";
	MIR-AGT-ID-T[3] = "";


	# *****************************************************************
	# Collect Application data.  This includes information to filter
	# a product selection box, owner information, and policy
	# replacement information.
	# *****************************************************************
	# MD007K mettre Life par defaut lors de la premiere proposition
	# MD007K Empecher la modification du genre de proposition lorsqu'un proprietaire est ajoute
	# AppFormTypeID = "S"

	AppFormTypeID = "S";
	MIR-CLI-ID-T[1] = PrimaryInsuredOwnerClientID;


	STEP ApplicationDataInput
	{
		USES S-STEP "AppApplicationDataCdnSecur";
		"AppButtonBar" -> ButtonBar;
		STRINGTABLE.IDS_TITLE_AppApplicationData -> Title;
		AppFormTypeID -> MIR-APP-FORM-TYP-ID;
		AdditionalOwnerClientID-T[1] -> MIR-CLI-ID-T[2];
		AdditionalOwnerClientNM-T[1] -> MIR-DV-OWN-CLI-NM-T[2];
		AdditionalOwnerClientID-T[2] -> MIR-CLI-ID-T[3];
		AdditionalOwnerClientNM-T[2] -> MIR-DV-OWN-CLI-NM-T[3];
		AdditionalOwnerClientID-T[3] -> MIR-CLI-ID-T[4];
		AdditionalOwnerClientNM-T[3] -> MIR-DV-OWN-CLI-NM-T[4];
		AdditionalOwnerClientID-T[4] -> MIR-CLI-ID-T[5];
		AdditionalOwnerClientNM-T[4] -> MIR-DV-OWN-CLI-NM-T[5];
		AppFormTypeID <- MIR-APP-FORM-TYP-ID;
#D02599 d�but
		SESSION.LSIR-SECUR-CLAS-ID -> WS-USER-SECUR-CLAS-ID;
#D02599 fin
	}

	# if user presses PREVIOUS, send them back to where they
	# came from.  Preserving LastActions in the search sub-flows
	# allows us to evaluate these values here and send the user
	# back to either the Search List page, or the Details page.
	# The presumption here is that if the user came from the List
	# page and had attached the wrong client as the primary
	# insured, a return to the list page is the quickest way for the
	# user to select a different primary insured.
	# If the user had either created a new client or updated an
	# existing one, and received messages they wanted to act upon,
	# then a previous action will send them back to the Details
	# page where they can make corrections.
	
	# *****************************************************************************************
	# RM202A S�CURIGROUPE : Pour S�curigroupe, on retourne � l'�cran des couvertures du client.
	# *****************************************************************************************
	IF action == "ACTION_PREVIOUS"
	{
		MIR-GDT-OBJ-ID = ws-save-gdt-obj-id;
		MIR-DV-CLUB-CLI-ID = ws-save-dv-club-id;
		MIR-POL-APP-FORM-ID = ws-pol-app-form-id;
		IF LastAction == "ACTION_ATTACH"
		{
			# 
			ReturnToList = "TRUE";
			IF MIR-POL-ID-BASE-T[1] != ""
			{
				BRANCH ApplicationCvgCliInfoRetrieve;
			}
			ELSE
			{
				BRANCH IndividualSearchPrimaryInsured;
			}
		}

		# 
		DataCorrection = "TRUE";
		MIR-CLI-ID = MIR-INSRD-CLI-ID-T[1];
		
		#	
		IF MIR-POL-ID-BASE-T[1] != ""
		{
			BRANCH ApplicationCvgCliInfoRetrieve;
		}
		ELSE
		{
			BRANCH IndividualSearchPrimaryInsured;
		}
	}

	# the user has indicated that a different owner is required
	# re-do an individual client search to return owner data
	IF action == "GoToIndividualSearch"
	{
		# send values to the sub-flow for preservation
		# of data should the user cancel from that sub-flow
		# return values from the search sub-flow
		STEP IndividualSearchOwner
		{
			USES PROCESS "AppIndivSearchCdn";
			STRINGTABLE.IDS_TITLE_AppSearchIndivOwner -> SearchTitle;
			STRINGTABLE.IDS_TITLE_AppListIndivOwner -> ListTitle;
			STRINGTABLE.IDS_TITLE_AppCreateIndivOwner -> CreateTitle;
			STRINGTABLE.IDS_TITLE_AppUpdateIndivOwner -> UpdateTitle;
#J03395 Mettre en commentaire le passage de param�tre suivant. Pas n�cessaire
#			MIR-CLI-ID-T[1] -> MIR-CLI-ID;
#			MIR-CLI-TAX-ID-T[1] -> MIR-CLI-TAX-ID;
#			MIR-DV-OWN-CLI-NM-T[1] -> MIR-DV-CLI-NM;
#J03395 Ended
			MIR-CLI-ID-T[1] <- MIR-CLI-ID;
			MIR-CLI-TAX-ID-T[1] <- MIR-CLI-TAX-ID;
			MIR-DV-OWN-CLI-NM-T[1] <- MIR-DV-CLI-NM;
		}

		# 
		MIR-CLI-ADDR-TYP-CD-T[1] = "";
		BRANCH MailingAddressRetrieve;
	}
	IF action == "GoToOwnerSearch"
	{
		# send values to the sub-flow for preservation
		# J03226 begin - Send Yes in the field "Search-Owner-SW" to the sub-flow to indicate that we looking for an owner.
		
		IF AdditionalOwnerClientID-T[1] == ""
		{
			STEP AddIndividualOwner2
			{
				USES PROCESS "AppIndivSearchCdn";
				STRINGTABLE.IDS_TITLE_AppSearchIndivOwner -> SearchTitle;
				STRINGTABLE.IDS_TITLE_AppListIndivOwner -> ListTitle;
				STRINGTABLE.IDS_TITLE_AppCreateIndivOwner -> CreateTitle;
				STRINGTABLE.IDS_TITLE_AppUpdateIndivOwner -> UpdateTitle;
				"Y" -> Search-Owner-SW;
				MIR-CLI-ID-T[2] -> MIR-CLI-ID;
				MIR-DV-OWN-CLI-NM-T[2] -> MIR-DV-CLI-NM;
				MIR-CLI-ID-T[2] <- MIR-CLI-ID;
				MIR-DV-OWN-CLI-NM-T[2] <- MIR-DV-CLI-NM;
			}

			AdditionalOwnerClientID-T[1] = MIR-CLI-ID-T[2];
			AdditionalOwnerClientNM-T[1] = MIR-DV-OWN-CLI-NM-T[2];
			BRANCH MailingAddressRetrieve;
		}

		IF AdditionalOwnerClientID-T[2] == ""
		{
			STEP AddIndividualOwner3
			{
				USES PROCESS "AppIndivSearchCdn";
				STRINGTABLE.IDS_TITLE_AppSearchIndivOwner -> SearchTitle;
				STRINGTABLE.IDS_TITLE_AppListIndivOwner -> ListTitle;
				STRINGTABLE.IDS_TITLE_AppCreateIndivOwner -> CreateTitle;
				STRINGTABLE.IDS_TITLE_AppUpdateIndivOwner -> UpdateTitle;
				"Y" -> Search-Owner-SW;
				MIR-CLI-ID-T[3] -> MIR-CLI-ID;
				MIR-DV-OWN-CLI-NM-T[3] -> MIR-DV-CLI-NM;
				MIR-CLI-ID-T[3] <- MIR-CLI-ID;
				MIR-DV-OWN-CLI-NM-T[3] <- MIR-DV-CLI-NM;
			}

			AdditionalOwnerClientID-T[2] = MIR-CLI-ID-T[3];
			AdditionalOwnerClientNM-T[2] = MIR-DV-OWN-CLI-NM-T[3];
			BRANCH MailingAddressRetrieve;
		}

		IF MIR-CLI-ID-T[4] == ""
		{
			STEP AddIndividualOwner4
			{
				USES PROCESS "AppIndivSearchCdn";
				STRINGTABLE.IDS_TITLE_AppSearchIndivOwner -> SearchTitle;
				STRINGTABLE.IDS_TITLE_AppListIndivOwner -> ListTitle;
				STRINGTABLE.IDS_TITLE_AppCreateIndivOwner -> CreateTitle;
				STRINGTABLE.IDS_TITLE_AppUpdateIndivOwner -> UpdateTitle;
				"Y" -> Search-Owner-SW;
				MIR-CLI-ID-T[4] -> MIR-CLI-ID;
				MIR-DV-OWN-CLI-NM-T[4] -> MIR-DV-CLI-NM;
				MIR-CLI-ID-T[4] <- MIR-CLI-ID;
				MIR-DV-OWN-CLI-NM-T[4] <- MIR-DV-CLI-NM;
			}

			AdditionalOwnerClientID-T[3] = MIR-CLI-ID-T[4];
			AdditionalOwnerClientNM-T[3] = MIR-DV-OWN-CLI-NM-T[4];
			BRANCH MailingAddressRetrieve;
		}

		IF MIR-CLI-ID-T[5] == ""
		{
			STEP AddIndividualOwner5
			{
				USES PROCESS "AppIndivSearchCdn";
				STRINGTABLE.IDS_TITLE_AppSearchIndivOwner -> SearchTitle;
				STRINGTABLE.IDS_TITLE_AppListIndivOwner -> ListTitle;
				STRINGTABLE.IDS_TITLE_AppCreateIndivOwner -> CreateTitle;
				STRINGTABLE.IDS_TITLE_AppUpdateIndivOwner -> UpdateTitle;
				"Y" -> Search-Owner-SW;
				MIR-CLI-ID-T[5] -> MIR-CLI-ID;
				MIR-DV-OWN-CLI-NM-T[5] -> MIR-DV-CLI-NM;
				MIR-CLI-ID-T[5] <- MIR-CLI-ID;
				MIR-DV-OWN-CLI-NM-T[5] <- MIR-DV-CLI-NM;
			}

			AdditionalOwnerClientID-T[4] = MIR-CLI-ID-T[5];
			AdditionalOwnerClientNM-T[4] = MIR-DV-OWN-CLI-NM-T[5];
			BRANCH MailingAddressRetrieve;
		}

		BRANCH MailingAddressRetrieve;
	}
	IF action == "RemoveOwner"
	{
		IF MIR-CLI-ID-T[5] != "" && MIR-CLI-ID-T[5] != "*"
		{
			MIR-CLI-ID-T[5] = "";
			MIR-DV-OWN-CLI-NM-T[5] = "";
			MIR-DV-OWN-SUB-CD-T[5] = "";
			AdditionalOwnerClientID-T[4] = "*";
			AdditionalOwnerClientNM-T[4] = "";
			BRANCH MailingAddressRetrieve;
		}

		IF MIR-CLI-ID-T[4] != "" && MIR-CLI-ID-T[4] != "*"
		{
			MIR-CLI-ID-T[4] = "";
			MIR-DV-OWN-CLI-NM-T[4] = "";
			MIR-DV-OWN-SUB-CD-T[4] = "";
			AdditionalOwnerClientID-T[3] = "*";
			AdditionalOwnerClientNM-T[3] = "";
			BRANCH MailingAddressRetrieve;
		}

		IF MIR-CLI-ID-T[3] != "" && MIR-CLI-ID-T[3] != "*"
		{
			MIR-CLI-ID-T[3] = "";
			MIR-DV-OWN-CLI-NM-T[3] = "";
			MIR-DV-OWN-SUB-CD-T[3] = "";
			AdditionalOwnerClientID-T[2] = "*";
			AdditionalOwnerClientNM-T[2] = "";
			BRANCH MailingAddressRetrieve;
		}

		IF MIR-CLI-ID-T[2] != "" && MIR-CLI-ID-T[2] != "*"
		{
			MIR-CLI-ID-T[2] = "";
			MIR-DV-OWN-CLI-NM-T[2] = "";
			MIR-DV-OWN-SUB-CD-T[2] = "";
			AdditionalOwnerClientID-T[1] = "*";
			AdditionalOwnerClientNM-T[1] = "";
			BRANCH MailingAddressRetrieve;
		}
		BRANCH MailingAddressRetrieve;
	}

	IF action == "GoToCompanySearch"
	{
		# send values to the sub-flow for preservation
		# of data should the user cancel from that sub-flow
		# return values from the search sub-flow
		STEP CompanySearchOwner
		{
			USES PROCESS "AppCompSearchCdn";
			STRINGTABLE.IDS_TITLE_AppSearchCompanyOwner -> SearchTitle;
			STRINGTABLE.IDS_TITLE_AppListCompanyOwner -> ListTitle;
			STRINGTABLE.IDS_TITLE_AppCreateCompanyOwner -> CreateTitle;
			STRINGTABLE.IDS_TITLE_AppUpdateCompanyOwner -> UpdateTitle;
			"" -> MIR-CLI-ID;
		}

		IF MIR-CLI-ID != ""
		{
			MIR-CLI-ID-T[1] = MIR-CLI-ID;
			MIR-CLI-TAX-ID-T[1] = MIR-CLI-TAX-ID;
#D02070			MIR-DV-OWN-CLI-NM-T[1] = MIR-DV-OWN-CLI-NM;
#D02070 START
			MIR-DV-OWN-CLI-NM-T[1] = MIR-DV-CLI-NM;
#D02070 END
		}

		# 
		MIR-CLI-ADDR-TYP-CD-T[1] = "";
		BRANCH MailingAddressRetrieve;
	}

	# the user has indicated they need to refresh the product
	# selection box, or has changed their country value.
	# Pageserver will re-build the page, using the filtered
	# selection box set up for this field.
	IF action == "ACTION_REFRESH"
	{
		BRANCH ApplicationDataInput;
	}

	IF action == "ACTION_SEARCH"
	{
		STEP CompanySearchReplacement
		{
			USES PROCESS "AppCompSearchCdn";
			STRINGTABLE.IDS_TITLE_AppSearchReplacementCompany -> SearchTitle;
			STRINGTABLE.IDS_TITLE_AppListReplacementCompany -> ListTitle;
			STRINGTABLE.IDS_TITLE_AppCreateReplacementCompany -> CreateTitle;
			STRINGTABLE.IDS_TITLE_AppUpdateReplacementCompany -> UpdateTitle;
			"" -> MIR-CLI-ID;
			MIR-REPL-CO-CLI-ID <- MIR-CLI-ID;
			MIR-DV-REPL-CO-CLI-NM <- MIR-DV-CLI-NM;
		}

		BRANCH ApplicationDataInput;
	}

	IF action == "ChangeMailingAddress"
	{
		STEP ChangeMailingAddress
		{
			USES PROCESS "AppAddressUpdateCdn";
			ATTRIBUTES
			{
				GetMessages = "NO";
			}
		}

		BRANCH MailingAddressRetrieve;
	}
#---- J05204 FAIRE UNE RECHERCHE POUR LE NOM DU SIGNATAIRE AUTORIS� PERSON CIE
	#J05311 BEGIN. SI L'OPTION CHOISI � L'�CRAN EST "m�me que l'assur� 1" on doit forcer la valeur du premier assur� aux 
	# 		variables MIR-DV-APC-CLI-ID-T[1] ET MIR-DV-APC-CLI-NM-T[1] AFIN QU'ILS SOIENT RETENUES EN M�MOIRE
	IF MIR-APP-APC-NM-RECV-IND == "S"
	{
		MIR-DV-APC-CLI-ID-T[1] = MIR-DV-PRIMARY-INSRD-CLI-ID;
		MIR-DV-APC-CLI-NM-T[1] = MIR-DV-PRIMARY-INSRD-CLI-NM;
		AdditionalAPCClientID-T[1]= MIR-DV-PRIMARY-INSRD-CLI-ID;
	}
	#J05311
	IF action == "GoToSAPCSearch"
	{
		# send values to the sub-flow for preservation
		IF AdditionalAPCClientID-T[1] == "" || AdditionalAPCClientID-T[1] == "*"
		{
			STEP AddIndividualSAPC1
			{
				USES PROCESS "AppIndivSearchCdn";
				STRINGTABLE.IDS_TITLE_AppSearchIndivSAPC -> SearchTitle;
				STRINGTABLE.IDS_TITLE_AppListIndivSAPC -> ListTitle;
				STRINGTABLE.IDS_TITLE_AppCreateIndivSAPC -> CreateTitle;
				STRINGTABLE.IDS_TITLE_AppUpdateIndivSPAC -> UpdateTitle;
				"Y" -> Search-SAPC-SW;
				MIR-DV-APC-CLI-ID-T[1] -> MIR-CLI-ID;
				MIR-DV-APC-CLI-NM-T[1] -> MIR-DV-CLI-NM;
				MIR-DV-APC-CLI-ID-T[1] <- MIR-CLI-ID;
				MIR-DV-APC-CLI-NM-T[1] <- MIR-DV-CLI-NM;
			}
			AdditionalAPCClientID-T[1] = MIR-DV-APC-CLI-ID-T[1];
			AdditionalAPCClientNM-T[1] = MIR-DV-APC-CLI-NM-T[1];
			BRANCH MailingAddressRetrieve;
		}

		IF AdditionalAPCClientID-T[2] == "" || AdditionalAPCClientID-T[2] == "*"
		{
			STEP AddIndividualSAPC2
			{
				USES PROCESS "AppIndivSearchCdn";
				STRINGTABLE.IDS_TITLE_AppSearchIndivSPAC -> SearchTitle;
				STRINGTABLE.IDS_TITLE_AppListIndivSAPC -> ListTitle;
				STRINGTABLE.IDS_TITLE_AppCreateIndivSAPC -> CreateTitle;
				STRINGTABLE.IDS_TITLE_AppUpdateIndivSAPC -> UpdateTitle;
				"Y" -> Search-SAPC-SW;
				MIR-DV-APC-CLI-ID-T[2] -> MIR-CLI-ID;
				MIR-DV-APC-CLI-NM-T[2] -> MIR-DV-CLI-NM;
				MIR-DV-APC-CLI-ID-T[2] <- MIR-CLI-ID;
				MIR-DV-APC-CLI-NM-T[2] <- MIR-DV-CLI-NM;
			}

			AdditionalAPCClientID-T[2] = MIR-DV-APC-CLI-ID-T[2];
			AdditionalAPCClientNM-T[2] = MIR-DV-APC-CLI-NM-T[2];
			BRANCH MailingAddressRetrieve;
		}
	}
	IF action == "RemoveSAPC"
	{
		IF MIR-DV-APC-CLI-ID-T[2] != "" && MIR-DV-APC-CLI-ID-T[2] != "*"
		{
			MIR-DV-APC-CLI-ID-T[2] = "*";
			MIR-DV-APC-CLI-NM-T[2] = "";
			AdditionalAPCClientID-T[2] = "*";
			AdditionalAPCClientNM-T[2] = "";
			BRANCH MailingAddressRetrieve;
		}

		IF MIR-DV-APC-CLI-ID-T[1] != "" && MIR-DV-APC-CLI-ID-T[1] != "*"
		{
			MIR-DV-APC-CLI-ID-T[1] = "*";
			MIR-DV-APC-CLI-NM-T[1] = "";
			AdditionalAPCClientID-T[1] = "*";
			AdditionalAPCClientNM-T[1] = "";
			BRANCH MailingAddressRetrieve;
		}
	}
# --- J05204 ENDED

	IF action == "ACTION_NEXT"
	{
		# Determine if the policy id has been valued.
		# For the first time thru this step, this value will
		# be blank, and a create may occur.
		# For any other trip thru this step, this value may be
		# non-blank.  This means that a policy was created, but it
		# may have failed on subsequent processes.
		IF MIR-POL-ID-BASE == ""
		{
#J03978 VALIDATE MIR-GDT-OBJ-ID VS MIR-POL-APP-FORM-ID IN THE GAAP TABLE (ACTIVITY MANAGEMENT) 
			# THE NEXT VALIDATION WILL BE DONE ONLY IF THE CALL CAME FROM BF9354-O (GAAP)
			IF MIR-DV-CALL-FROM-GAAP-IND == "Y"
			{
				STEP ValidateobjID
				{
					USES P-STEP "BF9350-P";
					UPPER(MIR-POL-APP-FORM-ID) -> MIR-APP-FORM-ID;
					ws-gdt-obj-id <- MIR-GDT-OBJ-ID-T[1];
					ws-pol-id <- MIR-POL-ID-BASE;
				}
				IF LSIR-RETURN-CD == "03" || LSIR-RETURN-CD == "05"
				{
					MIR-POL-ID-BASE = "";
					MIR-POL-ID-SFX = "";
					BRANCH ApplicationDataInput;
				}	
				IF UPPER(ws-gdt-obj-id) != UPPER(MIR-GDT-OBJ-ID)
				{
					STEP SendUserMessage01
					{
						USES P-STEP "BF9261-P";
						MIR-POL-APP-FORM-ID -> MIR-POL-OR-CLI-ID;
						SESSION.MIR-USER-ID -> MIR-USER-ID;
						# FATAL ERROR - The Witness ID @1 was not related to the Application Form ID @2 previously entered)  
						# FATAL ERROR - L'ID t�moin @1 n'est pas reli� � la proposition @2 sur Gestion d'acitvit� (Proposition) 
						"BF93509001" -> MIR-MSG-REF-INFO-T[1];
						UPPER(MIR-GDT-OBJ-ID) -> MIR-MSG-PARM-INFO-1-T[1];
						UPPER(MIR-POL-APP-FORM-ID) -> MIR-MSG-PARM-INFO-2-T[1];
					}
					MIR-POL-ID-BASE = "";
					MIR-POL-ID-SFX = "";
					BRANCH ApplicationDataInput;
				}	
				IF ws-pol-id != ""
				{
					STEP SendUserMessage02
					{
						USES P-STEP "BF9261-P";
						MIR-POL-APP-FORM-ID -> MIR-POL-OR-CLI-ID;
						SESSION.MIR-USER-ID -> MIR-USER-ID;
						# FATAL ERROR - Policy Number @1 was related to the Application Form ID @2 on Activity Management (Application) 
						# FATAL ERROR - Le num�ro de police @1 est d�j� reli� � la propositon @2 sur gestion d'actitvit� (Proposition) 
						"BF93509002" -> MIR-MSG-REF-INFO-T[1];
						ws-pol-id -> MIR-MSG-PARM-INFO-1-T[1];
						UPPER(MIR-POL-APP-FORM-ID) -> MIR-MSG-PARM-INFO-2-T[1];
					}
					MIR-POL-ID-BASE = "";
					MIR-POL-ID-SFX = "";
					BRANCH ApplicationDataInput;
				}	
			}
			#J03978 End of change of validate 
#			IF UPPER(SUBSTRING(MIR-POL-APP-FORM-ID, 1, 1)) == "E" && MIR-POL-ELEC-PRPS-IND == "N"
#			{
#				STEP SendUserMessage03
#				{
#					USES P-STEP "BF9261-P";
#					MIR-POL-APP-FORM-ID -> MIR-POL-OR-CLI-ID;
#					SESSION.MIR-USER-ID -> MIR-USER-ID;
#					# FATAL ERROR - Electonic proposal must be selected if application form ID start by 'E'                 
#					# FATAL ERROR - Proposition �lectronique doit �tre s�lectionn� si num�ro de proposition d�bute par 'E'
#					"XS92609001" -> MIR-MSG-REF-INFO-T[1];
#				}
#				MIR-POL-ID-BASE = "";
#				MIR-POL-ID-SFX = "";
#				BRANCH ApplicationDataInput;
#			}	
#			IF UPPER(SUBSTRING(MIR-POL-APP-FORM-ID, 1, 1)) != "E" && MIR-POL-ELEC-PRPS-IND == "Y"
#			{
#				STEP SendUserMessage04
#				{
#					USES P-STEP "BF9261-P";
#					MIR-POL-APP-FORM-ID -> MIR-POL-OR-CLI-ID;
#					SESSION.MIR-USER-ID -> MIR-USER-ID;
#					# FATAL ERROR - If Electonic proposal is selected, the application form ID number must start by 'E'                 
#					# FATAL ERROR - Si Proposition �lectronique est s�lectionn�e, le num�ro de proposition doit d�buter par 'E'
#					"XS92609002" -> MIR-MSG-REF-INFO-T[1];
#				}
#				MIR-POL-ID-BASE = "";
#				MIR-POL-ID-SFX = "";
#				BRANCH ApplicationDataInput;
#			}				
#J03978 Si toutes les validation pr�ce�dente sont OK on peut g�n�rer et cr�er le nouveau num�ro de police
			STEP PolicyCreate
			{
				USES P-STEP "BF8001-P";
				UserDefinedPolicyIDBase -> MIR-POL-ID-BASE;
				UserDefinedPolicyIDSuffix -> MIR-POL-ID-SFX;
			}

			IF LSIR-RETURN-CD == "01" || LSIR-RETURN-CD == "02" || LSIR-RETURN-CD == "05"
			{
				# 
				MIR-POL-ID-BASE = "";
				MIR-POL-ID-SFX = "";
				BRANCH ApplicationDataInput;
			}

			# 
			BannerPolicyID = MIR-POL-ID-BASE + " " + MIR-POL-ID-SFX;
			BannerProductID = MIR-PLAN-ID;
			ws-save-gdt-obj-id = MIR-GDT-OBJ-ID;
			ws-save-dv-club-id = MIR-DV-CLUB-CLI-ID;
			ws-pol-app-form-id = MIR-POL-APP-FORM-ID;
			STEP UpdateCoveragePrimaryInsured
			{
				USES P-STEP "BF8026-P";
				MIR-INSRD-CLI-ID-T[1] -> MIR-CLI-ID;
			}

			IF LSIR-RETURN-CD != "00"
			{
				BRANCH ApplicationDataInput;
			}

		}

		# Create a replacement record if user has indicated
		# the policy is being replaced.  This step will be executed
		# as above, but only if the above step is successful.
		# Regradless of internal or external based, create the
		# REPL record to denote it is to be used for inbound business.

	
		IF ReplacementQuestion == "Y"
		{
			IF MIR-POL-REPL-SEQ-NUM == ""
			{
				STEP ReplacementRecord
				{
					USES P-STEP "BF1651-P";
				}

				IF LSIR-RETURN-CD != "00"
				{
					BRANCH ApplicationDataInput;
				}

			}

			IF ReplacementCode == "Internal"
			{
				# 
				MIR-POL-REPL-TYP-CD = "I";
			}

			IF ReplacementCode == "External"
			{
				# 
				MIR-POL-REPL-TYP-CD = "E";
			}

			# 
			MIR-POL-REPL-DIR-CD = "I";
			STEP ReplacementRecordUpdate
			{
				USES P-STEP "BF1652-P";
			}

			IF LSIR-RETURN-CD != "00"
			{
				BRANCH ApplicationDataInput;
			}

		}

		STEP PolicyUpdate
		{
			USES P-STEP "AppBF8002-P";
			"P" -> MIR-DV-OWN-SUB-CD-T[1];
			AdditionalOwnerClientID-T[1] -> MIR-CLI-ID-T[2];
			AdditionalOwnerClientNM-T[1] -> MIR-DV-OWN-CLI-NM-T[2];
			AdditionalOwnerClientID-T[2] -> MIR-CLI-ID-T[3];
			AdditionalOwnerClientNM-T[2] -> MIR-DV-OWN-CLI-NM-T[3];
			AdditionalOwnerClientID-T[3] -> MIR-CLI-ID-T[4];
			AdditionalOwnerClientNM-T[3] -> MIR-DV-OWN-CLI-NM-T[4];
			AdditionalOwnerClientID-T[4] -> MIR-CLI-ID-T[5];
			AdditionalOwnerClientNM-T[4] -> MIR-DV-OWN-CLI-NM-T[5];
			MIR-POL-APP-RECV-DT -> MIR-POL-ISS-EFF-DT;
		}
		MIR-GDT-OBJ-ID = ws-save-gdt-obj-id; 
		MIR-DV-CLUB-CLI-ID = ws-save-dv-club-id;
		MIR-POL-APP-FORM-ID = ws-pol-app-form-id;

		IF LSIR-RETURN-CD == "01" || LSIR-RETURN-CD == "02" || LSIR-RETURN-CD == "05"
		{
			BRANCH ApplicationDataInput;
		}

	}
		
	# 
	BannerPolicyID = MIR-POL-ID-BASE + " " + MIR-POL-ID-SFX;
	BannerProductID = MIR-PLAN-ID;
	# update the session object for the policy number just created
	# so that any new window opened will assume this value
	SESSION.MIR-POL-ID-BASE = MIR-POL-ID-BASE;
	SESSION.MIR-POL-ID-SFX = MIR-POL-ID-SFX;
	# *****************************************************************
	# Collect Policy data.  This includes rider information as well
	# as Death Benefit Option.
	# *****************************************************************
	STEP PolicyDataRetrieve
	{
		USES P-STEP "BF8000-P";
		ATTRIBUTES
		{
			GetMessages = RetrieveMessages;
		}
	}


	STEP CoverageDataRetrieve
	{
		USES P-STEP "BF8024-P";
		ATTRIBUTES
		{
			GetMessages = RetrieveMessages;
		}
	}



	IF ReturnToPolicyData == "TRUE"
	{
		# 
		MIR-CVG-FACE-AMT-T[1] = temp-face-amt-1;
		MIR-CVG-FACE-AMT-T[2] = temp-face-amt-2;
		MIR-CVG-FACE-AMT-T[3] = temp-face-amt-3;
		MIR-CVG-FACE-AMT-T[4] = temp-face-amt-4;
		MIR-CVG-FACE-AMT-T[5] = temp-face-amt-5;
		MIR-CVG-AD-FACE-AMT-T[1] = temp-face-adamt-1;
		MIR-CVG-AD-FACE-AMT-T[2] = temp-face-adamt-2;
		MIR-CVG-AD-FACE-AMT-T[3] = temp-face-adamt-3;
		MIR-CVG-AD-FACE-AMT-T[4] = temp-face-adamt-4;
		MIR-CVG-AD-FACE-AMT-T[5] = temp-face-adamt-5;
		ReturnToPolicyData = "";
	}

	AfterSearchInsured:

	# If record has been updated by another session since the
	# original retrieve, the RetrieveMessages variable will be set to NO.
	# Reset the value back to YES.
	RetrieveMessages = "YES";
	# MD007K Mettre indicateur a oui car information necessaire pour le J-Script
	ConnectedInformationNeeded = "N";
	BeforePolicyDatainput:

# RM202A Remplacer les steps Health ou traditionnelles pour un seul step S�curigroupe

	# MD007K ANO-212 Keep info in storage
	# MD007K DDC-069 10 couvertures pour la proposition traditionnelle
	STEP PolicyDataInput
	{
		USES S-STEP "AppPolicyDataSecur";
		STRINGTABLE.IDS_TITLE_AppPolicyData -> Title;
		"AppButtonBar" -> ButtonBar;
		ConnectedInformationNeeded -> ConnectedIndicator;
		AppFormTypeID -> ApplicationIndicator;
		ConnPolId1 -> MIR-CONN-POL-ID-T[1];
		ConnCvgNum1 -> MIR-CONN-CVG-NUM-T[1];
		CvgConnReasnCd1 -> MIR-CVG-CONN-REASN-CD-T[1];
		ConnPolId2 -> MIR-CONN-POL-ID-T[2];
		ConnCvgNum2 -> MIR-CONN-CVG-NUM-T[2];
		CvgConnReasnCd2 -> MIR-CVG-CONN-REASN-CD-T[2];
		ConnPolId3 -> MIR-CONN-POL-ID-T[3];
		ConnCvgNum3 -> MIR-CONN-CVG-NUM-T[3];
		CvgConnReasnCd3 -> MIR-CVG-CONN-REASN-CD-T[3];
		ConnPolId4 -> MIR-CONN-POL-ID-T[4];
		ConnCvgNum4 -> MIR-CONN-CVG-NUM-T[4];
		CvgConnReasnCd4 -> MIR-CVG-CONN-REASN-CD-T[4];
		ConnPolId5 -> MIR-CONN-POL-ID-T[5];
		ConnCvgNum5 -> MIR-CONN-CVG-NUM-T[5];
		CvgConnReasnCd5 -> MIR-CVG-CONN-REASN-CD-T[5];
		ConnPolId6 -> MIR-CONN-POL-ID-T[6];
		ConnCvgNum6 -> MIR-CONN-CVG-NUM-T[6];
		CvgConnReasnCd6 -> MIR-CVG-CONN-REASN-CD-T[6];
		ConnPolId7 -> MIR-CONN-POL-ID-T[7];
		ConnCvgNum7 -> MIR-CONN-CVG-NUM-T[7];
		CvgConnReasnCd7 -> MIR-CVG-CONN-REASN-CD-T[7];
		ConnPolId8 -> MIR-CONN-POL-ID-T[8];
		ConnCvgNum8 -> MIR-CONN-CVG-NUM-T[8];
		CvgConnReasnCd8 -> MIR-CVG-CONN-REASN-CD-T[8];
		ConnPolId9 -> MIR-CONN-POL-ID-T[9];
		ConnCvgNum9 -> MIR-CONN-CVG-NUM-T[9];
		CvgConnReasnCd9 -> MIR-CVG-CONN-REASN-CD-T[9];
		ConnPolId10 -> MIR-CONN-POL-ID-T[10];
		ConnCvgNum10 -> MIR-CONN-CVG-NUM-T[10];
		CvgConnReasnCd10 -> MIR-CVG-CONN-REASN-CD-T[10];
	#J03978 BEGIN
			ws-gdt-obj-id -> wsGdtObjId;
	#J03978
	}


	ConnPolId1 = MIR-CONN-POL-ID-T[1];
	ConnCvgNum1 = MIR-CONN-CVG-NUM-T[1];
	CvgConnReasnCd1 = MIR-CVG-CONN-REASN-CD-T[1];
	ConnPolId2 = MIR-CONN-POL-ID-T[2];
	ConnCvgNum2 = MIR-CONN-CVG-NUM-T[2];
	CvgConnReasnCd2 = MIR-CVG-CONN-REASN-CD-T[2];
	ConnPolId3 = MIR-CONN-POL-ID-T[3];
	ConnCvgNum3 = MIR-CONN-CVG-NUM-T[3];
	CvgConnReasnCd3 = MIR-CVG-CONN-REASN-CD-T[3];
	ConnPolId4 = MIR-CONN-POL-ID-T[4];
	ConnCvgNum4 = MIR-CONN-CVG-NUM-T[4];
	CvgConnReasnCd4 = MIR-CVG-CONN-REASN-CD-T[4];
	ConnPolId5 = MIR-CONN-POL-ID-T[5];
	ConnCvgNum5 = MIR-CONN-CVG-NUM-T[5];
	CvgConnReasnCd5 = MIR-CVG-CONN-REASN-CD-T[5];
	ConnPolId6 = MIR-CONN-POL-ID-T[6];
	ConnCvgNum6 = MIR-CONN-CVG-NUM-T[6];
	CvgConnReasnCd6 = MIR-CVG-CONN-REASN-CD-T[6];
	ConnPolId7 = MIR-CONN-POL-ID-T[7];
	ConnCvgNum7 = MIR-CONN-CVG-NUM-T[7];
	CvgConnReasnCd7 = MIR-CVG-CONN-REASN-CD-T[7];
	ConnPolId8 = MIR-CONN-POL-ID-T[8];
	ConnCvgNum8 = MIR-CONN-CVG-NUM-T[8];
	CvgConnReasnCd8 = MIR-CVG-CONN-REASN-CD-T[8];
	ConnPolId9 = MIR-CONN-POL-ID-T[9];
	ConnCvgNum9 = MIR-CONN-CVG-NUM-T[9];
	CvgConnReasnCd9 = MIR-CVG-CONN-REASN-CD-T[9];
	ConnPolId10 = MIR-CONN-POL-ID-T[10];
	ConnCvgNum10 = MIR-CONN-CVG-NUM-T[10];
	CvgConnReasnCd10 = MIR-CVG-CONN-REASN-CD-T[10];
	IF action == "GoToInsuredSearch"
	{
		STEP IndividualSearchInsured
		{
			USES PROCESS "AppIndivSearchCdn";
			STRINGTABLE.IDS_TITLE_AppSearchPrimaryInsured -> SearchTitle;
			STRINGTABLE.IDS_TITLE_AppListPrimaryInsured -> ListTitle;
			STRINGTABLE.IDS_TITLE_AppCreatePrimaryInsured -> CreateTitle;
			STRINGTABLE.IDS_TITLE_AppUpdatePrimaryInsured -> UpdateTitle;
			MIR-INSRD-CLI-ID-T[index] -> MIR-CLI-ID;
			MIR-DV-INSRD-CLI-NM-T[index] -> MIR-DV-CLI-NM;
			MIR-INSRD-CLI-ID-T[index] <- MIR-CLI-ID;
			MIR-DV-INSRD-CLI-NM-T[index] <- MIR-DV-CLI-NM;
		}

		# BECAUSE VARIABLE LastAction IS NOT USED AT THIS POINT IN THE FLOW
		# RE-SET TO BLANKS TO AVOID POSSSIBLE ISSUES LATER IN THE FLOW
		LastAction = "";
		# BRANCH PolicyDataInput;
		STEP CoverageDataProcessIns
		{
			USES P-STEP "AppBF8025-P";
		}

		BRANCH AfterSearchInsured;
	}
	IF action == "ACTION_PREVIOUS"
	{
		STEP CoverageDataProcess
		{
			USES P-STEP "AppBF8025-P";
		}

		IF LSIR-RETURN-CD == "01" || LSIR-RETURN-CD == "02" || LSIR-RETURN-CD == "05"
		{
			# BRANCH PolicyDataInput;
			# MD007K Branch avant le IF statement pour le flow de vie sante
			BRANCH AfterSearchInsured;
		}

		# preserve coverage values for a return to this page.
		# This is only required to allow the user to see the
		# values they have entered, which may have produced errors they
		# wish to correct.
		temp-face-amt-1 = MIR-CVG-FACE-AMT-T[1];
		temp-face-amt-2 = MIR-CVG-FACE-AMT-T[2];
		temp-face-amt-3 = MIR-CVG-FACE-AMT-T[3];
		temp-face-amt-4 = MIR-CVG-FACE-AMT-T[4];
		temp-face-amt-5 = MIR-CVG-FACE-AMT-T[5];
		temp-face-adamt-1 = MIR-CVG-AD-FACE-AMT-T[1];
		temp-face-adamt-2 = MIR-CVG-AD-FACE-AMT-T[2];
		temp-face-adamt-3 = MIR-CVG-AD-FACE-AMT-T[3];
		temp-face-adamt-4 = MIR-CVG-AD-FACE-AMT-T[4];
		temp-face-adamt-5 = MIR-CVG-AD-FACE-AMT-T[5];
		ReturnToPolicyData = "TRUE";
	       #BRANCH MailingAddressRetrieve;
		MIR-GDT-OBJ-ID = ws-save-gdt-obj-id; 
		MIR-DV-CLUB-CLI-ID = ws-save-dv-club-id;
		MIR-POL-APP-FORM-ID = ws-pol-app-form-id;
		BRANCH ApplicationDataInput;
	}
	IF action == "ACTION_NEXT"
	{
		# MD007K Ajout d'une validation pour la police connecte
		# MD007K DDC-069 10 couvertures pour la proposition traditionnelle		
		IF ReplacementQuestion == "Y" && ReplacementCode == "Internal"
		{
			# J03978 - JFO - bypass the next validation concerning the replacement vs connected policy, cvg,reasn
			BRANCH PolicyDataProcess;
			IF MIR-CONN-POL-ID-T[1] != "" && MIR-CONN-CVG-NUM-T[1] != "" && MIR-CVG-CONN-REASN-CD-T[1] != ""
			{
				BRANCH PolicyDataProcess;
			}

			IF MIR-CONN-POL-ID-T[2] != "" && MIR-CONN-CVG-NUM-T[2] != "" && MIR-CVG-CONN-REASN-CD-T[2] != ""
			{
				BRANCH PolicyDataProcess;
			}

			IF MIR-CONN-POL-ID-T[3] != "" && MIR-CONN-CVG-NUM-T[3] != "" && MIR-CVG-CONN-REASN-CD-T[3] != ""
			{
				BRANCH PolicyDataProcess;
			}

			IF MIR-CONN-POL-ID-T[4] != "" && MIR-CONN-CVG-NUM-T[4] != "" && MIR-CVG-CONN-REASN-CD-T[4] != ""
			{
				BRANCH PolicyDataProcess;
			}

			IF MIR-CONN-POL-ID-T[5] != "" && MIR-CONN-CVG-NUM-T[5] != "" && MIR-CVG-CONN-REASN-CD-T[5] != ""
			{
				BRANCH PolicyDataProcess;
			}

			IF MIR-CONN-POL-ID-T[6] != "" && MIR-CONN-CVG-NUM-T[6] != "" && MIR-CVG-CONN-REASN-CD-T[6] != ""
			{
				BRANCH PolicyDataProcess;
			}

			IF MIR-CONN-POL-ID-T[7] != "" && MIR-CONN-CVG-NUM-T[7] != "" && MIR-CVG-CONN-REASN-CD-T[7] != ""
			{
				BRANCH PolicyDataProcess;
			}

			IF MIR-CONN-POL-ID-T[8] != "" && MIR-CONN-CVG-NUM-T[8] != "" && MIR-CVG-CONN-REASN-CD-T[8] != ""
			{
				BRANCH PolicyDataProcess;
			}

			IF MIR-CONN-POL-ID-T[9] != "" && MIR-CONN-CVG-NUM-T[9] != "" && MIR-CVG-CONN-REASN-CD-T[9] != ""
			{
				BRANCH PolicyDataProcess;
			}

			IF MIR-CONN-POL-ID-T[10] != "" && MIR-CONN-CVG-NUM-T[10] != "" && MIR-CVG-CONN-REASN-CD-T[10] != ""
			{
				BRANCH PolicyDataProcess;
			}

			ConnectedInformationNeeded = "Y";
			BRANCH BeforePolicyDatainput;
		}

		STEP PolicyDataProcess
		{
			USES P-STEP "AppBF8002-P";
		}

		IF LSIR-RETURN-CD == "01" || LSIR-RETURN-CD == "02" || LSIR-RETURN-CD == "05"
		{
			# BRANCH PolicyDatainput;
			BRANCH BeforePolicyDatainput;
		}

		IF LSIR-RETURN-CD == "06"
		{
			# 
			RetrieveMessages = "NO";
			BRANCH PolicyDataRetrieve;
		}

		STEP CoverageDataProcess2
		{
			USES P-STEP "AppBF8025-P";
		}

		IF LSIR-RETURN-CD == "01" || LSIR-RETURN-CD == "02" || LSIR-RETURN-CD == "05"
		{
			# BRANCH PolicyDataInput;
			BRANCH BeforePolicyDatainput;
		}

		IF LSIR-RETURN-CD == "06"
		{
			# 
			RetrieveMessages = "NO";
			BRANCH PolicyDataRetrieve;
		}

	}

	# Preserve messages from the action_next step above.
	# Messages are being overridden by the p-steps that follow, prior
	# to an s-step being displayed.
	temp-msg-t = MESSAGES-T;
	# preserve coverage values from this last page for a return
	# to this page.  This is only required to allow the user to see the
	# values they have entered, which may have produced errors they
	# wish to correct.
	temp-face-amt-1 = MIR-CVG-FACE-AMT-T[1];
	temp-face-amt-2 = MIR-CVG-FACE-AMT-T[2];
	temp-face-amt-3 = MIR-CVG-FACE-AMT-T[3];
	temp-face-amt-4 = MIR-CVG-FACE-AMT-T[4];
	temp-face-amt-5 = MIR-CVG-FACE-AMT-T[5];
	temp-face-adamt-1 = MIR-CVG-AD-FACE-AMT-T[1];
	temp-face-adamt-2 = MIR-CVG-AD-FACE-AMT-T[2];
	temp-face-adamt-3 = MIR-CVG-AD-FACE-AMT-T[3];
	temp-face-adamt-4 = MIR-CVG-AD-FACE-AMT-T[4];
	temp-face-adamt-5 = MIR-CVG-AD-FACE-AMT-T[5];
	ReturnToPolicyData = "TRUE";
	# *****************************************************************
	# Collect Beneficiary Information
	# Call a sub-flow for this
	# *****************************************************************
	STEP Beneficiary
	{
		USES PROCESS "AppBene";
		ATTRIBUTES
		{
			GetMessages = "NO";
		}
	}

	IF LastAction == "ACTION_PREVIOUS"
	{
		# 
		LastAction = "";
		BRANCH PolicyDataRetrieve;
	}


	# *****************************************************************
	# Collect Billing Information
	# And display the banking for the default payor
	# *****************************************************************
	# Retrieve policy billing information
	STEP BillingInfoRetrieve
	{
		USES P-STEP "BF8000-P";
		ATTRIBUTES
		{
			GetMessages = RetrieveMessages;
		}
	}

	# primary owner client info returned by policy retrieve will be in
	# MIR-CLI-ID-T-1.  Set the Payor client id = this value, and retrieve
	# the client record (for banking and credit card info).  this is done to preempt the
	# users choice of PAC or Credit Card as the billing type.
        # MD007K ANO-277 Le champ MIR-DV-PAYR-CLI-ID devrait toujours afficher le payeur selectionne par l'utilisateur
	# MIR-DV-PAYR-CLI-ID = MIR-CLI-ID-T[1];
        IF  MIR-DV-PAYR-CLI-ID == "" || MIR-DV-PAYR-CLI-ID == "*"
	{
            MIR-DV-PAYR-CLI-ID = MIR-CLI-ID-T[1];
        }
	# set the value of the listbill draw day and the credit card draw day
	# field equal to that of the current policy payment draw day field.
	# This is done to display the same value if already entered in the draw day
	# selection boxes for each of these fields.  Only one of these field values
	# will be sent to the server upon submission, as they share the same
	# destination field on the server (mir-pol-pmt-drw-dy).
	# Functional 20467: MIR-DV-POL-DD2-PMT-DY added.
	MIR-POL-LBILL-DRW-DY = MIR-POL-PMT-DRW-DY;
	MIR-DV-POL-CRC-PMT-DY = MIR-POL-PMT-DRW-DY;
	MIR-DV-POL-DD2-PMT-DY = MIR-POL-PMT-DRW-DY;
	# return the name from the client retrieve (who is the owner
	# /payor) to a page variable used for display only
	STEP BankingInfoRetrieve
	{
		USES P-STEP "BF1220-P";
		ATTRIBUTES
		{
			GetMessages = RetrieveMessages;
		}
		MIR-DV-PAYR-CLI-ID -> MIR-CLI-ID;
		PayorName <- MIR-DV-CLI-NM;
	}

	# Billing method/mode selection box is a composite of method
	# and mode.  combine these 2 fields that reside on the policy
	# in separate fields, into 1
	MIR-DV-SBOX-CD-T = MIR-POL-BILL-TYP-CD + MIR-POL-BILL-MODE-CD;
	# default a value to SFB start date if one is not present.  this is
	# done to preempt the users choice of listbill as the billing type.
	# if the field was valued already, then this means the user is returning
	# to this page after having already selected a start date.  in this case
	# we do not want to override that field value.
	IF MIR-SFB-STRT-DT == ""
	{
		# 
		MIR-SFB-STRT-DT = MIR-POL-ISS-EFF-DT;
	}
#J03558
	index = BillingIndex;
#J03358
	# If record has been updated by another session since the
	# original retrieve, the RetrieveMessages variable will be set to NO.
	# Reset the value back to YES.
	RetrieveMessages = "YES";
	# MD007K ANO-212 Keep info in storage
	STEP BillingInfoUpdate
	{
		USES S-STEP "AppBillingCdnTradSecur";
		STRINGTABLE.IDS_TITLE_AppBillingData -> Title;
	}

	IF action == "ACTION_PREVIOUS"
	{
		BRANCH Beneficiary;
	}

	# MD007K Debut
	IF action == "GoToIndividualSearch"
	{
		STEP IndividualSearchPayor
		{
			USES PROCESS "AppIndivSearchCdn";
#J03395 BEGIN
#			STRINGTABLE.IDS_TITLE_AppSearchPrimaryInsured -> SearchTitle;
#			STRINGTABLE.IDS_TITLE_AppListPrimaryInsured -> ListTitle;
#			STRINGTABLE.IDS_TITLE_AppCreatePrimaryInsured -> CreateTitle;
#			STRINGTABLE.IDS_TITLE_AppUpdatePrimaryInsured -> UpdateTitle;
			STRINGTABLE.IDS_TITLE_AppSearchPayor -> SearchTitle;
			STRINGTABLE.IDS_TITLE_AppListPayor -> ListTitle;
			STRINGTABLE.IDS_TITLE_AppCreatePayor -> CreateTitle;
			STRINGTABLE.IDS_TITLE_AppUpdatePayor -> UpdateTitle;
#J03395 END
			MIR-DV-PAYR-CLI-ID <- MIR-CLI-ID;
			PayorName <- MIR-DV-CLI-NM;
		}

		LastAction = "";
		BRANCH BankingInfoRetrieve;
	}

	# MD007K Fin
	# the following only applies to listbill situations (5,G, S).  the user will
	# not see this field in any other circumstance.
	IF action == "GoToCompanySearch"
	{
		# because the main flow calls a client retrieve function
		# within it (see the bank retrieve step above), the variables
		# for client now belong to the main flow.  As a result, we
		# need to set some of these variables to blank values in
		# order for the company search function to work.  There are
		# only 4 variables that need to be initialized (birth date
		# sex, tax id, and location - these are shared mir fields
		# between the 2200 and 1220 functions).  The company search
		# sub-process already initializes 3 of these (sex, tax,
		# location), so only the birth date requires initialization.
		# send values to the sub-process for preservation
		# of data in case user decides to cancel from that
		# sub-process
		# return values back from sub-process and map
		# to listbill fields
		STEP CompanyPayorSearch
		{
			USES PROCESS "AppCompSearchCdn";
			STRINGTABLE.IDS_TITLE_AppSearchCompanyPayor -> SearchTitle;
			STRINGTABLE.IDS_TITLE_AppListCompanyPayor -> ListTitle;
			STRINGTABLE.IDS_TITLE_AppCreateCompanyPayor -> CreateTitle;
			STRINGTABLE.IDS_TITLE_AppUpdateCompanyPayor -> UpdateTitle;
			"" -> MIR-CLI-BTH-DT;
			MIR-DV-LBILL-CLI-ID -> MIR-CLI-ID;
			MIR-DV-LBILL-CLI-NM -> MIR-DV-CLI-NM;
			MIR-DV-LBILL-CLI-ID <- MIR-CLI-ID;
			MIR-DV-LBILL-CLI-NM <- MIR-DV-CLI-NM;
		}

		BRANCH BillingInfoUpdate;
	}

	IF action == "ACTION_NEXT"
	{
		# Functional 20467: MIR-POL-BILL-TYP-CD = 'D' added.
		IF MIR-POL-BILL-TYP-CD == "4" || MIR-POL-BILL-TYP-CD == "C" || MIR-POL-BILL-TYP-CD == "D"
		{
			STEP ClientUpdateBilling
			{
				USES P-STEP "BF1222-P";
				MIR-DV-PAYR-CLI-ID -> MIR-CLI-ID;
			}

			# reset any listbill or SFB fields that may have been
			# inadvertently entered and not cleared properly.
			# although javascript exists for this page to reset values
			# to blanks, this only accommodates values within the page
			# and does not properly clear entries already made to the
			# server.  the value assignments below allow for return
			# visits to the page to clear values already stored on the
			# database.
			IF MIR-POL-BILL-TYP-CD == "C"
			{
				# 
				MIR-POL-PMT-DRW-DY = MIR-DV-POL-CRC-PMT-DY;
			}

			# Functional 20467: Two Stage Autopay added.
			IF MIR-POL-BILL-TYP-CD == "D"
			{
				# 
				MIR-POL-PMT-DRW-DY = MIR-DV-POL-DD2-PMT-DY;
			}

			# 
			MIR-DV-LBILL-CLI-ID = "*";
			MIR-POL-SFB-CD = "**";
			# the index number of the row on the page will correspond
			# to the client bank account displayed, or added.
			# send to the process driver the value for the bank account
			# selected to the payor relationship sub code.
			# the payor relationship itself is a derived field and
			# will be set via the process driver (MIR-DV-PAYR-CLI-ID).
			# preserve value of the index field for a return to this
			# page.
			MIR-DV-PAYR-SUB-CD = index;
			BillingIndex = index;
			# preserve messages from this step for later display.
			# a variable indicating there are messages from this
			# step will be used to determine if these should
			# be displayed to the user or not.
			BankingInfoMessages = "TRUE";
			banking-temp-msg-t = MESSAGES-T;
			BRANCH PolicyUpdateBilling;
		}

		IF MIR-POL-BILL-TYP-CD == "5" || MIR-POL-BILL-TYP-CD == "G" || MIR-POL-BILL-TYP-CD == "S"
		{
			# if listbill, but no special frequency, send in the group
			# delete to the SFB type code.  this will clear the value
			# we have defaulted into the SFB-STRT-DT field.
			IF SFYesNo == "N"
			{
				# 
				MIR-POL-SFB-CD = "**";
			}

			# re-assign the single policy field for draw day, to that
			# of the listbill draw day
			MIR-POL-PMT-DRW-DY = MIR-POL-LBILL-DRW-DY;
			MIR-DV-PAYR-CLI-ID = "*";
			BRANCH PolicyUpdateBilling;
		}

		# if not pac or credit card or listbill, ensure any variables going to server are
		# properly cleared of values
		MIR-DV-LBILL-CLI-ID = "*";
		MIR-POL-SFB-CD = "**";
		MIR-DV-PAYR-CLI-ID = "*";
		MIR-POL-PMT-DRW-DY = "*";
		STEP PolicyUpdateBilling
		{
			USES P-STEP "AppBF8002-P";
		}

		IF LSIR-RETURN-CD == "01" || LSIR-RETURN-CD == "02" || LSIR-RETURN-CD == "05"
		{
			BRANCH BillingInfoUpdate;
		}

		IF LSIR-RETURN-CD == "06"
		{
			# 
			RetrieveMessages = "NO";
			BRANCH BillingInfoRetrieve;
		}

		# Preserve messages from the step above.
		# Messages are being overridden by the p-steps that follow, prior
		# to an s-step being displayed.  an evaluation will be made
		# in the Insured data flow to determine if the messages preserved
		# from this step, or the one above, are to be displayed to the user.
		temp-msg-t = MESSAGES-T;
	}



	# *****************************************************************
	# Collect Insured Detailed Information
	# Call a sub-flow for this
	# *****************************************************************
	# MD007K Inserer un Branch pour ne pas executer ce process (ne pas avoir a repondre aux questions)

	#IN003  R�activate STEP InsuredData for LifeSuite in put BRANCH in comment out

	#RM202A D�sactivater STEP InsuredData for LifeSuite in put BRANCH in comment out

       	BRANCH SignInfoRetrieve;
	STEP InsuredData
	{
		USES PROCESS "AppInsuredCdn";
	}

	IF LastAction == "ACTION_PREVIOUS"
	{
		# 
		LastAction = "";
		# set the index value to the preserved variable for index
		# in order to re-display to the user, any bank account
		# selection they may have made.
		index = BillingIndex;
		# set the payor client id to the owner client id in order
		# to allow the user to re-select Credit Card or Pac as the billing type
		# and have a valid client id be sent to the policy for the
		# payor relationship.  set the payor name field to the owner
		# client name.  these settings are done only to preempt the
		# user changing their mind and setting a billing method
		# of pre-authorized payment from any other type, on revisiting
		# the billing page.
		MIR-DV-PAYR-CLI-ID = MIR-CLI-ID-T[1];
		PayorName = MIR-DV-OWN-CLI-NM-T[1];
		# branch to the s step instead of a full policy and client
		# retrieve, both to save response time, and to re-display to
		# the user, the information they may have keyed in on the
		# input page.  a straight retrieve of policy info would
		# wipe out messages and display only that data that made it
		# to the policy record
		BRANCH BillingInfoUpdate;
	}

	SignInfoRetrieve:

	IF RetrieveMessages == "NO"
	{
		STEP SignPolRetrieve
		{
			USES P-STEP "BF8000-P";
			ATTRIBUTES
			{
				GetMessages = RetrieveMessages;
			}
		}

		# 
		RetrieveMessages = "YES";
	}



	# *****************************************************************
	# Indicate whether the signatures have been captured and lists the
	# agents that participate in the policy
	# *****************************************************************
	# MD007K Mettre Non comme valeur par default
	# MD007K ANO-212 MIR-POL-MIB-SIGN-CD doit �tre initialis� seulement s'il est vide   

     
	IF  MIR-POL-MIB-SIGN-CD != "Y" && MIR-POL-MIB-SIGN-CD != "N"
        {
	    MIR-POL-MIB-SIGN-CD = "N";
	}
	SignaturesAgent:
	MIR-POL-APP-SIGN-DT = temp-pol-app-sign-dt;
	IF ReplacementQuestion == "Y"
	{
		STEP SignaturesSecur
		{
			USES S-STEP "AppSignaturesSecurRepl";
			STRINGTABLE.IDS_TITLE_AppSignatures -> Title;
			"Y" -> MIR-POL-MIB-SIGN-CD;
#			"Y" -> MIR-POL-APP-SIGN-IND;
			temp-prem-on-repl-pct-1 -> MIR-PREM-ON-REPL-PCT-T[1];
			temp-prem-on-repl-pct-2 -> MIR-PREM-ON-REPL-PCT-T[2];
			temp-prem-on-repl-pct-3 -> MIR-PREM-ON-REPL-PCT-T[3];
		}
	}
	IF ReplacementQuestion != "Y"
	{
		STEP Signatures
		{
			USES S-STEP "AppSignaturesSecur";
			STRINGTABLE.IDS_TITLE_AppSignatures -> Title;
			"Y" -> MIR-POL-MIB-SIGN-CD;
#			"Y" -> MIR-POL-APP-SIGN-IND;	
#J03395 Begin
			"bottinAgences" -> AgencySearchLink;
			"bottinConseillers" -> AgentSearchLink;
#J03395 Ended
		}
	}
	temp-pol-app-sign-dt = MIR-POL-APP-SIGN-DT;
	IF action == "GoToAgentSearch"
	{
		# send values to the sub-flow for preservation
		# should the user cancel from that sub-flow
		STEP AgentSearch
		{
			USES PROCESS "AppAgentSearch";
			ATTRIBUTES
			{
				GetMessages = "NO";
			}
			MIR-AGT-ID-T[index] -> MIR-AGT-ID;
			MIR-DV-AGT-CLI-NM-T[index] -> MIR-DV-SRCH-CLI-NM;
			MIR-AGT-ID-T[index] <- MIR-AGT-ID;
			MIR-DV-AGT-CLI-NM-T[index] <- MIR-DV-SRCH-CLI-NM;
		}

		IF index == 1
		{
			MIR-SERV-AGT-ID = MIR-AGT-ID-T[index];
			MIR-DV-SERV-AGT-CLI-NM = MIR-DV-AGT-CLI-NM-T[index];
		}
		IF MIR-DV-AGT-CLI-NM-T[index] != ""
		{
			MIR-POL-AGT-SHR-PCT-T[index] = "100.00";
		}

		BRANCH SignaturesAgent;
	}

	IF action == "GoToAgentSearchService"
	{
		# send values to the sub-flow for preservation
		# should the user cancel from that sub-flow
		STEP AgentSearchService
		{
			USES PROCESS "AppAgentSearch";
			ATTRIBUTES
			{
				GetMessages = "NO";
			}
			MIR-SERV-AGT-ID -> MIR-AGT-ID;
			MIR-DV-SERV-AGT-CLI-NM -> MIR-DV-SRCH-CLI-NM;
			MIR-SERV-AGT-ID <- MIR-AGT-ID;
			MIR-DV-SERV-AGT-CLI-NM <- MIR-DV-SRCH-CLI-NM;
		}

		BRANCH SignaturesAgent;
	}
	IF action == "ACTION_NEXT"
	{
		# if only 1 agent was entered and regardless of the entry
		# to the percent field (either none or any value),
		# default the percent to 100.
		IF MIR-AGT-ID-T[3] == "" && MIR-AGT-ID-T[2] == ""
		{
			# 
			MIR-POL-AGT-SHR-PCT-T[1] = "100.00";
		}

		STEP UpdateSignatures
		{
			USES P-STEP "AppBF8002-P";
			MIR-SERV-BR-ID <- MIR-SERV-BR-ID;
		}
		IF LSIR-RETURN-CD == "01" || LSIR-RETURN-CD == "02" || LSIR-RETURN-CD == "05"
		{
			BRANCH SignaturesAgent;
		}

		IF LSIR-RETURN-CD == "06"
		{
			# 
			RetrieveMessages = "NO";
			BRANCH SignInfoRetrieve;
		}
               temp-prem-on-repl-pct-1 = MIR-PREM-ON-REPL-PCT-T[1];
                temp-prem-on-repl-pct-2 = MIR-PREM-ON-REPL-PCT-T[2];
                temp-prem-on-repl-pct-3 = MIR-PREM-ON-REPL-PCT-T[3];

	#RM202A Ajouter le coverage update pour mettre a jour le champ du % provenant d'un remplacement 

		STEP CoverageDataProcess3
		{
			USES P-STEP "AppBF8025-P";
		}
		IF LSIR-RETURN-CD == "01" || LSIR-RETURN-CD == "02" || LSIR-RETURN-CD == "05"
		{
			BRANCH SignaturesAgent;
		}

		IF LSIR-RETURN-CD == "06"
		{
			# 
			RetrieveMessages = "NO";
			BRANCH SignInfoRetrieve;
		}

		# default the policy servicing agent from the writing agent
		# if there is no value on the policy for the servicing agent.
		# only do this, if the policy writing agents were
		# successfully updated
		IF MIR-SERV-AGT-ID == ""
		{
			# 
			MIR-SERV-AGT-ID = MIR-AGT-ID-T[1];
			STEP UpdateServiceAgent
			{
				USES P-STEP "AppBF8002-P";
			}

			IF LSIR-RETURN-CD == "01" || LSIR-RETURN-CD == "02" || LSIR-RETURN-CD == "05"
			{
				BRANCH SignaturesAgent;
			}

		}


		BRANCH CWA;
	}
	IF action == "ACTION_PREVIOUS"
	{
		# MD007K		BRANCH InsuredData;
		# MD007K Branch a l'etape avant les question
		BRANCH BillingInfoRetrieve;
	}

	# *****************************************************************
	# Collect Cash with Application
	# Call a sub-flow for this
	# *****************************************************************
	STEP CWA
	{
		USES PROCESS "AppCwaCdnTrad";
		ATTRIBUTES
		{
			GetMessages = "Yes";
		}
	}
#J03558 begin
	temp-msg-t = MESSAGES-T;
#J03558 End

	IF LastAction == "ACTION_PREVIOUS"
	{
		# 
		LastAction = "";
#RM202A		BRANCH SignaturesAgent;
		BRANCH SignInfoRetrieve;
	}

	# *****************************************************************
	# Perform Policy and Coverage Analysis.  Each coverage status
	# should change to Complete.  Then, update policy once more.
	# Finally, display Application Summary data and give the ability
	# to cross edit and clear case u/w.  Messages from Policy Update
	# and Check for Errors steps will be merged and displayed.
	# *****************************************************************
	STEP PolicyCoverageAnalysis
	{
		USES P-STEP "BF8004-P";
		ATTRIBUTES
		{
			GetMessages = "No";
		}
	}

	STEP ApplicationAnalysisPolicyUpdate
	{
		USES P-STEP "AppBF8002-P";
		ATTRIBUTES
		{
			GetMessages = "Yes";
		}
	}


	STEP ApplicationAnalysisCoverageRetrieve
	{
		USES P-STEP "BF8024-P";
		ATTRIBUTES
		{
			GetMessages = "No";
		}
	}


	STEP CheckPolicyForErrors
	{
		USES P-STEP "BF8004-P";
		ATTRIBUTES
		{
			GetMessages = "Merge";
		}
	}

	# default a value to the billing name field
	BillingName = MIR-DV-OWN-CLI-NM;
	# override the default value for special billing types
	IF MIR-POL-BILL-TYP-CD == "5" || MIR-POL-BILL-TYP-CD == "G" || MIR-POL-BILL-TYP-CD == "S"
	{
		# 
		BillingName = MIR-DV-LBILL-CLI-NM;
	}

	# Functional 20467: MIR-POL-BILL-TYP-CD = 'D' added.
	IF MIR-POL-BILL-TYP-CD == "4" || MIR-POL-BILL-TYP-CD == "C" || MIR-POL-BILL-TYP-CD == "D"
	{
		# 
		BillingName = MIR-DV-PAYR-CLI-NM;
	}

	TARGET6510:

#J03358 begin
#	MESSAGES-T = temp-msg-t;
#J03558 end

	STEP AppAnalysis
	{
		USES S-STEP "AppAnalysisSecur";
		STRINGTABLE.IDS_TITLE_AppAnalysis -> Title;
		"ButtonBarSettlePrevious" -> ButtonBar;
	}

	IF action == "GoToCheckPolicy"
	{
		STEP ReCheckPolicyForErrors
		{
			USES P-STEP "BF8004-P";
		}

		BRANCH TARGET6510;
	}
#J03558 Begin
	IF action == "ACTION_PREVIOUS"
	{
		BRANCH CWA;
	}
#J03558 End

	IF action == "ACTION_CANCEL"
	{
		EXIT;
	}
	# RM202A Debut  (Mettre le contrat S�curigroupe en vigueur une fois la saisie compl�t�e)

	IF action == "ACTION_SETTLE"
	{
		STEP Issue
		{
			USES P-STEP "BF1354-P";
			"S" -> MIR-DV-AUTO-SETL-CD;
			MIR-POL-ISS-DT-TYP-CD -> MIR-POL-ISS-DT-TYP-CD;
			"2" -> MIR-DV-PRCES-STATE-CD;
		}


		IF LSIR-RETURN-CD != "00"
		{
			BRANCH TARGET6510;
		}

		STEP IssuePart2
		{
			USES P-STEP "BF1354-P";
			"3" -> MIR-DV-PRCES-STATE-CD;
		}

		IF LSIR-RETURN-CD != "00" && LSIR-RETURN-CD != "03"
		{
			BRANCH TARGET6510;
		}

		# If the UpdateHost step caused the issue age to change, PRCES-STATE-CD will
		# returned as a 4 to indicate that another confirm step is required.
		# Otherwise the transaction  is complete.
		IF MIR-RETRN-CD == "03"
		{
			STEP IssuePart3
			{
				USES P-STEP "BF1354-P";
				"4" -> MIR-DV-PRCES-STATE-CD;
			}

		}

		IF LSIR-RETURN-CD != "00"
		{
#J03240 Start
#			TRACE("SEB02 -> " + LSIR-RETURN-CD);		
#			IF LSIR-RETURN-CD == "03"
#			{
#				HLD-LSIR-RETURN-CD = LSIR-RETURN-CD;
#				STEP BF0214-P
#				{
#					Envoi vers la SGED
#					USES P-STEP "BF0214-P";
#					"SGED" -> MIR-TRNXT-RPT-DSTRB-CD;
#					"Y" -> MIR-DV-CNTRCT-RQST-IND;
#					"N" -> MIR-DV-CCAS-RQST-IND;
#					"N" -> MIR-DV-CNFD-RQST-IND;
#					"N" -> MIR-DV-DAL-RQST-IND;
#					"N" -> MIR-DV-LAB-RSLT-RQST-IND;
#					"N" -> MIR-DV-CLI-REQIR-RQST-IND;
#					"N" -> MIR-DV-FP-RQST-IND;
#					"N" -> MIR-DV-PG-RQST-IND;
#					"N" -> MIR-DV-SUMM-RQST-IND;
#					"N" -> MIR-DV-STAT-RQST-IND;
#					"N" -> MIR-DV-AGT-RQST-IND;
#					"N" -> MIR-DV-AMEND-RQST-IND;
#					"N" -> MIR-DV-PERI-RQST-IND;
#					"N" -> MIR-DV-COST-RQST-IND;
#					"N" -> MIR-DV-POL-RQST-IND;
#					"N" -> MIR-DV-ANN-STMT-RQST-IND;
#					"N" -> MIR-DV-TEMPO-INDX-RQST-IND;
#					"N" -> MIR-DV-AGT-LBL-RQST-IND;
#					"N" -> MIR-DV-OWN-LBL-RQST-IND;
#					"N" -> MIR-DV-UL-INTRFC-RQST-IND;
#					"N" -> MIR-DV-VIEW-RQST-CNTRT-IND;
#				}
#				TRACE("SEB03 -> " + LSIR-RETURN-CD);		
#				IF LSIR-RETURN-CD != "00"
#				{
#					STEP SendUserMessage00
#					{
#						USES P-STEP "BF9261-P";
#						# Le PDF du contrat (@1) n'a pu �tre envoy� automatiquement vers la SGED
#						"BF00009000" -> MIR-MSG-REF-INFO-T[1];
#						MIR-POL-ID-BASE -> MIR-MSG-PARM-INFO-1-T[1];
#					}
#				}
#				ELSE
#				{
#					STEP SendUserMessage01
#					{
#						USES P-STEP "BF9261-P";
#						# Le PDF du contrat (@1) a �t� envoy� automatiquement vers la SGED
#						"BF00009001" -> MIR-MSG-REF-INFO-T[1];
#						MIR-POL-ID-BASE -> MIR-MSG-PARM-INFO-1-T[1];
#					}
#				}
#				LSIR-RETURN-CD = HLD-LSIR-RETURN-CD;			
#				HLD-LSIR-RETURN-CD = "";			
#			}
#J03240 End
			BRANCH TARGET6510;
		}




#D02046 - Don't need to BF1353-P because the BF1354 has called by the option "Automatic Settle" ("S" -> MIR-DV-AUTO-SETL-CD)
#		STEP SettlePart1
#		{
#			USES P-STEP "BF1353-P";
#			"" -> MIR-DV-POL-FUT-DT-CD;
#			"2" -> MIR-DV-PRCES-STATE-CD;
#		}

#		STEP SettlePart2
#		{
#			USES P-STEP "BF1353-P";
#			"3" -> MIR-DV-PRCES-STATE-CD;
#		}
#		# Store Messages from Settle to display on Output page
#		temp-msg-t = MESSAGES-T;
#		IF LSIR-RETURN-CD != "00"
#		{
#			BRANCH PolicyRetrieve;
#		}
#D02046 - endded
		STEP PolicyRetrieve
		{
			USES P-STEP "BF8004-P";
		}

		STEP AppPolicyUPdate
		{
			USES P-STEP "AppBF8002-P";
		}

		STEP CoverageRetrieve
		{
			USES P-STEP "BF8024-P";
			ATTRIBUTES
		{
			GetMessages = "No";
		}
	}
		IF LSIR-RETURN-CD != "00"
		{
#J03240 Start
#			TRACE("SEB05 -> " + LSIR-RETURN-CD);		
#			HLD-LSIR-RETURN-CD = LSIR-RETURN-CD;
#			STEP BF0214-P
#			{
#				Envoi vers la SGED
#				USES P-STEP "BF0214-P";
#				"SGED" -> MIR-TRNXT-RPT-DSTRB-CD;
#				"Y" -> MIR-DV-CNTRCT-RQST-IND;
#				"N" -> MIR-DV-CCAS-RQST-IND;
#				"N" -> MIR-DV-CNFD-RQST-IND;
#				"N" -> MIR-DV-DAL-RQST-IND;
#				"N" -> MIR-DV-LAB-RSLT-RQST-IND;
#				"N" -> MIR-DV-CLI-REQIR-RQST-IND;
#				"N" -> MIR-DV-FP-RQST-IND;
#				"N" -> MIR-DV-PG-RQST-IND;
#				"N" -> MIR-DV-SUMM-RQST-IND;
#				"N" -> MIR-DV-STAT-RQST-IND;
#				"N" -> MIR-DV-AGT-RQST-IND;
#				"N" -> MIR-DV-AMEND-RQST-IND;
#				"N" -> MIR-DV-PERI-RQST-IND;
#				"N" -> MIR-DV-COST-RQST-IND;
#				"N" -> MIR-DV-POL-RQST-IND;
#				"N" -> MIR-DV-ANN-STMT-RQST-IND;
#				"N" -> MIR-DV-TEMPO-INDX-RQST-IND;
#				"N" -> MIR-DV-AGT-LBL-RQST-IND;
#				"N" -> MIR-DV-OWN-LBL-RQST-IND;
#				"N" -> MIR-DV-UL-INTRFC-RQST-IND;
#				"N" -> MIR-DV-VIEW-RQST-CNTRT-IND;
#			}
#
#			TRACE("SEB06 -> " + LSIR-RETURN-CD);		
#			IF LSIR-RETURN-CD != "00"
#			{
#				STEP SendUserMessage00
#				{
#					USES P-STEP "BF9261-P";
#					# Le PDF du contrat (@1) n'a pu �tre envoy� automatiquement vers la SGED
#					"BF00009000" -> MIR-MSG-REF-INFO-T[1];
#					MIR-POL-ID-BASE -> MIR-MSG-PARM-INFO-1-T[1];
#				}
#			}
#			ELSE
#			{
#				STEP SendUserMessage01
#				{
#					USES P-STEP "BF9261-P";
#					# Le PDF du contrat (@1) a �t� envoy� automatiquement vers la SGED
#					"BF00009001" -> MIR-MSG-REF-INFO-T[1];
#					MIR-POL-ID-BASE -> MIR-MSG-PARM-INFO-1-T[1];
#				}
#			}
#			LSIR-RETURN-CD = HLD-LSIR-RETURN-CD;			
#			HLD-LSIR-RETURN-CD = "";			
#J03240 End
			BRANCH TARGET3083;
		}

		# Redisplay stored messages from Settle on Output page
		MESSAGES-T = temp-msg-t;

	}


#J03240 Start
	HLD-LSIR-RETURN-CD = LSIR-RETURN-CD;
	STEP BF0214-P
	{
#		Envoi vers la SGED
		USES P-STEP "BF0214-P";
#J04714		"SGED" -> MIR-TRNXT-RPT-DSTRB-CD;
		"SYSTEM" -> MIR-TRNXT-RPT-DSTRB-CD;
		"Y" -> MIR-DV-CNTRCT-RQST-IND;
		"N" -> MIR-DV-CCAS-RQST-IND;
		"N" -> MIR-DV-CNFD-RQST-IND;
		"N" -> MIR-DV-DAL-RQST-IND;
		"N" -> MIR-DV-LAB-RSLT-RQST-IND;
		"N" -> MIR-DV-CLI-REQIR-RQST-IND;
		"N" -> MIR-DV-FP-RQST-IND;
		"N" -> MIR-DV-PG-RQST-IND;
		"N" -> MIR-DV-SUMM-RQST-IND;
		"N" -> MIR-DV-STAT-RQST-IND;
		"N" -> MIR-DV-AGT-RQST-IND;
		"N" -> MIR-DV-AMEND-RQST-IND;
		"N" -> MIR-DV-PERI-RQST-IND;
		"N" -> MIR-DV-COST-RQST-IND;
		"N" -> MIR-DV-POL-RQST-IND;
		"N" -> MIR-DV-ANN-STMT-RQST-IND;
		"N" -> MIR-DV-TEMPO-INDX-RQST-IND;
		"N" -> MIR-DV-AGT-LBL-RQST-IND;
		"N" -> MIR-DV-OWN-LBL-RQST-IND;
		"N" -> MIR-DV-UL-INTRFC-RQST-IND;
#J00825 Start
		"N" -> MIR-DV-DUP-RQST-IND;
		"N" -> MIR-DV-CHNG-RQST-IND;
#J00825 End		
#		"N" -> MIR-DV-VIEW-RQST-CNTRT-IND;
	}

	IF LSIR-RETURN-CD != "00"
	{
		STEP SendUserMessage00
		{
			USES P-STEP "BF9261-P";
			# Le PDF du contrat (@1) n'a pu �tre envoy� automatiquement vers la SGED
			"BF00009000" -> MIR-MSG-REF-INFO-T[1];
			MIR-POL-ID-BASE -> MIR-MSG-PARM-INFO-1-T[1];
		}
	}
	ELSE
	{
		STEP SendUserMessage03
		{
			USES P-STEP "BF9261-P";
			# Le PDF du contrat (@1) a �t� envoy� automatiquement vers la SGED
			"BF00009001" -> MIR-MSG-REF-INFO-T[1];
			MIR-POL-ID-BASE -> MIR-MSG-PARM-INFO-1-T[1];
		}
	}
	LSIR-RETURN-CD = HLD-LSIR-RETURN-CD;			
	HLD-LSIR-RETURN-CD = "";			

#J03240 End

	TARGET3083:

	STEP AppAnalysis2
	{
		USES S-STEP "AppAnalysisSecur";
		STRINGTABLE.IDS_TITLE_AppAnalysis -> Title;
		"ButtonBarOK" -> ButtonBar;
	}


#	IF action == "ACTION_NEXT"
#	{
#
#		STEP PutInForce
#		{
#			USES PROCESS "BF1354Issue";
#			ATTRIBUTES
#			{
#				GetMessages = "NO";
#			}
#
#		}
#
#	}
#
#
#	IF action == "ACTION_NEXT"
#	{
#		EXIT;
#
#	}
#
}
