000010*****************************************************************
000020**  MEMBER :  CCWMA300                                         **
000030**  REMARKS:  MESSAGE INTERFACE FOR CSOMA300                   **
000040*****************************************************************
000050**  RELEASE   AUTEUR  DESCRIPTION                              **
000060**                                                             **
J06022**  12JUL2019 JPO     CRÉATION PROJECT MC18                    **
000080*****************************************************************
000090 01  MIR-PARM-AREA.
000100     05  MIR-CONTROL-AREA.
000110         10  MIR-BUS-FCN-ID                         PIC X(004).
000120         10  MIR-LENGTH                             PIC X(005).
000130         10  MIR-RETRN-CD                           PIC X(002).
000140             88  MIR-RETRN-OK                       VALUE '00'.
000150             88  MIR-RETRN-EDIT-ERROR               VALUE '01'.
000160             88  MIR-RETRN-RQST-FAILED              VALUE '02'.
000170             88  MIR-RETRN-TS-MISMATCH              VALUE '05'.
000180             88  MIR-RETRN-INVALD-RQST              VALUE '99'.
000190     05  MIR-INPUT-AREA.
000200         10  FILLER                                 PIC X(001).
000210     05  MIR-IO-AREA.
000220         10  MIR-LS-POL-ID.
000230             15  MIR-POL-ID-BASE                    PIC X(010).
000240             15  MIR-POL-ID-SFX                     PIC X(010).
000250         10  MIR-LSSH-EFF-DT                        PIC X(010).
000260         10  MIR-LSSH-SEQ-NUM                       PIC X(003).
000270         10  FILLER                                 PIC X(001).
000280     05  MIR-OUTPUT-AREA.
000290         10  MIR-MSG-TXT                            PIC X(120).
000300         10  MIR-MSG-REF-INFO                       PIC X(010).
000310         10  MIR-OUTPUT-LIST-AREA.
000320             15  MIR-LS-POL-ID-G.
000330                 20 MIR-LS-POL-ID-T                 OCCURS 50.
000340                    25 MIR-LS-POL-ID-BASE-T         PIC X(010).
000350                    25 MIR-LS-POL-ID-SFX-T          PIC X(010).
000360             15  MIR-LSSH-EFF-DT-G.
000370                 20  MIR-LSSH-EFF-DT-T              OCCURS 50
000380                                                    PIC X(010).
000390             15  MIR-PREV-UPDT-TS-TIME-G.
000400                 20  MIR-PREV-UPDT-TS-TIME-T        OCCURS 50
000410                                                    PIC X(008).
000420             15  MIR-LSSH-SEQ-NUM-G.
000430                 20  MIR-LSSH-SEQ-NUM-T             OCCURS 50
000440                                                    PIC X(003).
000450             15  MIR-LSSH-ACTV-TYP-ID-G.
000460                 20  MIR-LSSH-ACTV-TYP-ID-T         OCCURS 50
000470                                                    PIC X(005).
000480             15  MIR-MSG-TXT-G.
000490                 20  MIR-MSG-TXT-T                  OCCURS 50
000500                                                    PIC X(120).
000510         10  FILLER                                 PIC X(001).
000520*****************************************************************
000530**                END OF COPYBOOK CCWMA300                     **
000540*****************************************************************
