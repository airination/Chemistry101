<cfcomponent displayname="element" hint="This component contains the functions that handles the Flex data requirements" output="false">
	<cffunction name="getElementDetails" displayname="getElementDetails" hint="This function cfhttp's a page and scapes out the data for an element's details" access="remote" output="false" returntype="String">
		<cfargument name="elementatomicnumber" type="numeric" required="true">
			<cfhttp url="http://www.infoplease.com/periodictable.php?id=#arguments.elementatomicnumber#" method="GET" resolveurl="Yes"/>
			
			<cfscript>
				searchforstart = '<div class="ptinfo">';
				searchforend = '<br clear="all" />';
				charsbefore = #Find(searchforstart,  cfhttp.fileContent ,  1)#;
				tmpdisplaythis = #RemoveChars(cfhttp.fileContent, 1, (charsbefore-1))#;
				charsafter = #Find(searchforend,  tmpdisplaythis ,  1)#;
				tmpdisplaythis = #RemoveChars(tmpdisplaythis, charsafter, len(tmpdisplaythis) - len(charsafter))#;
				data = #REPLACE(tmpdisplaythis, "<br />", "<br>" , "All")#;
			</cfscript>
			
		<cfreturn cleanup(data)/>
	</cffunction>
	
	<cffunction name="cleanup">
		<cfargument name="string" type="string" required="true" />
		<cfset var outputString = arguments["string"]>
		<cfset outputString = reReplaceNoCase(outputString , "</*table>", "", "all")>
		<cfset outputString = reReplaceNoCase(outputString , "</*t[rhd](\s*\w*=*""*\w*""*)*>", "", "all")>
		<cfset outputString = reReplaceNoCase(outputString , "(?m)^\s*", "", "all")>
		<cfset outputString = reReplaceNoCase(outputString , "\n{2,}", "#chr(10)#", "all")>
		<cfreturn outputString />
	</cffunction>	
</cfcomponent>