000010*****************************************************************
000020**  MEMBER :  CCWM5030                                         **
000030**  REMARKS:  MESSAGE INTERFACE FOR CSOM5030                   **
000040**            BRANCH TABLE                                     **
000050*****************************************************************
000060**  RELEASE   DESCRIPTION                                      **
000070**                                                             **
000080**  5.6       CREATED MESSAGE INTERFACE FOR TPI                **
000090**  6.2       LOGICAL LOCKING                                  **
000100*****************************************************************
000110** Date      Auth. Description                                 **
000120**                                                             **
J02547** 22OCT2013 CRI   BOTTIN UNIFIÉ - NOUVEAUX CHAMPS             **
J03329** 08JUL2014 MTH   AJOUTER NOUVEAUX CHAMPS POUR NOTIFICATION   **
J04290** 15MAY2015 JFO   AJOUTER NOUVEAUX CHAMPS POUR CLIEDIS        **
J05247** 15MAR2017 Sart  AJOUTER NOUVEAUX CHAMPS Domaine securises   **
J05986** 28MAR2019 ROK   AJOUT D'UN NOUVEAU TYPE D'ADRESSE           **
J05986**                 COURRIEL POUR L'ENVOIE AUTOMATISÉ DE LA     **
J05986**                 PROPOSITION ÉLECTRONIQUE                    **
000200*****************************************************************

