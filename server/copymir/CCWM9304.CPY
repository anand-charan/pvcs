000010*****************************************************************
000020**  MEMBER :  CCWM9304                                         **
000030**  REMARKS:  MESSAGE INTERFACE FOR CSOM9304                   **
000040*****************************************************************
000050**  RELEASE   AUTEUR  DESCRIPTION                              **
000060**                                                             **
SE-301**  04SEP2013 JPA     CRÉATION                                 **
000080*****************************************************************
J03978**  16JUN2015 JPA     AJOUTER L'HEURE LIMITE.                  **
J06022**  07OCT2019 JFO     AJOUTER INDICATEUR POUR PROJECT MC18.    **
000110*****************************************************************

000130 01  MIR-PARM-AREA.
000140     05  MIR-CONTROL-AREA.
000150         10  MIR-BUS-FCN-ID                         PIC X(004).
000160         10  MIR-LENGTH                             PIC X(005).
000170         10  MIR-RETRN-CD                           PIC X(002).
000180             88  MIR-RETRN-OK                       VALUE '00'.
000190             88  MIR-RETRN-EDIT-ERROR               VALUE '01'.
000200             88  MIR-RETRN-RQST-FAILED              VALUE '02'.
000210             88  MIR-RETRN-TS-MISMATCH              VALUE '05'.
000220             88  MIR-RETRN-INVALD-RQST              VALUE '99'.
000230     05  MIR-INPUT-AREA.
000240         10  MIR-POL-ID.
000250             15  MIR-POL-ID-BASE                    PIC X(009).
000260             15  MIR-POL-ID-SFX                     PIC X(001).
000270         10  MIR-ACTV-TYP-CD                        PIC X(04).
000280         10  MIR-NXT-USER-ID                        PIC X(08).
000290         10  MIR-NXT-STEP-CD                        PIC X(01).
000300         10  MIR-SERV-CD                            PIC X(03).
000310         10  MIR-POL-BUS-CLAS-CD                    PIC X(01).
000320         10  FILLER                                 PIC X(01).
000330     05  MIR-IO-AREA.
000340         10  MIR-BROWSE-CTR                         PIC X(04).
000350         10  FILLER                                 PIC X(01).
000360     05  MIR-OUTPUT-AREA.
000370         10  MIR-ACTV-EFF-DT-G.
000380             15  MIR-ACTV-EFF-DT-T                  OCCURS 100
000390                                                    PIC X(10).
000400         10  MIR-PROC-LIMIT-DT-G.
000410             15  MIR-PROC-LIMIT-DT-T                OCCURS 100
000420                                                    PIC X(10).
J03978         10  MIR-PROC-LIMIT-TIME-G.
J03978             15  MIR-PROC-LIMIT-TIME-T              OCCURS 100
J03978                                                    PIC X(08).
J03978         10  MIR-POL-CNTCT-VIP-IND-G.
J03978             15  MIR-POL-CNTCT-VIP-IND-T            OCCURS 100
J03978                                                    PIC X(01).
000490         10  MIR-POL-ID-G.
000500             15  MIR-POL-ID-T                       OCCURS 100
000510                                                    PIC X(10).
000520         10  MIR-ACTV-TYP-CD-G.
000530             15  MIR-ACTV-TYP-CD-T                  OCCURS 100
000540                                                    PIC X(04).
000550         10  MIR-SECOND-ACTV-TYP-CD-G.
000560             15  MIR-SECOND-ACTV-TYP-CD-T           OCCURS 100
000570                                                    PIC X(04).
000580         10  MIR-SERV-CD-G.
000590             15  MIR-SERV-CD-T                      OCCURS 100
000600                                                    PIC X(03).
000610         10  MIR-COMM-CD-G.
000620             15  MIR-COMM-CD-T                      OCCURS 100
000630                                                    PIC X(03).
000640         10  MIR-PROC-USER-ID-G.
000650             15  MIR-PROC-USER-ID-T                 OCCURS 100
000660                                                    PIC X(08).
000670         10  MIR-POL-BUS-CLAS-CD-G.
000680             15  MIR-POL-BUS-CLAS-CD-T              OCCURS 100
000690                                                    PIC X(01).
000700         10  MIR-NXT-USER-ID-G.
000710             15  MIR-NXT-USER-ID-T                  OCCURS 100
000720                                                    PIC X(08).
000730         10  MIR-NXT-STEP-CD-G.
000740             15  MIR-NXT-STEP-CD-T                  OCCURS 100
000750                                                    PIC X(01).
000760         10  MIR-CONTEST-IND-G.
000770             15  MIR-CONTEST-IND-T                  OCCURS 100
000780                                                    PIC X(01).
J06022         10  MIR-LSSH-EXIST-IND-G.
J06022             15  MIR-LSSH-EXIST-IND-T               OCCURS 100
J06022                                                    PIC X(01).
000820         10  FILLER                                 PIC X(01).
000830*****************************************************************
000840**                END OF COPYBOOK CCWM9304                     **
000850*****************************************************************
