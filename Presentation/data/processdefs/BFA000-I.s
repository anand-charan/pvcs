#<HEADER>
#<COPYRIGHT>
#© 2019 SSQ Insurance Company Inc.  ALL RIGHTS RESERVED
#</COPYRIGHT>
#<HISTORY>
#<COMMENT>
#Mandat MC18
#J06022 - 12JUL2019 - JFO - Update GDA vs Life SUite UnderWriting Decision - PROJECT MC18.
#</COMMENT>
#</HISTORY>
#</HEADER>
S-STEP BFA000-I
{
	ATTRIBUTES
	{
		FocusField = "MIR-LS-POL-ID";
		FocusFrame = "ContentFrame";
		Type = "Input";
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
	INOUT MIR-LS-POL-ID
	{
		DefaultSession = "MIR-POL-ID-BASE";
		Key;
		Label = "life Suite Policy Id";
		Length = "20";
		Mandatory;
		SType = "Text";
	#	MixedCase;
	}
	IN MIR-MSG-TXT
	{
		Label = "Current Policy Status";
		Length = "120";
		SType = "Text";
	}
}
