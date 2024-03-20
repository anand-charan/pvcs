#<HEADER>
#<DESCRIPTION>
#Branch Detail Retrieve
#</DESCRIPTION>
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
#<HISTORY>
#<RELEASE>
#6.6
#</RELEASE>
#<NUMBER>
#026697
#</NUMBER>
#<COMMENT>
#Removal of un-used attribute in P-step (DBTableName)
#</COMMENT>
#</HISTORY>
#</HEADER>
# Converted from PathFinder 2.2 to 3.0 Jan 20, 2004 1:42:52 PM EST
# Converted to Enterprise Designer 1.1 format on Oct 4, 2002 1:51:39 PM EDT
# year 2023
#****************************************************************************
# Mandat Date      Auth. Description
# J02547 24OCT2013 CRI	 Bottin unifi� - nouveaux champs
# J03329 14JUL2014 MTH   Ajouts champs pour Notification
# J04290 15May2015 JFO   Ajout de nouveaux champs pour CLIEDIS
# J05247 15Mar2017 Sart  Ajout de nouveaux champs pour Domaine securises
# J05986 05AVR2019 ROK   AJOUT D'UN NOUVEAU TYPE D'ADRESSE
#                        COURRIEL POUR L'ENVOIE AUTOMATIS� DE LA 
#                        PROPOSITION �LECTRONIQUE 
#*****************************************************************************
P-STEP BF0990-P
{
	ATTRIBUTES
	{
		BusinessFunctionId = "0990";
		BusinessFunctionType = "Retrieve";
		MirName = "CCWM5030";
	}
	OUT LSIR-RETURN-CD;
	OUT MIR-RETRN-CD;
	IN MIR-BR-ID
	{
		CodeSource = "XTAB";
		CodeType = "BRCH";
		Key;
		Label = "Branch Number";
		Length = "5";
		Mandatory;
		SType = "Selection";
	}
	OUT MIR-CLI-ADDR-TYP-CD
	{
		CodeSource = "EDIT";
		CodeType = "ADTYP";
		Label = "Address Type";
		Length = "40";
		SType = "Text";
	}
	OUT MIR-CLI-ID
	{
		Label = "Client Number";
		Length = "10";
		SType = "Text";
	}
	OUT MIR-DV-CLI-NM
	{
		Label = "Client Name";
		Length = "75";
		SType = "Text";
	}
#J02547 - D�BUT
	OUT MIR-BRCH-BUS-PHONE
	{
		Label = "Office Phone Number";
		Length = "50";
		SType = "Text";
	}
	OUT MIR-BRCH-OTHER-PHONE
	{
		Label = "Other Phone Number";
		Length = "50";
		SType = "Text";
	}
	OUT MIR-HIER-TYP-CD
	{
		CodeSource = "EDIT";
		CodeType = "HIERTYPE";
		Label = "Hierarchical type";
		Length = "40";
		SType = "Text";
	}
	OUT MIR-WEB-SITE
	{
		Label = "Web Site";
		Length = "50";
		SType = "Text";
	}
	OUT MIR-BRCH-TRMN-DT
	{
		Label = "Termination Date";
		Length = "10";
		SType = "Date";
	}
	OUT MIR-BRCH-TRMN-REASN-CD
	{
		CodeSource = "EDIT";
		CodeType = "BRTERMRS";
		Label = "Termination Reason";
		Length = "40";
		SType = "Text";
	}	
	OUT MIR-MAIN-BR-ID
	{
		CodeSource = "XTAB";
		CodeType = "BRCH";
		Label = "Main Branch ID";
		Length = "5";
		SType = "Text";
	}
	OUT MIR-COMUN-TYP-CD
	{
		CodeSource = "EDIT";
		CodeType = "BRCHCOMUNTYP";
		Label = "Communication type";
		Length = "40";
		SType = "Text";
	}
	OUT MIR-RW-LSUITE-AGT
	{
		CodeSource = "EDIT";
		CodeType = "RWLSAGT";
		Label = "RW LifeSuite Advisor";
		Length = "40";
		SType = "Text";
	}
# SADP-5247 Ajout des domaines s�curis�s
# Debut
	OUT MIR-TOT-BON-PCT
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
	OUT MIR-BRCH-NOTE
	{
		Label = "Branch Note";
		Length = "300";
		SType = "TextArea";
	}
#Codes extranet
	OUT MIR-NET-ACCS-ID-1
	{
		Label = "Net Access ID 1";
		Length = "15";
		SType = "Text";
	}
	OUT MIR-NET-ACCS-TYP-1
	{
		CodeSource = "EDIT";
		CodeType = "ACCESTYP";
		Label = "Net Access Type 1";
		Length = "40";
		SType = "Text";
	}
	OUT MIR-NET-ACCS-ID-2
	{
		Label = "Net Access ID 2";
		Length = "15";
		SType = "Text";
	}
	OUT MIR-NET-ACCS-TYP-2
	{
		CodeSource = "EDIT";
		CodeType = "ACCESTYP";
		Label = "Net Access Type 2";
		Length = "40";
		SType = "Text";
	}
	OUT MIR-NET-ACCS-ID-3
	{
		Label = "Net Access ID 3";
		Length = "15";
		SType = "Text";
	}
	OUT MIR-NET-ACCS-TYP-3
	{
		CodeSource = "EDIT";
		CodeType = "ACCESTYP";
		Label = "Net Access Type 3";
		Length = "40";
		SType = "Text";
	}
	OUT MIR-NET-ACCS-ID-4
	{
		Label = "Net Access ID 4";
		Length = "15";
		SType = "Text";
	}
	OUT MIR-NET-ACCS-TYP-4
	{
		CodeSource = "EDIT";
		CodeType = "ACCESTYP";
		Label = "Net Access Type 4";
		Length = "40";
		SType = "Text";
	}
	OUT MIR-NET-ACCS-ID-5
	{
		Label = "Net Access ID 5";
		Length = "15";
		SType = "Text";
	}
	OUT MIR-NET-ACCS-TYP-5
	{
		CodeSource = "EDIT";
		CodeType = "ACCESTYP";
		Label = "Net Access Type 5";
		Length = "40";
		SType = "Text";
	}
	OUT MIR-NET-ACCS-ID-6
	{
		Label = "Net Access ID 6";
		Length = "15";
		SType = "Text";
	}
	OUT MIR-NET-ACCS-TYP-6
	{
		CodeSource = "EDIT";
		CodeType = "ACCESTYP";
		Label = "Net Access Type 6";
		Length = "40";
		SType = "Text";
	}
	OUT MIR-NET-ACCS-ID-7
	{
		Label = "Net Access ID 7";
		Length = "15";
		SType = "Text";
	}
	OUT MIR-NET-ACCS-TYP-7
	{
		CodeSource = "EDIT";
		CodeType = "ACCESTYP";
		Label = "Net Access Type 7";
		Length = "40";
		SType = "Text";
	}
# SADP-5247 Ajout des domaines s�curis�s
# Debut
	OUT MIR-NET-SECUR-DOM-1
	{
		Label = "Secured Web Site 1";
		Length = "40";
		SType = "Text";
		MixedCase;
	}	
	OUT MIR-NET-SECUR-DOM-2
	{
		Label = "Secured Web Site 2";
		Length = "40";
		SType = "Text";
		MixedCase;
	}	
	OUT MIR-NET-SECUR-DOM-3
	{
		Label = "Secured Web Site 3";
		Length = "40";
		SType = "Text";
		MixedCase;
	}		
# SADP-5247 Ajout des domaines s�curis�s
# Fin
#Responsable principal de l'agence
	OUT MIR-MAIN-CNTCT-GIV-NM
	{
		Label = "Main Contact First Name";
		Length = "25";
		SType = "Text";
	}
	OUT MIR-MAIN-CNTCT-SUR-NM
	{
		Label = "Main Contact Last Name";
		Length = "25";
		SType = "Text";
	}
	OUT MIR-MAIN-CNTCT-SEX-CD
	{
		CodeSource = "EDIT";
		CodeType = "BRCHSEX";
		Label = "Main Contact Sex Code";
		Length = "40";
		SType = "Text";
	}
	OUT MIR-MAIN-CNTCT-LANG-CD
	{
		CodeSource = "EDIT";
		CodeType = "LANG";
		Label = "Main Contact Language Code";
		Length = "40";
		SType = "Text";
	}
	OUT MIR-MAIN-CNTCT-EMAIL
	{
		Label = "Main Contact Email";
		Length = "50";
		SType = "Text";
	}
	OUT MIR-MAIN-CNTCT-PHONE
	{
		Label = "Main Contact Phone Number";
		Length = "20";
		SType = "Text";
	}
#Responsable des op�rations/Coordonnateur
	OUT MIR-OPER-CNTCT-GIV-NM
	{
		Label = "Operations/Coordinator Contact First Name";
		Length = "25";
		SType = "Text";
	}
	OUT MIR-OPER-CNTCT-SUR-NM
	{
		Label = "Operations/Coordinator Contact Last Name";
		Length = "25";
		SType = "Text";
	}
	OUT MIR-OPER-CNTCT-SEX-CD
	{
		CodeSource = "EDIT";
		CodeType = "BRCHSEX";
		Label = "Operations/Coordinator Contact Sex Code";
		Length = "40";
		SType = "Text";
	}
	OUT MIR-OPER-CNTCT-LANG-CD
	{
		CodeSource = "EDIT";
		CodeType = "LANG";
		Label = "Operations/Coordinator Contact Language Code";
		Length = "40";
		SType = "Text";
	}
	OUT MIR-OPER-CNTCT-EMAIL
	{
		Label = "Operations/Coordinator Contact Email";
		Length = "50";
		SType = "Text";
	}
	OUT MIR-OPER-CNTCT-PHONE
	{
		Label = "Operations/Coordinator Contact Phone Number";
		Length = "20";
		SType = "Text";
	}
#Responsable mise sous contrat
	OUT MIR-CNTRCT-CNTCT-GIV-NM 
	{
		Label = "Contracting Contact First Name";
		Length = "25";
		SType = "Text";
	}
	OUT MIR-CNTRCT-CNTCT-SUR-NM 
	{
		Label = "Contracting Contact Last Name";
		Length = "25";
		SType = "Text";
	}
	OUT MIR-CNTRCT-CNTCT-SEX-CD
	{
		CodeSource = "EDIT";
		CodeType = "BRCHSEX";
		Label = "Contracting Contact Sex Code";
		Length = "40";
		SType = "Text";
	}
	OUT MIR-CNTRCT-CNTCT-LANG-CD
	{
		CodeSource = "EDIT";
		CodeType = "LANG";
		Label = "Contracting Contact Language Code";
		Length = "40";
		SType = "Text";
	}
	OUT MIR-CNTRCT-CNTCT-EMAIL
	{
		Label = "Contracting Contact Email";
		Length = "50";
		SType = "Text";
	}
	OUT MIR-CNTRCT-CNTCT-PHONE
	{
		Label = "Contracting Contact Phone Number";
		Length = "20";
		SType = "Text";
	}
#Responsable r�mun�ration
	OUT MIR-CMPNST-CNTCT-GIV-NM 
	{
		Label = "Compensation Contact First Name";
		Length = "25";
		SType = "Text";
	}
	OUT MIR-CMPNST-CNTCT-SUR-NM 
	{
		Label = "Compensation Contact Last Name";
		Length = "25";
		SType = "Text";
	}
	OUT MIR-CMPNST-CNTCT-SEX-CD
	{
		CodeSource = "EDIT";
		CodeType = "BRCHSEX";
		Label = "Compensation Contact Sex Code";
		Length = "40";
		SType = "Text";
	}
	OUT MIR-CMPNST-CNTCT-LANG-CD
	{
		CodeSource = "EDIT";
		CodeType = "LANG";
		Label = "Compensation Contact Language Code";
		Length = "40";
		SType = "Text";
	}
	OUT MIR-CMPNST-CNTCT-EMAIL
	{
		Label = "Compensation Contact Email";
		Length = "50";
		SType = "Text";
	}
	OUT MIR-CMPNST-CNTCT-PHONE
	{
		Label = "Compensation Contact Phone Number";
		Length = "20";
		SType = "Text";
	}
#Responsable des nouvelles affaires
	OUT MIR-NB-CNTCT-GIV-NM 
	{
		Label = "New Business Contact First Name";
		Length = "25";
		SType = "Text";
	}
	OUT MIR-NB-CNTCT-SUR-NM 
	{
		Label = "New Business Contact Last Name";
		Length = "25";
		SType = "Text";
	}
	OUT MIR-NB-CNTCT-SEX-CD
	{
		CodeSource = "EDIT";
		CodeType = "BRCHSEX";
		Label = "New Business Contact Sex Code";
		Length = "40";
		SType = "Text";
	}
	OUT MIR-NB-CNTCT-LANG-CD
	{
		CodeSource = "EDIT";
		CodeType = "LANG";
		Label = "New Business Contact Language Code";
		Length = "40";
		SType = "Text";
	}
	OUT MIR-NB-CNTCT-EMAIL
	{
		Label = "New Business Contact Email";
		Length = "50";
		SType = "Text";
	}
	OUT MIR-NB-CNTCT-PHONE
	{
		Label = "New Business Contact Phone Number";
		Length = "20";
		SType = "Text";
	}
#Responsable des de l'en vigueur
	OUT MIR-INFORCE-CNTCT-GIV-NM 
	{
		Label = "Inforce Contact First Name";
		Length = "25";
		SType = "Text";
	}
	OUT MIR-INFORCE-CNTCT-SUR-NM 
	{
		Label = "Inforce Contact Last Name";
		Length = "25";
		SType = "Text";
	}
	OUT MIR-INFORCE-CNTCT-SEX-CD
	{
		CodeSource = "EDIT";
		CodeType = "BRCHSEX";
		Label = "Inforce Contact Sex Code";
		Length = "40";
		SType = "Text";
	}
	OUT MIR-INFORCE-CNTCT-LANG-CD
	{
		CodeSource = "EDIT";
		CodeType = "LANG";
		Label = "Inforce Contact Language Code";
		Length = "40";
		SType = "Text";
	}
	OUT MIR-INFORCE-CNTCT-EMAIL
	{
		Label = "Inforce Contact Email";
		Length = "50";
		SType = "Text";
	}
	OUT MIR-INFORCE-CNTCT-PHONE
	{
		Label = "Inforce Contact Phone Number";
		Length = "20";
		SType = "Text";
	}
#Responsable des communications-marketing
	OUT MIR-COMUN-MKT-CNTCT-GIV-NM 
	{
		Label = "Communication/Marketing Contact First Name";
		Length = "25";
		SType = "Text";
	}
	OUT MIR-COMUN-MKT-CNTCT-SUR-NM 
	{
		Label = "Communication/Marketing Contact Last Name";
		Length = "25";
		SType = "Text";
	}
	OUT MIR-COMUN-MKT-CNTCT-SEX-CD
	{
		CodeSource = "EDIT";
		CodeType = "BRCHSEX";
		Label = "Communication/Marketing Contact Sex Code";
		Length = "40";
		SType = "Text";
	}
	OUT MIR-COMUN-MKT-CNTCT-LANG-CD
	{
		CodeSource = "EDIT";
		CodeType = "LANG";
		Label = "Communication/Marketing Contact Language Code";
		Length = "40";
		SType = "Text";
	}
	OUT MIR-COMUN-MKT-CNTCT-EMAIL
	{
		Label = "Communication/Marketing Contact Email";
		Length = "50";
		SType = "Text";
	}
	OUT MIR-COMUN-MKT-CNTCT-PHONE
	{
		Label = "Communication/Marketing Contact Phone Number";
		Length = "20";
		SType = "Text";
	}
#Divers (r�pondant 2)
	OUT MIR-MISC-2-CNTCT-GIV-NM 
	{
		Label = "Respondent 2Contact First Name";
		Length = "25";
		SType = "Text";
	}
	OUT MIR-MISC-2-CNTCT-SUR-NM 
	{
		Label = "Respondent 2 Contact Last Name";
		Length = "25";
		SType = "Text";
	}
	OUT MIR-MISC-2-CNTCT-SEX-CD
	{
		CodeSource = "EDIT";
		CodeType = "BRCHSEX";
		Label = "Respondent 2 Contact Sex Code";
		Length = "40";
		SType = "Text";
	}
	OUT MIR-MISC-2-CNTCT-LANG-CD
	{
		CodeSource = "EDIT";
		CodeType = "LANG";
		Label = "Respondent 2 Contact Language Code";
		Length = "40";
		SType = "Text";
	}
	OUT MIR-MISC-2-CNTCT-EMAIL
	{
		Label = "Respondent 2 Contact Email";
		Length = "50";
		SType = "Text";
	}
	OUT MIR-MISC-2-CNTCT-PHONE
	{
		Label = "Respondent 2 Contact Phone Number";
		Length = "20";
		SType = "Text";
	}
	OUT MIR-MISC-2-CNTCT-NOTE
	{
		Label = "Respondent 2 Note";
		Length = "80";
		SType = "TextArea";
	}
#J03329 - Debut
	OUT MIR-BRCH-NOTI-IND
	{
		Label = "Notified agency indicator";
		Length = "1";
		SType = "Indicator";
	}
	OUT MIR-BRCH-NOTI-LANG-CD
	{
		CodeSource = "EDIT";
		CodeType = "LANG";
		Label = "Notification Language Code";
		Length = "40";
		SType = "Text";
	}
	OUT MIR-BRCH-NOTI-EMAIL
	{
		Label = "Email Notified agency";
		Length = "50";
		SType = "Text";
	}
	OUT MIR-DV-BRCH-NOTI-EMAIL
	{
  	        Label = "Email Notified agency display on screen";
		Length = "50";
		SType = "Text";
	}
#J03329 - Fin
#J02547 - FIN
#J04290 - Begin
	OUT MIR-NOTI-TRNSMT-MAIN-BR-IND
	{
		Label = "File to be transmitted to the main agency";
		Length = "1";
		SType = "Indicator";
	}
	OUT MIR-NOTI-TRNSMT-OTHR-BR-ID
	{
		CodeSource = "XTAB";
		CodeType = "BRCH";
		Label = "File to be transmitted to the other agency";
		Length = "5";
		SType = "Text";
	}
#------------------------------------- CLIEDIS Variables -----------------------------------------
	OUT MIR-SUSP-FILE-TRNSMT-TYP-CD
	{
		CodeSource = "DataModel";
		CodeType = "FILE-TRNSMT-TYP-CD";
		Label = "File Type Transmitting";
		Length = "4";
		SType = "Text";
	}
	OUT MIR-SUSP-TRNSMT-MAIN-BR-IND 
	{
		Label = "File to be transmitted to the main agency";
		Length = "1";
		SType = "Indicator";
	}
	OUT MIR-SUSP-TRNSMT-OTHR-BR-ID
	{
		CodeSource = "XTAB";
		CodeType = "BRCH";
		Label = "File to be transmitted to the other agency";
		Length = "5";
		SType = "Text";
	}
	OUT MIR-EAPP-FILE-TRNSMT-TYP-CD
	{
		CodeSource = "DataModel";
		CodeType = "FILE-TRNSMT-TYP-CD";
		Label = "File Type Transmitting";
		Length = "4";
		SType = "Text";
	}
	OUT MIR-EAPP-TRNSMT-MAIN-BR-IND 
	{
		Label = "File to be transmitted to the main agency";
		Length = "1";
		SType = "Indicator";
	}
	OUT MIR-EAPP-TRNSMT-OTHR-BR-ID
	{
		CodeSource = "XTAB";
		CodeType = "BRCH";
		Label = "File to be transmitted to the other agency";
		Length = "5";
		SType = "Text";
	}
#J05986 - Debut
	OUT MIR-EAPP-CNTCT-EMAIL
	{
		Label = "eApp Contact Email";
		Length = "50";
		SType = "Text";
	}
#J05986 - Fin
	OUT MIR-INFC-FILE-TRNSMT-TYP-CD
	{
		CodeSource = "DataModel";
		CodeType = "FILE-TRNSMT-TYP-CD";
		Label = "File Type Transmitting";
		Length = "4";
		SType = "Text";
	}
	OUT MIR-INFC-TRNSMT-MAIN-BR-IND 
	{
		Label = "File to be transmitted to the main agency";
		Length = "1";
		SType = "Indicator";
	}
	OUT MIR-INFC-TRNSMT-OTHR-BR-ID
	{
		CodeSource = "XTAB";
		CodeType = "BRCH";
		Label = "File to be transmitted to the other agency";
		Length = "5";
		SType = "Text";
	}
	OUT MIR-COMM-FILE-TRNSMT-TYP-CD
	{
		CodeSource = "DataModel";
		CodeType = "FILE-TRNSMT-TYP-CD";
		Label = "File Type Transmitting";
		Length = "4";
		SType = "Text";
	}
	OUT MIR-COMM-TRNSMT-MAIN-BR-IND 
	{
		Label = "File to be transmitted to the main agency";
		Length = "1";
		SType = "Indicator";
	}
	OUT MIR-COMM-TRNSMT-OTHR-BR-ID
	{
		CodeSource = "XTAB";
		CodeType = "BRCH";
		Label = "File to be transmitted to the other agency";
		Length = "5";
		SType = "Text";
	}
	OUT MIR-PROD-FILE-TRNSMT-TYP-CD
	{
		CodeSource = "DataModel";
		CodeType = "FILE-TRNSMT-TYP-CD";
		Label = "File Type Transmitting";
		Length = "4";
		SType = "Text";
	}
	OUT MIR-PROD-TRNSMT-MAIN-BR-IND 
	{
		Label = "File to be transmitted to the main agency";
		Length = "1";
		SType = "Indicator";
	}
	OUT MIR-PROD-TRNSMT-OTHR-BR-ID
	{
		CodeSource = "XTAB";
		CodeType = "BRCH";
		Label = "File to be transmitted to the other agency";
		Length = "5";
		SType = "Text";
	}
#J04290 - Ended
# ----------------------------------- End of CLIEDIS Variables --------------------------------------
}
