component{
	//common utilitiy functions accessible by application.zpm.functionName(...)
	
	public boolean function isMethod(required string cfc, required string method){
		try{
			var cfcInfo = getComponentMetadata("#arguments.cfc#");
			for(func in cfcInfo.functions){
				if(func.name EQ arguments.method){
			 		return true;  
			 	}
			}
			return false;
		}catch(any e){
			return false;
		}
	}


}