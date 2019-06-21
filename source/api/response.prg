*************************************************************
*
* overHere response processor class
*
*************************************************************

IF !SYS(16) $ SET("Procedure")
	SET PROCEDURE TO (SYS(16)) ADDITIVE
ENDIF

DEFINE CLASS oh_Response AS Custom

	_MemberData = '<VFPData>' + ;
						'<memberdata name="read" type="method" display="Read" />' + ;
						'<memberdata name="storevalue" type="method" display="StoreValue" />' + ;
						'</VFPData>'

	FUNCTION Read (Source AS MSXML2.IXMLDOMNode, Target AS oh_Structure) AS oh_Structure

		LOCAL Processor AS MSXML2.DOMDocument60
		LOCAL Members AS MSXML2.IXMLDOMNodeList
		LOCAL Member AS MSXML2.IXMLDOMNode
		LOCAL SourceElements AS MSXML2.IXMLDOMNodeList
		LOCAL SourceElement AS MSXML2.IXMLDOMNode
		LOCAL MemberName AS String
		LOCAL MemberType AS String
		LOCAL SourceElementName AS String
		LOCAL SourceValue AS String
		LOCAL SourceIsAttribute AS Logical
		LOCAL TargetIsCollection AS Logical
		LOCAL TargetKey AS String
		LOCAL TargetIsList AS Logical
		LOCAL TargetIsArray AS Logical
		LOCAL TargetItemNumber AS Integer
		LOCAL ArrayItem AS String
		LOCAL TargetName AS String

		IF ISNULL(m.Source) OR ISNULL(m.Target)
			RETURN .NULL.
		ENDIF

		m.Processor = CREATEOBJECT("MSXML2.DOMDocument.6.0")
		m.Processor.Async = .F.
		m.Processor.LoadXML('<ohStructure>' + m.Target.Members + m.Target.AdditionalMembers + '</ohStructure>')

		m.Members = m.Processor.selectNodes("//member")
		FOR EACH m.Member IN m.Members

			m.MemberName = m.Member.attributes.getNamedItem("name").text
			TRY
				m.SourceElementName = m.Member.attributes.getNamedItem("element").text
			CATCH
				m.SourceElementName = ""
			ENDTRY
			IF EMPTY(m.SourceElementName)
				m.SourceElementName = m.MemberName
			ENDIF
			m.MemberType = m.Member.attributes.getNamedItem("type").text
			m.MemberName = "m.Target." + m.MemberName

			STORE .F. TO m.TargetIsCollection, m.TargetIsList, m.TargetIsArray, m.SourceIsAttribute
			m.SourceKey = ""

			DO CASE
			CASE LEFT(m.MemberType, 11) == "collection:" OR LEFT(m.MemberType, 5) == "keys:"
				m.TargetIsCollection = .T.
				IF LEFT(m.MemberType, 1) == "k"
					m.SourceKey = m.Member.attributes.getNamedItem("key").text
				ENDIF
			CASE LEFT(m.MemberType, 5) == "list:"
				m.TargetIsList = .T.
			CASE LEFT(m.MemberType, 6) == "array:"
				m.TargetIsArray = .T.
			CASE LEFT(m.MemberType, 10) == "attribute:"
				m.SourceIsAttribute = .T.
			ENDCASE

			IF ":" $ m.MemberType
				m.MemberType = SUBSTR(m.MemberType, AT(":", m.MemberType) + 1)
			ENDIF

			DO CASE
			CASE m.TargetIsCollection OR m.TargetIsList OR m.TargetIsArray
				m.SourceElements = m.Source.selectNodes(m.SourceElementName)
			CASE m.SourceIsAttribute
				m.MemberType = SUBSTR(m.MemberType, AT(":", m.MemberType) + 1)
				m.SourceElements = m.Source.selectNodes("@" + m.SourceElementName)
			OTHERWISE
				m.SourceElements = m.Source.selectNodes(m.SourceElementName + "[1]")
			ENDCASE

			IF m.TargetIsArray
				DIMENSION &MemberName. (EVL(m.SourceElements.length, 1))
				m.TargetItemNumber = 1
			ENDIF

			FOR EACH m.SourceElement IN m.SourceElements

				IF m.TargetIsArray
					m.ArrayItem = TEXTMERGE("(<<INT(m.TargetItemNumber)>>)")
					m.TargetItemNumber = m.TargetItemNumber + 1
				ELSE
					m.ArrayItem = ""
				ENDIF

				This.StoreValue(m.SourceElement, m.Target, m.MemberName + m.ArrayItem, m.MemberType, m.TargetIsCollection, m.TargetIsArray, m.SourceKey)

			ENDFOR

		ENDFOR

		RETURN m.Target

	ENDFUNC

	PROTECTED PROCEDURE StoreValue (Source AS MSXML2.IXMLDOMNode, Target AS oh_Structure, TargetName AS String, Datatype AS Character, InCollection AS Logical, InArray AS Logical, KeySource AS String)

		LOCAL Value AS AnyType
		LOCAL TargetObject AS Object
		LOCAL TargetHasSetXML AS Logical
		LOCAL IsStructure AS Logical
		LOCAL TargetCollection AS Collection
		LOCAL KeyIndex AS String

		m.TargetObject = .NULL.
		m.IsStructure = .F.
		m.TargetHasSetXML = .F.
		m.KeyIndex = ""

		DO CASE
		CASE m.Datatype == "C"
			m.Value = m.Source.text

		CASE m.Datatype == "N"
			m.Value = VAL(CHRTRAN(m.Source.text, ".", SET("Point")))

		CASE m.Datatype == "I"
			m.Value = INT(VAL(m.Source.text))

		CASE m.Datatype == "L"
			m.Value = LOWER(m.Source.text) == "true"

		CASE m.Datatype == "D"
			TRY
				m.Value = EVALUATE("{^" + LEFT(m.Source.text, 10) + "}")
			CATCH
				m.Value = {}
			ENDTRY

		CASE m.Datatype == "T"
			TRY
				m.Value = EVALUATE("{^" + LEFT(CHRTRAN(m.Source.text, 'T', ' '), 19) + "}")
			CATCH
				m.Value = "{:}"
			ENDTRY

		OTHERWISE

			IF m.InCollection OR m.InArray
				m.TargetObject = CREATEOBJECT(m.Datatype)
			ELSE
				m.TargetObject = EVALUATE(m.TargetName)
			ENDIF

			m.IsStructure = m.TargetObject.OverHereClass == "structure"
			m.TargetHasSetXML = !m.IsStructure AND m.TargetObject._SetXML
			
		ENDCASE

		IF m.InCollection
			m.TargetCollection = EVALUATE(m.TargetName)
			IF !EMPTY(m.KeySource)
				TRY
					m.KeyIndex = m.Source.selectNodes(m.KeySource).item(0).text
				CATCH
					m.KeyIndex = ""
				ENDTRY
			ENDIF
		ENDIF

		IF ISNULL(m.TargetObject)

			IF !m.InCollection
				STORE m.Value TO (m.TargetName)
			ELSE
				IF EMPTY(m.KeyIndex)
					m.TargetCollection.Add(m.Value)
				ELSE
					m.TargetCollection.Add(m.Value, m.KeyIndex)
				ENDIF
			ENDIF

		ELSE

			IF !m.IsStructure

				IF m.TargetHasSetXML
					m.TargetObject.SetXML(m.Source)
				ELSE
					m.TargetObject.Parse(m.Source.text)
				ENDIF

			ELSE

				This.Read(m.Source, m.TargetObject)

			ENDIF

			IF m.InCollection
				IF EMPTY(m.KeyIndex)
					m.TargetCollection.Add(m.TargetObject)
				ELSE
					m.TargetCollection.Add(m.TargetObject, m.KeyIndex)
				ENDIF
			ENDIF

		ENDIF
	
	ENDPROC

ENDDEFINE

