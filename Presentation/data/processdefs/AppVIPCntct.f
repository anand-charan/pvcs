#<HEADER>
#<COPYRIGHT>
#� 2008 INSURANCE SOFTWARE SOLUTIONS CORP.  ALL RIGHTS RESERVED
#</COPYRIGHT>
#</HEADER>
# *****************************************************************************
# Mandat Date      Auth. Description
# J03692 27Feb2014 JFO   New Process Flow qui indiqura si le dossier en cours
#                        saisie est consid�r� VIP selon certains crit�res de bases.
# J04609 06jAN2016 JFO   Augmenter le crit�re de s�lection VIP � 15000 pour la prime
#                        annuelle de base. Ajouter les produits Maladie Grave (MG) pour 
#                        la selection VIP dont le capital assur� doit �tre � 500000 et + 
#                        Pour les UL ne plus prendre le Sundry Amount comme calcul de s�lection mais
#                        plut�t la prime annuelle de base.
# J06040 27May2019 JFO   Pour les polices ULs reprendre le prime annuel de base comme calcul de 
#                        selection VIP plut�t que le Sundry Amount. 
# year 2023
# *****************************************************************************
PROCESS AppVIPCntct
{
	VARIABLES
	{
		# This input variables contains a policy number.
		IN MIR-POL-ID-BASE;
		IN MIR-POL-ID-SFX;
		# This output variable contains informations to be send at screen at the end of process.
		INOUT MIR-POL-CNTCT-VIP-IND;
		OUT wsVIPpolicyInd;
	}
	#---------------------------------- Working storage variables ------------------------------
	#
	#*******************************
	# Collect Based Contract Detail
	#******************************* 
	STEP ContractRetrieve
	{
		USES P-STEP "BF8000-P";
		ATTRIBUTES
		{
			GetMessages = "Merge";
		}
	}
	MIR-POL-CNTCT-VIP-IND = "N";
	wsVIPpolicyInd = "Y";
#	TRACE("MIR-POL-BUS-CLAS-CD =: " + MIR-POL-BUS-CLAS-CD);
#J04609	IF MIR-POL-BUS-CLAS-CD != "L" && MIR-POL-BUS-CLAS-CD != "U"
	IF MIR-POL-BUS-CLAS-CD != "L" && MIR-POL-BUS-CLAS-CD != "U" && MIR-POL-BUS-CLAS-CD != "G"
	{
		wsVIPpolicyInd = "N";
		EXIT;
	}
	#**************************************************
	# Collect all information for Coverage management. 
	#************************************************** 
	# .
	# .                ............     Apply Life SUite's guarantee rules     ..........
	# .
	# .
	# .

	# Initialize working storage variables
	reccounter = 1;
	ws-first-time = 0;
	GuarNum = 1;
	WHILE GuarNum <= 50
	{
#J04609 Begin
		axaCiCvgFaceAmt-T[GuarNum] = 0;
#J04609 End
		CvgFaceAmt-T[GuarNum] = 0;
		CvgInsrdId-T[GuarNum] = "";
		GuarNum = GuarNum + 1;
	}
	GuarNum = 1;

	# Loop all coverages on the policy and create an array according Life Suite's rules.

	WHILE reccounter <= NUMBER(MIR-POL-CVG-REC-CTR)
	{
		# Build the coverage number for INGENIUM. It needs to be a 2 character string.
		IF reccounter < 10
		{
			CvgNum = "0" + reccounter;
		}
		ELSE
		{
			CvgNum = reccounter;
		}
		MIR-CVG-NUM = CvgNum;

		# Use BF8020 Coverage Inquiry - All Details to retrieve information for this coverage.
		STEP TARGET8236
		{
			USES P-STEP "BF8020-P";
			PlanID <- MIR-PLAN-ID;
		}
		IF LSIR-RETURN-CD != "00" && LSIR-RETURN-CD != "03"
		{
			EXIT;
		}
		IF MIR-CVG-CONN-REASN-CD == "T" || MIR-CVG-CONN-REASN-CD == "D" || MIR-POL-DIVSN-DT != ""
		{
			wsVIPpolicyInd = "N";
			EXIT;
		}
		# Check if the Type of Insurance Code, it's not 'F', 'M', 'N'. We must use the insurance coverages only.
		IF MIR-CVG-INS-TYP-CD != "N" && MIR-CVG-INS-TYP-CD != "M" && MIR-CVG-INS-TYP-CD != "F"
		{
			# Get the associated guarantee Life Suite's code in PH table 
			STEP TARGET1010
			{
				USES P-STEP "BF1810-P";
				PlanID -> MIR-PLAN-ID;
			}
			#  For LIFE & LIFEPREF. If the sum of insurance >= 5000000 then its a VIP contract	
			#**********************************************************************************************
			#* 		---	Garantie Vie & Vie Pr�f�rentielle	---   	                       
			#**********************************************************************************************
			IF MIR-LS-UW-CAT-ID == "AXALIFEPRF" || MIR-LS-UW-CAT-ID == "AXALIFE"
			{
				#---------------------------------------------------------------------------------------------------
				# - La condition Suivante va cr�er la premi�re garantie LS  AXAVIE ou AXAPREF                          
				# - On passe � travers cette condition lors d'une premi�re lecture AXALIFE ou AXALIFEPRF
				#---------------------------------------------------------------------------------------------------
				IF ws-first-time == 0
				{
					index = 1;
					WHILE MIR-INSRD-CLI-ID-T[index] != ""
					{
						CvgInsrdId-T[GuarNum] = MIR-INSRD-CLI-ID-T[index];
						CvgFaceAmt-T[GuarNum] = CvgFaceAmt-T[GuarNum] + NUMBER(MIR-CVG-FACE-AMT);
						GuarNum = GuarNum + 1;
						index = index +1;
					}
					ws-first-time = 1;
				}
				#---------------------------------------------------------------------------------------------------
				# La condition ESLE permet le regroupement s'il y lieu des couvertures AVAVIE &	AXAPREF 
				# par assur� de chaque couverture.
				# - On passe � travers cette condition lors d'une 2ieme lecture ou plus de  AXALIFE ou AXALIFEPRF
				#----------------------------------------------------------------------------------------------------
				ELSE
				{
					index = 1;
					WHILE MIR-INSRD-CLI-ID-T[index] != ""
 					{
						InsrdFound = "N";
						CvgInsrdCtr = 1;
						WHILE CvgInsrdId-T[CvgInsrdCtr] != ""
						{
							IF CvgInsrdId-T[CvgInsrdCtr] == MIR-INSRD-CLI-ID-T[index]
							{
								CvgFaceAmt-T[CvgInsrdCtr] = CvgFaceAmt-T[CvgInsrdCtr] + NUMBER(MIR-CVG-FACE-AMT);
								InsrdFound = "Y";
							}
							CvgInsrdCtr = CvgInsrdCtr + 1;
						}
						IF InsrdFound == "N"
						{
							CvgInsrdId-T[GuarNum] = MIR-INSRD-CLI-ID-T[index];
							CvgFaceAmt-T[GuarNum] = CvgFaceAmt-T[GuarNum] + NUMBER(MIR-CVG-FACE-AMT);
							GuarNum = GuarNum + 1;
						}
						index = index +1;
					}
				}
			}
		}
#J04609  Begin - Add Critical Illness in selected VIP. If the sum of insurance >= 500000 then its a VIP contract
		#**********************************************************************************************
		#* 		---	Garantie Maladie Grave - AXACI	---    
		#**********************************************************************************************
		IF MIR-LS-UW-CAT-ID == "AXACI"  
		{
			index = 1;
			WHILE MIR-INSRD-CLI-ID-T[index] != ""
			{
				CvgInsrdCtr = 1;
				WHILE CvgInsrdId-T[CvgInsrdCtr] != ""
				{
					IF CvgInsrdId-T[CvgInsrdCtr] == MIR-INSRD-CLI-ID-T[index] 
					{
						axaCiCvgFaceAmt-T[CvgInsrdCtr] = axaCiCvgFaceAmt-T[CvgInsrdCtr] + NUMBER(MIR-CVG-FACE-AMT);
						BRANCH TARGET1016;
					}
					CvgInsrdCtr = CvgInsrdCtr + 1;
				}
				CvgInsrdId-T[GuarNum] = MIR-INSRD-CLI-ID-T[index];
				axaCiCvgFaceAmt-T[GuarNum] = NUMBER(MIR-CVG-FACE-AMT);
				GuarNum = GuarNum + 1;
				TARGET1016:
				index = index +1;
			}
		}
		reccounter = reccounter + 1;
	}	
	# ------------ Fin de la logique des r�gles sur les garanties -------
	WsPolSndryAmt = 0;
	GuarNum = 1;
	WHILE CvgInsrdId-T[GuarNum] != ""
	{
#J04609		IF NUMBER(CvgFaceAmt-T[GuarNum]) >= 5000000
TRACE( "CvgInsrdId-T + CvgFaceAmt-T + axaCiCvgFaceAmt-T =: " + CvgInsrdId-T[GuarNum] + ", " + CvgFaceAmt-T[GuarNum] + ", " + axaCiCvgFaceAmt-T[GuarNum]);
		IF NUMBER(CvgFaceAmt-T[GuarNum]) >= 5000000 || NUMBER(axaCiCvgFaceAmt-T[GuarNum]) >= 500000
		{
			MIR-POL-CNTCT-VIP-IND = "Y";
		}
		GuarNum = GuarNum + 1;
	}

#J04609 La logique suivante n'est plus n�cessaire	
#J06040 R�activer le code pour le calcul avec le Sundry Amount.
	IF MIR-POL-INS-TYP-CD == "C" || MIR-POL-INS-TYP-CD == "D" || MIR-CVG-INS-TYP-CD != "N"
	{
		IF MIR-POL-BILL-MODE-CD == "01"
		{
			WsPolSndryAmt = (NUMBER(MIR-POL-SNDRY-AMT) * 12);
		}
		IF MIR-POL-BILL-MODE-CD == "03"
		{
			WsPolSndryAmt = (NUMBER(MIR-POL-SNDRY-AMT) * 4);
		}
		IF MIR-POL-BILL-MODE-CD == "06"
	{
			WsPolSndryAmt = (NUMBER(MIR-POL-SNDRY-AMT) * 2);
		}
		IF MIR-POL-BILL-MODE-CD == "12"
		{
			WsPolSndryAmt = (NUMBER(MIR-POL-SNDRY-AMT) * 1);
		}

	}
#J04609 end of comments
#
#J04609 Increase the amount to 15000 to be VIP. For UL take the Annual Premium instead the Sundry Amount 
# 
#J04609	IF NUMBER(MIR-POL-GRS-APREM-AMT) >= 10000 || WsPolSndryAmt >= 10000
#J06040	IF NUMBER(MIR-POL-GRS-APREM-AMT) >= 15000
	IF NUMBER(MIR-POL-GRS-APREM-AMT) >= 15000 || WsPolSndryAmt >= 15000
	{
		MIR-POL-CNTCT-VIP-IND = "Y";
	}
	EXIT;
}


























	