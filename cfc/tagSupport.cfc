<cfcomponent>
		<!--- This component is for unsupport cfscript tags ---->	
	
		<cffunction name="cfloginUser" returntype="void" access="public" hint="">    
    		<cfargument name="name" required="true" >    
			<cfargument name="password" required="true" >
			<cfargument name="roles" required="true" >
			
    		<cfloginUser name="#arguments.name#" password="#arguments.password#" roles="#arguments.roles#" >    
    
    		<cfreturn />    
    	</cffunction>



</cfcomponent>
