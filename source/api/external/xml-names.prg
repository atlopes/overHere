*
* XMLNamer
*
* Get a name that is syntactically acceptable for XML names (elements, attributes...).
* Do not accept names started with xml.
*
* Uses property AllowColon (default .F.), for admission of colons in names
*
DEFINE CLASS XMLNamer AS NameProcessor

	HIDDEN Alpha
	HIDDEN Digit
	
	FUNCTION Init
	LPARAMETERS Host AS Namer
	
		DODEFAULT(m.Host)

		This.Alpha = STRCONV(This.Host.CodePointRange("a", "z") + This.Host.CodePointRange("A", "Z") + "Åäéåöúü" + ;
			This.Host.CodePointRange("¿", "÷") + This.Host.CodePointRange("ÿ", "ˆ") + ;
			This.Host.CodePointRange("¯","ˇ"), 1)
		This.Digit = STRCONV(This.Host.CodePointRange("0", "9"), 1)
		This.SetProperty("AllowColon", .F.)
	
	ENDFUNC
	
	FUNCTION GetName
	LPARAMETERS NoDefaultChars AS Boolean
	
		LOCAL GetXMLName AS String
		LOCAL Colon AS String
		
		m.Colon = IIF(This.GetProperty("AllowColon"), ":", "")
		m.GetXMLName = This.Host.GetDBCSName(This.Alpha + STRCONV("_" + m.Colon, 1), ;
									This.Alpha + This.Digit + STRCONV("_-." + m.Colon, 1), ;
									0, ;
									IIF(m.NoDefaultChars, "", "_"), ;
									IIF(m.NoDefaultChars, "", "_"))
		
		IF UPPER(LEFTC(NVL(m.GetXMLName,""), 3)) == "XML"
			IF m.NoDefaultChars
				m.GetXMLName = EVL(SUBSTRC(m.GetXMLName, 4), .NULL.)
			ELSE
				m.GetXMLName = "_" + m.GetXMLName
			ENDIF
		ENDIF
		
		RETURN m.GetXMLName
	
	ENDFUNC

ENDDEFINE
