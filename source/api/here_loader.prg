*************************************************************
*
* overHere general loader of all classes
*
*************************************************************

LOCAL oh_Path AS String
LOCAL oh_Group AS String

m.oh_Path = ADDBS(JUSTPATH(SYS(16)))

* manager class
DO (m.oh_Path + "here_api")

* datatypes classes
m.oh_Group = m.oh_Path + "..\datatypes\"
DO (m.oh_Group + "base")
DO (m.oh_Group + "maps")
DO (m.oh_Group + "route")
DO (m.oh_Group + "geocode")
DO (m.oh_Group + "fleet")

* maps resource classes
m.oh_Group = m.oh_Path + "maps\"
DO (m.oh_Group + "version")
DO (m.oh_Group + "maproute")
DO (m.oh_Group + "mapregion")
DO (m.oh_Group + "mapview")
DO (m.oh_Group + "statistics")

* geocoding resource classes
m.oh_Group = m.oh_Path + "geocoding\"
DO (m.oh_Group + "landmark")
DO (m.oh_Group + "reverse")
DO (m.oh_Group + "autocomplete")

* routing resource classes
m.oh_Group = m.oh_Path + "routing\"
DO (m.oh_Group + "calculate")
DO (m.oh_Group + "findsequence")

* util classes
m.oh_Group = m.oh_Path + "util\"
DO (m.oh_Group + "kml")

