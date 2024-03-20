#<HEADER>
#<COPYRIGHT>
#� 2001 INSURANCE SOFTWARE SOLUTIONS CORP.  ALL RIGHTS RESERVED
#</COPYRIGHT>
#<HISTORY>
#<RELEASE>
#6.0
#</RELEASE>
#<NUMBER>
#014590
#</NUMBER>
#<COMMENT>
#New for release 6.0
#</COMMENT>
#</HISTORY>
#</HEADER>
# Converted from PathFinder 2.2 to 3.0 Jan 20, 2004 1:42:34 PM EST
# Converted to Enterprise Designer 1.1 format on Oct 4, 2002 1:51:39 PM EDT
#****************************************************************************
# Mandat Date      Auth. Description
# J02547 24OCT2013 CRI	 Bottin unifi� - nouveaux champs
# J03329 14JUL2014 MTH   Ajouts champs pour Notification
# J04290 15May2015 JFO   Ajout de nouveaux champs pour CLIEDIS
# J05247 15Mar2017 Sart  Ajout de nouveaux champs pour Domaine securises
# J05986 05AVR2019 ROK   AJOUT D'UN NOUVEAU TYPE D'ADRESSE
#                        COURRIEL POUR L'ENVOIE AUTOMATIS� DE LA 
#                        PROPOSITION �LECTRONIQUE
# year 2023 
#*****************************************************************************
S-STEP BF0990-O
{
	ATTRIBUTES
	{
		DelEmptyRows;
		FocusField = "OKButton";
		FocusFrame = "ButtonFrame";
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
	IN MIR-BR-ID
	{
		CodeSource = "XTAB";
		CodeType = "BRCH";
		DisplayOnly;
		Key;
		Label = "Branch Number";
		Length = "5";
		SType = "Text";
	}
	IN MIR-CLI-ADDR-TYP-CD
	{
		CodeSource = "EDIT";
		CodeType = "ADTYP";
		DisplayOnly;
		Label = "Address Type";
		Length = "40";
		SType = "Text";
	}
	IN MIR-CLI-ID
	{
		DisplayOnly;
		Label = "Client Number";
		Length = "10";
		SType = "Text";
	}
	IN MIR-DV-CLI-NM
	{
		DisplayOnly;
		Label = "Client Name";
		Length = "75";
		SType = "Text";
	}
#J02547 - D�BUT
	IN MIR-BRCH-BUS-PHONE
	{
		DisplayOnly;
		Label = "Office Phone Number";
		Length = "50";
		SType = "Text";
	}
	IN MIR-BRCH-OTHER-PHONE
	{
		DisplayOnly;
		Label = "Other Phone Number";
		Length = "50";
		SType = "Text";
	}
	IN MIR-HIER-TYP-CD
	{
		CodeSource = "EDIT";
		CodeType = "HIERTYPE";
		DisplayOnly;
		Label = "Hierarchical type";
		Length = "40";
		SType = "Text";
	}
	IN MIR-WEB-SITE
	{
		DisplayOnly;
		Label = "Web Site";
		Length = "50";
		SType = "Text";
	}
	IN MIR-BRCH-TRMN-DT
	{
		DisplayOnly;
		Label = "Termination Date";
		Length = "10";
		SType = "Date";
	}
	IN MIR-BRCH-TRMN-REASN-CD
	{
		CodeSource = "EDIT";
		CodeType = "BRTERMRS";
		DisplayOnly;
		Label = "Termination Reason";
		Length = "40";
		SType = "Text";
	}	
	IN MIR-MAIN-BR-ID
	{
		CodeSource = "XTAB";
		CodeType = "BRCH";
		DisplayOnly;
		Label = "Main Branch ID";
		Length = "5";
		SType = "Text";
	}
	IN MIR-COMUN-TYP-CD
	{
		CodeSource = "EDIT";
		CodeType = "BRCHCOMUNTYP";
		DisplayOnly;
		Label = "Communication type";
		Length = "40";
		SType = "Text";
	}
	IN MIR-RW-LSUITE-AGT
	{
		CodeSource = "EDIT";
		CodeType = "RWLSAGT";
		DisplayOnly;
		Label = "RW LifeSuite Advisor";
		Length = "40";
		SType = "Text";
	}
# SADP-5247 Ajout des domaines s�curis�s
# Debut
	IN MIR-TOT-BON-PCT
	{
		Decimals = "2";
		FieldGroup = "Table3";
		Index = "1";
		Label = "Agency Total Share Percentage";
		Length = "5";
		SType = "Percent";
	}
# SADP-5247 Ajout des domaines s�curis�s
# Fin
	IN MIR-BRCH-NOTE
	{
		DisplayOnly;
		Label = "Branch Note";
		Length = "300";
		SType = "TextArea";
	}
#Codes extranet
	IN MIR-NET-ACCS-ID-1
	{
		DisplayOnly;
		Label = "Net Access ID 1";
		Length = "15";
		SType = "Text";
	}
	IN MIR-NET-ACCS-TYP-1
	{
		CodeSource = "EDIT";
		CodeType = "ACCESTYP";
		DisplayOnly;
		Label = "Net Access Type 1";
		Length = "40";
		SType = "Text";
	}
	IN MIR-NET-ACCS-ID-2
	{
		DisplayOnly;
		Label = "Net Access ID 2";
		Length = "15";
		SType = "Text";
	}
	IN MIR-NET-ACCS-TYP-2
	{
		CodeSource = "EDIT";
		CodeType = "ACCESTYP";
		DisplayOnly;
		Label = "Net Access Type 2";
		Length = "40";
		SType = "Text";
	}
	IN MIR-NET-ACCS-ID-3
	{
		DisplayOnly;
		Label = "Net Access ID 3";
		Length = "15";
		SType = "Text";
	}
	IN MIR-NET-ACCS-TYP-3
	{
		CodeSource = "EDIT";
		CodeType = "ACCESTYP";
		DisplayOnly;
		Label = "Net Access Type 3";
		Length = "40";
		SType = "Text";
	}
	IN MIR-NET-ACCS-ID-4
	{
		DisplayOnly;
		Label = "Net Access ID 4";
		Length = "15";
		SType = "Text";
	}
	IN MIR-NET-ACCS-TYP-4
	{
		CodeSource = "EDIT";
		CodeType = "ACCESTYP";
		DisplayOnly;
		Label = "Net Access Type 4";
		Length = "40";
		SType = "Text";
	}
	IN MIR-NET-ACCS-ID-5
	{
		DisplayOnly;
		Label = "Net Access ID 5";
		Length = "15";
		SType = "Text";
	}
	IN MIR-NET-ACCS-TYP-5
	{
		CodeSource = "EDIT";
		CodeType = "ACCESTYP";
		DisplayOnly;
		Label = "Net Access Type 5";
		Length = "40";
		SType = "Text";
	}
	IN MIR-NET-ACCS-ID-6
	{
		DisplayOnly;
		Label = "Net Access ID 6";
		Length = "15";
		SType = "Text";
	}
	IN MIR-NET-ACCS-TYP-6
	{
		CodeSource = "EDIT";
		CodeType = "ACCESTYP";
		DisplayOnly;
		Label = "Net Access Type 6";
		Length = "40";
		SType = "Text";
	}
	IN MIR-NET-ACCS-ID-7
	{
		DisplayOnly;
		Label = "Net Access ID 7";
		Length = "15";
		SType = "Text";
	}
	IN MIR-NET-ACCS-TYP-7
	{
		CodeSource = "EDIT";
		CodeType = "ACCESTYP";
		DisplayOnly;
		Label = "Net Access Type 7";
		Length = "40";
		SType = "Text";
	}
# SADP-5247 Ajout des domaines s�curis�s
# Debut
	IN MIR-NET-SECUR-DOM-1
	{
		DisplayOnly;
		Label = "Secured Web Site 1";
		Length = "40";
		SType = "Text";
	}
	IN MIR-NET-SECUR-DOM-2
	{
		DisplayOnly;
		Label = "Secured Web Site 2";
		Length = "40";
		SType = "Text";
	}
	IN MIR-NET-SECUR-DOM-3
	{
		DisplayOnly;
		Label = "Secured Web Site 3";
		Length = "40";
		SType = "Text";
	}
# SADP-5247 Ajout des domaines s�curis�s
# Fin
#Responsable principal de l'agence
	IN MIR-MAIN-CNTCT-GIV-NM
	{
		DisplayOnly;
		Label = "Main Contact First Name";
		Length = "25";
		SType = "Text";
	}
	IN MIR-MAIN-CNTCT-SUR-NM
	{
		DisplayOnly;
		Label = "Main Contact Last Name";
		Length = "25";
		SType = "Text";
	}
	IN MIR-MAIN-CNTCT-SEX-CD
	{
		CodeSource = "EDIT";
		CodeType = "BRCHSEX";
		DisplayOnly;
		Label = "Main Contact Sex Code";
		Length = "40";
		SType = "Text";
	}
	IN MIR-MAIN-CNTCT-LANG-CD
	{
		CodeSource = "EDIT";
		CodeType = "LANG";
		DisplayOnly;
		Label = "Main Contact Language Code";
		Length = "40";
		SType = "Text";
	}
	IN MIR-MAIN-CNTCT-EMAIL
	{
		DisplayOnly;
		Label = "Main Contact Email";
		Length = "50";
		SType = "Text";
	}
	IN MIR-MAIN-CNTCT-PHONE
	{
		DisplayOnly;
		Label = "Main Contact Phone Number";
		Length = "20";
		SType = "Text";
	}
#Responsable des op�rations/Coordonnateur
	IN MIR-OPER-CNTCT-GIV-NM
	{
		DisplayOnly;
		Label = "Operations/Coordinator Contact First Name";
		Length = "25";
		SType = "Text";
	}
	IN MIR-OPER-CNTCT-SUR-NM
	{
		DisplayOnly;
		Label = "Operations/Coordinator Contact Last Name";
		Length = "25";
		SType = "Text";
	}
	IN MIR-OPER-CNTCT-SEX-CD
	{
		CodeSource = "EDIT";
		CodeType = "BRCHSEX";
		DisplayOnly;
		Label = "Operations/Coordinator Contact Sex Code";
		Length = "40";
		SType = "Text";
	}
	IN MIR-OPER-CNTCT-LANG-CD
	{
		CodeSource = "EDIT";
		CodeType = "LANG";
		DisplayOnly;
		Label = "Operations/Coordinator Contact Language Code";
		Length = "40";
		SType = "Text";
	}
	IN MIR-OPER-CNTCT-EMAIL
	{
		DisplayOnly;
		Label = "Operations/Coordinator Contact Email";
		Length = "50";
		SType = "Text";
	}
	IN MIR-OPER-CNTCT-PHONE
	{
		DisplayOnly;
		Label = "Operations/Coordinator Contact Phone Number";
		Length = "20";
		SType = "Text";
	}
#Responsable mise sous contrat
	IN MIR-CNTRCT-CNTCT-GIV-NM 
	{
		DisplayOnly;
		Label = "Contracting Contact First Name";
		Length = "25";
		SType = "Text";
	}
	IN MIR-CNTRCT-CNTCT-SUR-NM 
	{
		DisplayOnly;
		Label = "Contracting Contact Last Name";
		Length = "25";
		SType = "Text";
	}
	IN MIR-CNTRCT-CNTCT-SEX-CD
	{
		CodeSource = "EDIT";
		CodeType = "BRCHSEX";
		DisplayOnly;
		Label = "Contracting Contact Sex Code";
		Length = "40";
		SType = "Text";
	}
	IN MIR-CNTRCT-CNTCT-LANG-CD
	{
		CodeSource = "EDIT";
		CodeType = "LANG";
		DisplayOnly;
		Label = "Contracting Contact Language Code";
		Length = "40";
		SType = "Text";
	}
	IN MIR-CNTRCT-CNTCT-EMAIL
	{
		DisplayOnly;
		Label = "Contracting Contact Email";
		Length = "50";
		SType = "Text";
	}
	IN MIR-CNTRCT-CNTCT-PHONE
	{
		DisplayOnly;
		Label = "Contracting Contact Phone Number";
		Length = "20";
		SType = "Text";
	}
#Responsable r�mun�ration
	IN MIR-CMPNST-CNTCT-GIV-NM 
	{
		DisplayOnly;
		Label = "Compensation Contact First Name";
		Length = "25";
		SType = "Text";
	}
	IN MIR-CMPNST-CNTCT-SUR-NM 
	{
		DisplayOnly;
		Label = "Compensation Contact Last Name";
		Length = "25";
		SType = "Text";
	}
	IN MIR-CMPNST-CNTCT-SEX-CD
	{
		CodeSource = "EDIT";
		CodeType = "BRCHSEX";
		DisplayOnly;
		Label = "Compensation Contact Sex Code";
		Length = "40";
		SType = "Text";
	}
	IN MIR-CMPNST-CNTCT-LANG-CD
	{
		CodeSource = "EDIT";
		CodeType = "LANG";
		DisplayOnly;
		Label = "Compensation Contact Language Code";
		Length = "40";
		SType = "Text";
	}
	IN MIR-CMPNST-CNTCT-EMAIL
	{
		DisplayOnly;
		Label = "Compensation Contact Email";
		Length = "50";
		SType = "Text";
	}
	IN MIR-CMPNST-CNTCT-PHONE
	{
		DisplayOnly;
		Label = "Compensation Contact Phone Number";
		Length = "20";
		SType = "Text";
	}
#Responsable des nouvelles affaires
	IN MIR-NB-CNTCT-GIV-NM 
	{
		DisplayOnly;
		Label = "New Business Contact First Name";
		Length = "25";
		SType = "Text";
	}
	IN MIR-NB-CNTCT-SUR-NM 
	{
		DisplayOnly;
		Label = "New Business Contact Last Name";
		Length = "25";
		SType = "Text";
	}
	IN MIR-NB-CNTCT-SEX-CD
	{
		CodeSource = "EDIT";
		CodeType = "BRCHSEX";
		DisplayOnly;
		Label = "New Business Contact Sex Code";
		Length = "40";
		SType = "Text";
	}
	IN MIR-NB-CNTCT-LANG-CD
	{
		CodeSource = "EDIT";
		CodeType = "LANG";
		DisplayOnly;
		Label = "New Business Contact Language Code";
		Length = "40";
		SType = "Text";
	}
	IN MIR-NB-CNTCT-EMAIL
	{
		DisplayOnly;
		Label = "New Business Contact Email";
		Length = "50";
		SType = "Text";
	}
	IN MIR-NB-CNTCT-PHONE
	{
		DisplayOnly;
		Label = "New Business Contact Phone Number";
		Length = "20";
		SType = "Text";
	}
#Responsable des de l'en vigueur
	IN MIR-INFORCE-CNTCT-GIV-NM 
	{
		DisplayOnly;
		Label = "Inforce Contact First Name";
		Length = "25";
		SType = "Text";
	}
	IN MIR-INFORCE-CNTCT-SUR-NM 
	{
		DisplayOnly;
		Label = "Inforce Contact Last Name";
		Length = "25";
		SType = "Text";
	}
	IN MIR-INFORCE-CNTCT-SEX-CD
	{
		CodeSource = "EDIT";
		CodeType = "BRCHSEX";
		DisplayOnly;
		Label = "Inforce Contact Sex Code";
		Length = "40";
		SType = "Text";
	}
	IN MIR-INFORCE-CNTCT-LANG-CD
	{
		CodeSource = "EDIT";
		CodeType = "LANG";
		DisplayOnly;
		Label = "Inforce Contact Language Code";
		Length = "40";
		SType = "Text";
	}
	IN MIR-INFORCE-CNTCT-EMAIL
	{
		DisplayOnly;
		Label = "Inforce Contact Email";
		Length = "50";
		SType = "Text";
	}
	IN MIR-INFORCE-CNTCT-PHONE
	{
		DisplayOnly;
		Label = "Inforce Contact Phone Number";
		Length = "20";
		SType = "Text";
	}
#Responsable des communications-marketing
	IN MIR-COMUN-MKT-CNTCT-GIV-NM 
	{
		DisplayOnly;
		Label = "Communication/Marketing Contact First Name";
		Length = "25";
		SType = "Text";
	}
	IN MIR-COMUN-MKT-CNTCT-SUR-NM 
	{
		DisplayOnly;
		Label = "Communication/Marketing Contact Last Name";
		Length = "25";
		SType = "Text";
	}
	IN MIR-COMUN-MKT-CNTCT-SEX-CD
	{
		CodeSource = "EDIT";
		CodeType = "BRCHSEX";
		DisplayOnly;
		Label = "Communication/Marketing Contact Sex Code";
		Length = "40";
		SType = "Text";
	}
	IN MIR-COMUN-MKT-CNTCT-LANG-CD
	{
		CodeSource = "EDIT";
		CodeType = "LANG";
		DisplayOnly;
		Label = "Communication/Marketing Contact Language Code";
		Length = "40";
		SType = "Text";
	}
	IN MIR-COMUN-MKT-CNTCT-EMAIL
	{
		DisplayOnly;
		Label = "Communication/Marketing Contact Email";
		Length = "50";
		SType = "Text";
	}
	IN MIR-COMUN-MKT-CNTCT-PHONE
	{
		DisplayOnly;
		Label = "Communication/Marketing Contact Phone Number";
		Length = "20";
		SType = "Text";
	}
#Divers (r�pondant 2)
	IN MIR-MISC-2-CNTCT-GIV-NM 
	{
		DisplayOnly;
		Label = "Respondent 2Contact First Name";
		Length = "25";
		SType = "Text";
	}
	IN MIR-MISC-2-CNTCT-SUR-NM 
	{
		DisplayOnly;
		Label = "Respondent 2 Contact Last Name";
		Length = "25";
		SType = "Text";
	}
	IN MIR-MISC-2-CNTCT-SEX-CD
	{
		CodeSource = "EDIT";
		CodeType = "BRCHSEX";
		DisplayOnly;
		Label = "Respondent 2 Contact Sex Code";
		Length = "40";
		SType = "Text";
	}
	IN MIR-MISC-2-CNTCT-LANG-CD
	{
		CodeSource = "EDIT";
		CodeType = "LANG";
		DisplayOnly;
		Label = "Respondent 2 Contact Language Code";
		Length = "40";
		SType = "Text";
	}
	IN MIR-MISC-2-CNTCT-EMAIL
	{
		DisplayOnly;
		Label = "Respondent 2 Contact Email";
		Length = "50";
		SType = "Text";
	}
	IN MIR-MISC-2-CNTCT-PHONE
	{
		DisplayOnly;
		Label = "Respondent 2 Contact Phone Number";
		Length = "20";
		SType = "Text";
	}
	IN MIR-MISC-2-CNTCT-NOTE
	{
		DisplayOnly;
		Label = "Respondent 2 Note";
		Length = "80";
		SType = "TextArea";
	}
#J03329 - Debut
	IN MIR-BRCH-NOTI-IND
	{
		DisplayOnly;
		Label = "Notified agency indicator";
		Length = "1";
		SType = "Indicator";
	}
	IN MIR-BRCH-NOTI-LANG-CD
	{
		CodeSource = "EDIT";
		CodeType = "LANG";
		DisplayOnly;
		Label = "Notification Language Code";
		Length = "40";
		SType = "Text";
	}
	IN MIR-BRCH-NOTI-EMAIL
	{
		DisplayOnly;
		Label = "Email Notified agency";
		Length = "50";
		SType = "Text";
	}
	IN MIR-DV-BRCH-NOTI-EMAIL
	{
		DisplayOnly;
		Label = "Email Notified agency display on screen";
		Length = "50";
		SType = "Text";
	}
#J03329 - Fin
#J02547 - FIN
#J04290 - Begin
	IN MIR-NOTI-TRNSMT-MAIN-BR-IND
	{
		DisplayOnly;
		Label = "File to be transmitted to the main agency";
		Length = "1";
		SType = "Indicator";
	}
	IN MIR-NOTI-TRNSMT-OTHR-BR-ID
	{
		CodeSource = "XTAB";
		CodeType = "BRCH";
		DisplayOnly;
		Label = "File to be transmitted to the other agency";
		Length = "5";
		SType = "Text";
	}
#------------------------------------- CLIEDIS Variables -----------------------------------------
	IN MIR-SUSP-FILE-TRNSMT-TYP-CD
	{
		CodeSource = "DataModel";
		DisplayOnly;
		CodeType = "FILE-TRNSMT-TYP-CD";
		Label = "File Type Transmitting";
		Length = "4";
		SType = "Text";
	}
	IN MIR-SUSP-TRNSMT-MAIN-BR-IND 
	{
		DisplayOnly;
		Label = "File to be transmitted to the main agency";
		Length = "1";
		SType = "Indicator";
	}
	IN MIR-SUSP-TRNSMT-OTHR-BR-ID
	{
		CodeSource = "XTAB";
		CodeType = "BRCH";
		DisplayOnly;
		Label = "File to be transmitted to the other agency";
		Length = "5";
		SType = "Text";
	}
	IN MIR-EAPP-FILE-TRNSMT-TYP-CD
	{
		CodeSource = "DataModel";
		CodeType = "FILE-TRNSMT-TYP-CD";
		DisplayOnly;
		Label = "File Type Transmitting";
		Length = "4";
		SType = "Text";
	}
	IN MIR-EAPP-TRNSMT-MAIN-BR-IND 
	{
		DisplayOnly;
		Label = "File to be transmitted to the main agency";
		Length = "1";
		SType = "Indicator";
	}
	IN MIR-EAPP-TRNSMT-OTHR-BR-ID
	{
		CodeSource = "XTAB";
		CodeType = "BRCH";
		DisplayOnly;
		Label = "File to be transmitted to the other agency";
		Length = "5";
		SType = "Text";
	}
#J05986 - Debut
	IN MIR-EAPP-CNTCT-EMAIL
	{
		DisplayOnly;
		Label = "eApp Contact Email";
		Length = "50";
		SType = "Text";
	}
#J05986 - Fin
	IN MIR-INFC-FILE-TRNSMT-TYP-CD
	{
		CodeSource = "DataModel";
		CodeType = "FILE-TRNSMT-TYP-CD";
		DisplayOnly;
		Label = "File Type Transmitting";
		Length = "4";
		SType = "Text";
	}
	IN MIR-INFC-TRNSMT-MAIN-BR-IND 
	{
		DisplayOnly;
		Label = "File to be transmitted to the main agency";
		Length = "1";
		SType = "Indicator";
	}
	IN MIR-INFC-TRNSMT-OTHR-BR-ID
	{
		CodeSource = "XTAB";
		CodeType = "BRCH";
		DisplayOnly;
		Label = "File to be transmitted to the other agency";
		Length = "5";
		SType = "Text";
	}
	IN MIR-COMM-FILE-TRNSMT-TYP-CD
	{
		CodeSource = "DataModel";
		CodeType = "FILE-TRNSMT-TYP-CD";
		DisplayOnly;
		Label = "File Type Transmitting";
		Length = "4";
		SType = "Text";
	}
	IN MIR-COMM-TRNSMT-MAIN-BR-IND 
	{
		DisplayOnly;
		Label = "File to be transmitted to the main agency";
		Length = "1";
		SType = "Indicator";
	}
	IN MIR-COMM-TRNSMT-OTHR-BR-ID
	{
		CodeSource = "XTAB";
		CodeType = "BRCH";
		DisplayOnly;
		Label = "File to be transmitted to the other agency";
		Length = "5";
		SType = "Text";
	}
	IN MIR-PROD-FILE-TRNSMT-TYP-CD
	{
		CodeSource = "DataModel";
		CodeType = "FILE-TRNSMT-TYP-CD";
		DisplayOnly;
		Label = "File Type Transmitting";
		Length = "4";
		SType = "Text";
	}
	IN MIR-PROD-TRNSMT-MAIN-BR-IND 
	{
		DisplayOnly;
		Label = "File to be transmitted to the main agency";
		Length = "1";
		SType = "Indicator";
	}
	IN MIR-PROD-TRNSMT-OTHR-BR-ID
	{
		CodeSource = "XTAB";
		CodeType = "BRCH";
		DisplayOnly;
		Label = "File to be transmitted to the other agency";
		Length = "5";
		SType = "Text";
	}
#J04290 - Ended
# ----------------------------------- End of CLIEDIS Variables --------------------------------------
}
