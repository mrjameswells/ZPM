component {
	public void function init(){
		//do nothing
		this.ZPMWebRootDir = '/zpm/';
		return;
	}	

	//public 
	// application.zpm.view.head('jquery,bootstrap,jqui,')
 
	public void function head(required string headList){
		var i = 0; 
		for(i=1; i LTE listLen(arguments.headList); i++){
			var scriptRequest = listGetAt(arguments.headList,i);
			application.zpm.tagSupport.cfhtmlhead(getScript('jq')) ;
			
		}
	}
	
	public string function getScript(required string scriptName){
		var htmlScript = '';
		
		switch(arguments.scriptName){
			case 'jquery': case 'jq':
			htmlScript='
			
			';
			break;
		}
		
		return htmlScript;
	}
	
	public string function page(required string template, string type='view'){
		param request.attributes = structNew();

		if(   left(arguments.template,6) EQ '/view/'    ){
			//abs not found, try /appdir then try /domaindir
			if(   fileExists(expandPath('/appDir' & arguments.template))   ){
				arguments.template = '/appDir' & arguments.template;
			}else if(   fileExists(expandPath('/domainDir' & arguments.template))   ){
				arguments.template = '/domainDir' & arguments.template;
			}else{
				writeOutput('Invalid view configuration: ' & arguments.template);
				abort;
			}
		}else if(   fileExists(expandPath(arguments.template))   ){
				arguments.template = arguments.template;
		}else if(   fileExists(expandPath('/appDir/view/' & arguments.template))   ){
					arguments.template = '/appDir/view/' & arguments.template;
		}else{
			writeOutput('Invalid view configuration: ' & arguments.template);
			abort;
		}
		

		
		
		var pageOut = '';
		savecontent variable="pageOut"{
			if(   fileExists(expandPath(arguments.template))   ){
				attributes = request.attributes;
				include arguments.template;
			}else{
				writeOutput('Invalid control configuration: ' & arguments.template);
				abort;
			}				
		}
		
		//writeOutput(request.output);
		return pageOut;
	}
}

 