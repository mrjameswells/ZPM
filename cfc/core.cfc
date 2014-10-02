<cfcomponent>
	<!--- basic utility functions --->
		
		
		
	<cffunction name="isMethod" returntype="boolean" access="public" hint="">
		<cfargument name="cfc" required="true" >
		<cfargument name="method" required="true" >
		<cftry>
			<cfset cfcInfo = getComponentMetadata("#arguments.cfc#")>
			<cfcatch type="any"  >
				<cfreturn false>
			</cfcatch> 
		</cftry>
		<cfloop index="x" from="1" to="#arrayLen(cfcInfo.functions)#">
			<cfif cfcInfo.functions[x].name EQ arguments.method>
				<cfreturn true>
			</cfif>
		</cfloop>
		<cfreturn false>
		
	</cffunction>
	
			
</cfcomponent>