*
* Namer
*
* A class to control the translation of a string into a syntactically correct name of a particular domain
* (for instance, the name of VFP variables or fields, of XML elements, of Windows file names, ...).
*
* The transformation is actually performed by a name processor (see NameProcessor class, below), that
* is attached to the Namer controller (that, in turn, provides some standard utilities to ease the coding of the processors).
*
* Usage example (see "test namer.prg" for other examples):
*
* m.Controller = CREATEOBJECT("Namer")
* m.Controller.AttachProcessor("XMLNamer")
* m.Controller.SetOriginalName("#xml element name")
* m.XMLElementName = m.Controller.GetName("XMLNamer")
* ? m.XMLElementName   && displays __xml_element_name
*
* Name processors are programmed independently, and may be included in a VFP project as needed.
*
* See *-names.prg for a set of ready-made name processors
*

* install itself
IF !SYS(16) $ SET("Procedure")
	SET PROCEDURE TO (SYS(16)) ADDITIVE
ENDIF

#DEFINE SAFETHIS			ASSERT !USED("This") AND TYPE("This") == "O"

DEFINE CLASS Namer AS Custom

	_memberdata = '<VFPData>' + ;
						'<memberdata name="setoriginalname" type="method" display="SetOriginalName"/>' + ;
						'<memberdata name="getoriginalname" type="method" display="GetOriginalName"/>' + ;
						'<memberdata name="attachprocessor" type="method" display="AttachProcessor"/>' + ;
						'<memberdata name="getname" type="method" display="GetName"/>' + ;
						'<memberdata name="setproperty" type="method" display="SetProperty"/>' + ;
						'<memberdata name="getproperty" type="method" display="GetProperty"/>' + ;
						'</VFPData>'

	ADD OBJECT PROTECTED NameProcessors AS Collection

	HIDDEN Original
	HIDDEN IsDBCS

	Original = .NULL.			&& the name that is processed by name processors
	IsDBCS = .F.				&& in the form of a DBCS string?

	* Init
	* If given as parameter, set the original name on initialization
	FUNCTION Init
	LPARAMETERS OriginalName AS String, ;
		IsDBCS AS Boolean
	
		IF PCOUNT() != 0
			This.SetOriginalName(m.OriginalName, m.IsDBCS)
		ENDIF
	
	ENDFUNC

	* SetOriginalName
	* Set the name that is going to be processed by name processors
	* A boolean flag may indicate that the name is a DBCS string
	FUNCTION SetOriginalName
	LPARAMETERS OriginalName AS String, ;
		IsDBCS AS Boolean

		ASSERT VARTYPE(m.OriginalName) $ "CX" ;
			MESSAGE "Original name must be a string."

		ASSERT VARTYPE(m.IsDBCS) == "L" ;
			MESSAGE "A logical parameter should be used to indicate if original name is a DBCS string."

		This.Original = m.OriginalName
		This.IsDBCS = m.IsDBCS

	ENDFUNC
	
	* GetOriginalName
	* Return the current original name
	FUNCTION GetOriginalName
	
		RETURN This.Original
	
	ENDFUNC

	* AttachProcessor
	* Processors are responsible for translating the original name into a syntactally acceptable name of a particular domain
	* Processors should be derived from the NameProcessor class
	* Their class definition should be in scope, if their library is not explicitly given during the attachment
	* Return != 0 if the processor was attached (either by this call or by a previous one)
	FUNCTION AttachProcessor
	LPARAMETERS ProcessorClass AS String, ;
		ProcessorLibrary AS String

		SAFETHIS

		LOCAL ProcessorKey AS String

		ASSERT VARTYPE(m.ProcessorClass) == "C" ;
			MESSAGE "Class of the processor to attach must be a string."
		ASSERT PCOUNT() = 1 OR (VARTYPE(m.ProcessorLibrary) == "C" AND FILE(m.ProcessorLibrary)) ;
			MESSAGE "Processor library not found or not properly identified."

		TRY
			* the processor key will identify the processor hereafter
			m.ProcessorKey = UPPER(m.ProcessorClass)
			IF PCOUNT() = 2
				* if a library was given, create a object from it and store the object at the processors collection
				This.NameProcessors.Add(NEWOBJECT(m.ProcessorClass, m.ProcessorLibrary, .NULL., This), m.ProcessorKey)
			ELSE
				* otherwise, the class must be in scope
				This.NameProcessors.Add(CREATEOBJECT(m.ProcessorClass, This), m.ProcessorKey)
			ENDIF
			* in any case, a reference to the Namer object is passed, so that its methods and properties can be accessed
			* from the instantiated processor
		CATCH
		ENDTRY

		* if the processor was attached, return > 0 (that may used as a identifier), or 0 if an error occurred
		RETURN This.NameProcessors.GetKey(m.ProcessorKey)
	
	ENDFUNC

	* GetName
	* Returns a translated name, acceptable under a particular domain (.NULL. when no translation could be performed)
	FUNCTION GetName
	LPARAMETERS ProcessorIdentifier, ;
		NoDefaultChars AS Boolean

		LOCAL Identifier AS StringOrNumber

		ASSERT PCOUNT() = 0 OR VARTYPE(m.ProcessorIdentifier) $ "CN" ;
			MESSAGE "Process identifier must be a string or a numeric index."

		IF PCOUNT() > 0
			m.Identifier = IIF(VARTYPE(m.ProcessorIdentifier) == "C",UPPER(m.ProcessorIdentifier),m.ProcessorIdentifier)
		ELSE
			m.Identifier = 1
		ENDIF

		* actually calls the method of the identified processor to get a translated name
		IF EMPTY(This.NameProcessors.GetKey(m.Identifier))
			RETURN .NULL.
		ELSE
			RETURN This.NameProcessors(m.Identifier).GetName(m.NoDefaultChars)
		ENDIF

	ENDFUNC

	* SetProperty
	* Set a property known to the specified processor
	* Processor properties are used to control particular aspects of how the processor operate.
	FUNCTION SetProperty
	LPARAMETERS ProcessorIdentifier, ;
		Property AS String, ;
		Setting

		LOCAL Identifier AS StringOrNumber

		ASSERT VARTYPE(m.ProcessorIdentifier) $ "CN" ;
			MESSAGE "Process identifier must be a string or a numeric index."
		ASSERT VARTYPE(m.ProcessorIdentifier) == "C" ;
			MESSAGE "Property name must be a string."

		m.Identifier = IIF(VARTYPE(m.ProcessorIdentifier) == "C",UPPER(m.ProcessorIdentifier),m.ProcessorIdentifier)

		* actually, calls the method of the processor that handles properties
		IF !EMPTY(This.NameProcessors.GetKey(m.Identifier))
			This.NameProcessors(m.Identifier).SetProperty(m.Property, m.Setting)
		ENDIF

	ENDFUNC

	* GetProperty
	* Returns the current setting of a processor property
	FUNCTION GetProperty
	LPARAMETERS ProcessorIdentifier, ;
		Property AS String
	
		LOCAL Identifier AS StringOrNumber

		ASSERT VARTYPE(m.ProcessorIdentifier) $ "CN" ;
			MESSAGE "Process identifier must be a string or a numeric index."
		ASSERT VARTYPE(m.ProcessorIdentifier) == "C" ;
			MESSAGE "Property name must be a string."

		m.Identifier = IIF(VARTYPE(m.ProcessorIdentifier) == "C",UPPER(m.ProcessorIdentifier),m.ProcessorIdentifier)

		* actually, calls the method of the processor that handles properties
		IF !EMPTY(This.NameProcessors.GetKey(m.Identifier))
			RETURN This.NameProcessors(m.Identifier).GetProperty(m.Property)
		ELSE
			RETURN .NULL.
		ENDIF

	ENDFUNC

	* GetANSIName
	* To be called by the processors: standard way to produce a safe translated ANSI name (see _GetName for details)
	FUNCTION GetANSIName
	LPARAMETERS FirstChars AS String, ;
		OtherChars AS String, ;
		MaxLen AS Integer, ;
		DefaultFirstChar AS Character, ;
		DefaultChar AS Character

		RETURN This._GetName(.F., m.FirstChars, m.OtherChars, m.MaxLen, m.DefaultFirstChar, m.DefaultChar)

	ENDFUNC

	* GetDBCSName
	* To be called by the processors: standard way to produce a safe translated DBCS name (see _GetName for details)
	FUNCTION GetDBCSName
	LPARAMETERS FirstChars AS String, ;
		OtherChars AS String, ;
		MaxLen AS Integer, ;
		DefaultFirstChar AS Character, ;
		DefaultChar AS Character
	
		RETURN This._GetName(.T., m.FirstChars, m.OtherChars, m.MaxLen, m.DefaultFirstChar, m.DefaultChar)
	ENDFUNC
	
	* _GetName
	* A standard method to get a safe name, given:
	*		ToDBCS - indicating if the output is an ANSI string (.F.) or a DBCS string (.T.)
	* 		FirstChars - the set of characters that may occur at the beginning of a name
	*		OtherChars - the set of characters that may occur in the rest of the name
	*		MaxLen - the max length of the name (0 if no limit set)
	*		DefaultFirstChar - what must be used as a default character, if the first one in the original name is not allowed
	*					(empty if inserting a default character shouldn'd be attempted)
	*		DefaultChar - what must be used as a default character in the rest of the name
	*					(empty if no default character should replace an invalid one)
	HIDDEN FUNCTION _GetName
	LPARAMETERS ToDBCS AS Boolean, ;
		FirstChars AS String, ;
		OtherChars AS String, ;
		MaxLen AS Integer, ;
		DefaultFirstChar AS Character, ;
		DefaultChar AS Character

		SAFETHIS

		LOCAL GetName AS String			&& the running result
		LOCAL CheckIndex AS Integer	&& an index to access the name characters
		LOCAL DefChar AS Character
		LOCAL NotAllowed AS String

		m.GetName = This.Original
		* operate only on a non-NULL original name (NULL original name results in a NULL translated name)
		IF !ISNULL(m.GetName)

			* make sure the translated name is encoded to the target string form (ANSI or DBCS)
			DO CASE
			CASE This.IsDBCS AND !m.ToDBCS
				m.GetName = STRCONV(m.GetName, 2)
			CASE !This.IsDBCS AND m.ToDBCS
				m.GetName = STRCONV(m.GetName, 1)
			ENDCASE

			* if FirstChars are set, the rule for initial character apply
			IF !EMPTY(m.FirstChars)

				* test if the first character of the original name is allowed
				IF !LEFTC(m.GetName,1) $ m.FirstChars

					* if not, and a default first character was designated, insert it at the beginning of the translated name
					m.DefChar = LEFTC(m.DefaultFirstChar, 1)
					IF !EMPTY(m.DefChar)
						m.GetName = m.DefChar + m.GetName
					ELSE
						* if a default character was not designated, remove all leading invalid characters
						DO WHILE LENC(m.GetName) > 0 AND !LEFTC(m.GetName, 1) $ m.FirstChars
							m.GetName = SUBSTRC(m.GetName, 2)
						ENDDO
					ENDIF

				ENDIF

				* start to check the rest of the name at the (now) second character
				m.CheckIndex = 2

			ELSE

				* no rule for first character, so start to check on beginning of the name
				m.CheckIndex = 1

			ENDIF

			* select the characters from the name that are not allowed
			m.NotAllowed = CHRTRANC(SUBSTRC(m.GetName, m.CheckIndex), m.OtherChars, "")
			m.DefChar = LEFTC(m.DefaultChar, 1)
			IF !EMPTY(m.DefChar)
				* if there is a default char, the not allowed chars will be replaced, otherwise removed
				m.DefChar = REPLICATE(m.DefChar, LENC(m.NotAllowed))
			ENDIF
			* perform the removal or replacement of disallowed characters from the source name
			m.GetName = LEFTC(m.GetName, m.CheckIndex - 1) + CHRTRANC(SUBSTRC(m.GetName, m.CheckIndex), m.NotAllowed, m.DefChar)

			* we're done, so make sure that the translated name has a valid size (if one was given)
			IF m.MaxLen > 0
				m.GetName = LEFTC(m.GetName, m.MaxLen)
			ENDIF

		ENDIF

		* empty translated names will be returned as NULL
		m.GetName = EVL(NVL(m.GetName, ""), .NULL.)

		RETURN m.GetName

	ENDFUNC

	* CodePointRange
	* An utility method to create a string of allowed characters defined by two endpoints
	* To be called by the processors
	FUNCTION CodePointRange
	LPARAMETERS Start AS Character, ;
		Finish AS Character
		
		LOCAL LoopIndex AS Integer
		LOCAL CodePointRange AS String
		
		m.CodePointRange = ""
		FOR m.LoopIndex = ASC(m.Start) TO ASC(m.Finish)
			m.CodePointRange = m.CodePointRange + CHR(m.LoopIndex)
		ENDFOR
		
		RETURN m.CodePointRange
	ENDFUNC

ENDDEFINE

*
* NameProcessor
*
* The source class for name processors
*
* Sub-classes should set their particular initialization after setting the namer host controller (passed as a parameter)
* and redesign the GetName method, that performs the actual translation.
*
* Particular settings required by a processor may be accessed using SetProperty and GetProperty functions (which are
* called by the host controller).

DEFINE CLASS NameProcessor AS Custom

	ADD OBJECT PROTECTED Properties AS Collection

	Host = .NULL.

	FUNCTION Init
	LPARAMETERS Host AS Namer
	
		This.Host = m.Host
		
		RETURN .T.
	ENDFUNC

	FUNCTION GetName
	LPARAMETERS NoDefaultChars AS Boolean

		RETURN .NULL.

	ENDFUNC

	* SetProperty
	* Set a property required by a processor (no need to change, in principle)
	FUNCTION SetProperty
	LPARAMETERS Property AS String, ;
		Setting

		LOCAL PropertyKey AS String

		m.PropertyKey = UPPER(m.Property)

		IF !EMPTY(This.Properties.GetKey(m.PropertyKey))
			This.Properties.Remove(m.PropertyKey)
		ENDIF
		This.Properties.Add(m.Setting, m.PropertyKey)

	ENDFUNC
	
	* GetProperty
	* Get the current setting of a property
	FUNCTION GetProperty
	LPARAMETERS Property AS String
	
		RETURN This.Properties(UPPER(m.Property))
	
	ENDFUNC

ENDDEFINE