000220 01  MIR-PARM-AREA.
000230     05  MIR-CONTROL-AREA.
000240         10  MIR-BUS-FCN-ID                         PIC X(004).
000250         10  MIR-LENGTH                             PIC X(005).
000260         10  MIR-RETRN-CD                           PIC X(002).
000270             88  MIR-RETRN-OK                       VALUE '00'.
000280             88  MIR-RETRN-EDIT-ERROR               VALUE '01'.
000290             88  MIR-RETRN-RQST-FAILED              VALUE '02'.
000300             88  MIR-RETRN-TS-MISMATCH              VALUE '05'.
000310             88  MIR-RETRN-INVALD-RQST              VALUE '99'.
000320     05  MIR-INPUT-AREA.
000330         10  FILLER                                 PIC X(01).
000340     05  MIR-IO-AREA.
000350         10  MIR-COMMON-FIELDS.
000360             15  MIR-BR-ID                          PIC X(05).
000370             15  MIR-DV-CLI-NM                      PIC X(75).
000380             15  MIR-CLI-ADDR-TYP-CD                PIC X(02).
000390             15  MIR-CLI-ID                         PIC X(10).
J02547             15  MIR-BRCH-BUS-PHONE                 PIC X(50).
J02547             15  MIR-BRCH-OTHER-PHONE               PIC X(50).
J02547             15  MIR-HIER-TYP-CD                    PIC X(04).
J02547             15  MIR-WEB-SITE                       PIC X(50).
J02547             15  MIR-BRCH-TRMN-DT                   PIC X(10).
J02547             15  MIR-BRCH-TRMN-REASN-CD             PIC X(01).
J02547             15  MIR-MAIN-BR-ID                     PIC X(05).
J02547             15  MIR-COMUN-TYP-CD                   PIC X(01).
J02547             15  MIR-RW-LSUITE-AGT                  PIC X(01).
J05247             15  MIR-TOT-BON-PCT                    PIC X(06).
J02547             15  MIR-BRCH-NOTE                      PIC X(300).
J02547             15  MIR-EXTRANET-INFO.                           
J02547                 20  MIR-NET-ACCS-ID-1              PIC X(15).
J02547                 20  MIR-NET-ACCS-TYP-1             PIC X(03).
J02547                 20  MIR-NET-ACCS-ID-2              PIC X(15).
J02547                 20  MIR-NET-ACCS-TYP-2             PIC X(03).
J02547                 20  MIR-NET-ACCS-ID-3              PIC X(15).
J02547                 20  MIR-NET-ACCS-TYP-3             PIC X(03).
J02547                 20  MIR-NET-ACCS-ID-4              PIC X(15).
J02547                 20  MIR-NET-ACCS-TYP-4             PIC X(03).
J02547                 20  MIR-NET-ACCS-ID-5              PIC X(15).
J02547                 20  MIR-NET-ACCS-TYP-5             PIC X(03).
J02547                 20  MIR-NET-ACCS-ID-6              PIC X(15).
J02547                 20  MIR-NET-ACCS-TYP-6             PIC X(03).
J02547                 20  MIR-NET-ACCS-ID-7              PIC X(15).
J02547                 20  MIR-NET-ACCS-TYP-7             PIC X(03).
J02547             15  MIR-EXTRANET-INFO-G                REDEFINES
J02547                 MIR-EXTRANET-INFO.
J02547                 20  MIR-NET-INFO-T              OCCURS 7 TIMES.
J02547                     25  MIR-NET-ACCS-ID            PIC X(15).
J02547                     25  MIR-NET-ACCS-TYP           PIC X(03).
J05247             15  MIR-NET-SECUR-DOM-1                PIC X(40).
J05247             15  MIR-NET-SECUR-DOM-2                PIC X(40).
J05247             15  MIR-NET-SECUR-DOM-3                PIC X(40).
J02547             15  MIR-CNTCT-INFO.
J02547                 20  MIR-MAIN-CNTCT-GIV-NM          PIC X(25).
J02547                 20  MIR-MAIN-CNTCT-SUR-NM          PIC X(25).
J02547                 20  MIR-MAIN-CNTCT-SEX-CD          PIC X(01).
J02547                 20  MIR-MAIN-CNTCT-LANG-CD         PIC X(01).
J02547                 20  MIR-MAIN-CNTCT-EMAIL           PIC X(50).
J02547                 20  MIR-MAIN-CNTCT-PHONE           PIC X(20).
J02547                 20  MIR-OPER-CNTCT-GIV-NM          PIC X(25).
J02547                 20  MIR-OPER-CNTCT-SUR-NM          PIC X(25).
J02547                 20  MIR-OPER-CNTCT-SEX-CD          PIC X(01).
J02547                 20  MIR-OPER-CNTCT-LANG-CD         PIC X(01).
J02547                 20  MIR-OPER-CNTCT-EMAIL           PIC X(50).
J02547                 20  MIR-OPER-CNTCT-PHONE           PIC X(20).
J02547                 20  MIR-CNTRCT-CNTCT-GIV-NM        PIC X(25).
J02547                 20  MIR-CNTRCT-CNTCT-SUR-NM        PIC X(25).
J02547                 20  MIR-CNTRCT-CNTCT-SEX-CD        PIC X(01).
J02547                 20  MIR-CNTRCT-CNTCT-LANG-CD       PIC X(01).
J02547                 20  MIR-CNTRCT-CNTCT-EMAIL         PIC X(50).
J02547                 20  MIR-CNTRCT-CNTCT-PHONE         PIC X(20).
J02547                 20  MIR-CMPNST-CNTCT-GIV-NM        PIC X(25).
J02547                 20  MIR-CMPNST-CNTCT-SUR-NM        PIC X(25).
J02547                 20  MIR-CMPNST-CNTCT-SEX-CD        PIC X(01).
J02547                 20  MIR-CMPNST-CNTCT-LANG-CD       PIC X(01).
J02547                 20  MIR-CMPNST-CNTCT-EMAIL         PIC X(50).
J02547                 20  MIR-CMPNST-CNTCT-PHONE         PIC X(20).
J02547                 20  MIR-NB-CNTCT-GIV-NM            PIC X(25).
J02547                 20  MIR-NB-CNTCT-SUR-NM            PIC X(25).
J02547                 20  MIR-NB-CNTCT-SEX-CD            PIC X(01).
J02547                 20  MIR-NB-CNTCT-LANG-CD           PIC X(01).
J02547                 20  MIR-NB-CNTCT-EMAIL             PIC X(50).
J02547                 20  MIR-NB-CNTCT-PHONE             PIC X(20).
J02547                 20  MIR-INFORCE-CNTCT-GIV-NM       PIC X(25).
J02547                 20  MIR-INFORCE-CNTCT-SUR-NM       PIC X(25).
J02547                 20  MIR-INFORCE-CNTCT-SEX-CD       PIC X(01).
J02547                 20  MIR-INFORCE-CNTCT-LANG-CD      PIC X(01).
J02547                 20  MIR-INFORCE-CNTCT-EMAIL        PIC X(50).
J02547                 20  MIR-INFORCE-CNTCT-PHONE        PIC X(20).
J02547                 20  MIR-COMUN-MKT-CNTCT-GIV-NM     PIC X(25).
J02547                 20  MIR-COMUN-MKT-CNTCT-SUR-NM     PIC X(25).
J02547                 20  MIR-COMUN-MKT-CNTCT-SEX-CD     PIC X(01).
J02547                 20  MIR-COMUN-MKT-CNTCT-LANG-CD    PIC X(01).
J02547                 20  MIR-COMUN-MKT-CNTCT-EMAIL      PIC X(50).
J02547                 20  MIR-COMUN-MKT-CNTCT-PHONE      PIC X(20).
J02547                 20  MIR-MISC-2-CNTCT-GIV-NM        PIC X(25).
J02547                 20  MIR-MISC-2-CNTCT-SUR-NM        PIC X(25).
J02547                 20  MIR-MISC-2-CNTCT-SEX-CD        PIC X(01).
J02547                 20  MIR-MISC-2-CNTCT-LANG-CD       PIC X(01).
J02547                 20  MIR-MISC-2-CNTCT-EMAIL         PIC X(50).
J02547                 20  MIR-MISC-2-CNTCT-PHONE         PIC X(20).
J02547             15  MIR-CNTCT-INFO-G                   REDEFINES
J02547                 MIR-CNTCT-INFO.
J02547                 20  MIR-CNTCT-INFO-T            OCCURS 8 TIMES.
J02547                     25  MIR-CNTCT-GIV-NM           PIC X(25).
J02547                     25  MIR-CNTCT-SUR-NM           PIC X(25).
J02547                     25  MIR-CNTCT-SEX-CD           PIC X(01).
J02547                     25  MIR-CNTCT-LANG-CD          PIC X(01).
J02547                     25  MIR-CNTCT-EMAIL            PIC X(50).
J02547                     25  MIR-CNTCT-PHONE            PIC X(20).
J02547             15  MIR-MISC-2-CNTCT-NOTE              PIC X(80).
J03329             15  MIR-BRCH-NOTI-INFO.                           
J03329                 20  MIR-BRCH-NOTI-IND              PIC X(01). 
J03329                 20  MIR-BRCH-NOTI-LANG-CD          PIC X(01). 
J03329                 20  MIR-BRCH-NOTI-EMAIL            PIC X(50). 
J03329                 20  MIR-DV-BRCH-NOTI-EMAIL         PIC X(50).
J04290                 20  MIR-NOTI-TRNSMT-MAIN-BR-IND    PIC X(01). 
J04290                 20  MIR-NOTI-TRNSMT-OTHR-BR-ID     PIC X(05). 
J04290             15  MIR-BR-CLIEDIS-INFO.                            
J04290                 20  MIR-SUSP-FILE-TRNSMT-TYP-CD    PIC X(04).   
J04290                     88  MIR-SUSP-FILE-TRNSMT-NONE  VALUE 'NONE'.
J04290                 20  MIR-SUSP-TRNSMT-MAIN-BR-IND    PIC X(01).   
J04290                 20  MIR-SUSP-TRNSMT-OTHR-BR-ID     PIC X(05).   
J04290                 20  MIR-EAPP-FILE-TRNSMT-TYP-CD    PIC X(04).   
J04290                     88  MIR-EAPP-FILE-TRNSMT-NONE  VALUE 'NONE'.
J04290                 20  MIR-EAPP-TRNSMT-MAIN-BR-IND    PIC X(01).   
J04290                 20  MIR-EAPP-TRNSMT-OTHR-BR-ID     PIC X(05).   
J04290                 20  MIR-INFC-FILE-TRNSMT-TYP-CD    PIC X(04).   
J04290                     88  MIR-INFC-FILE-TRNSMT-NONE  VALUE 'NONE'.
J04290                 20  MIR-INFC-TRNSMT-MAIN-BR-IND    PIC X(01).   
J04290                 20  MIR-INFC-TRNSMT-OTHR-BR-ID     PIC X(05).   
J04290                 20  MIR-COMM-FILE-TRNSMT-TYP-CD    PIC X(04).   
J04290                     88  MIR-COMM-FILE-TRNSMT-NONE  VALUE 'NONE'.
J04290                 20  MIR-COMM-TRNSMT-MAIN-BR-IND    PIC X(01).   
J04290                 20  MIR-COMM-TRNSMT-OTHR-BR-ID     PIC X(05).   
J04290                 20  MIR-PROD-FILE-TRNSMT-TYP-CD    PIC X(04).   
J04290                     88  MIR-PROD-FILE-TRNSMT-NONE  VALUE 'NONE'.
J04290                 20  MIR-PROD-TRNSMT-MAIN-BR-IND    PIC X(01).   
J04290                 20  MIR-PROD-TRNSMT-OTHR-BR-ID     PIC X(05).
J05986             15  MIR-EAPP-CNTCT-INFO.
J05986                 20  MIR-EAPP-CNTCT-EMAIL           PIC X(50).
001630         10  MIR-LIST-FIELDS.
001640             15  MIR-CLI-ADDR-TYP-CD-G.
001650                 20  MIR-CLI-ADDR-TYP-CD-T          OCCURS 12
001660                                                    PIC X(02).
001670             15  MIR-CLI-ID-G.
001680                 20  MIR-CLI-ID-T                   OCCURS 12
001690                                                    PIC X(10).
001700             15  MIR-BR-ID-G.
001710                 20  MIR-BR-ID-T                    OCCURS 12
001720                                                    PIC X(05).
J02547             15  MIR-BRCH-ID-G.                               
J02547                 20  MIR-BRCH-ID-T                  OCCURS 12 
J02547                                                    PIC X(05).
J02547             15  MIR-MAIN-BR-ID-G.                            
J02547                 20  MIR-MAIN-BR-ID-T               OCCURS 12 
J02547                                                    PIC X(05).
J02547             15  MIR-HIER-TYP-CD-G.                           
J02547                 20  MIR-HIER-TYP-CD-T              OCCURS 12 
J02547                                                    PIC X(04).
J02547             15  MIR-COMUN-TYP-CD-G.                          
J02547                 20  MIR-COMUN-TYP-CD-T             OCCURS 12 
J02547                                                    PIC X(01).
J02547             15  MIR-RW-LSUITE-AGT-G.                         
J02547                 20  MIR-RW-LSUITE-AGT-T            OCCURS 12 
J02547                                                    PIC X(01).

001890     05  MIR-OUTPUT-AREA.
001900         10  FILLER                                 PIC X(01).
001910*****************************************************************
001920**                END OF COPYBOOK CCWM5030                     **
001930*****************************************************************
