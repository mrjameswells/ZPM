component {

	//default app settings
    this.sessionmanagement		= true;
	this.sessiontimeout 		= CreateTimeSpan(0,0,30,0);
	this.loginstorage			= "session";
	this.applicationTimeout 	= CreateTimeSpan(0,0,30,0);
	
	this.mappings = StructNew();
	this.mappings["/appDir"] =trim(left( cgi.cf_template_path,   len(cgi.cf_template_path) - len(getFileFromPath(cgi.cf_template_path))-1 )); 
	this.mappings["/domainDir"] = trim(left( cgi.cf_template_path,   len(cgi.cf_template_path) - len(cgi.script_name) ));
	this.mappings["/zpm"] = left( getCurrentTemplatePath(),   len(getCurrentTemplatePath()) - len(getfileFromPath(getCurrentTemplatePath())));

	
	
	param request.defaultControl='public.home';

	public void function onRequestStart(required string targetpage){
		
		//load cfcs
		application.zpm				= 	new zpm.cfc.core();
		application.zpm.tagSupport	= 	new zpm.cfc.tagSupport();
		application.zpm.view		= 	new zpm.cfc.view();

	}



	

	public void function onRequest(){
		param request.defaultControl = 'public.home';
		param name='url.c' type = 'string' default=request.defaultControl;
		param name='request.view' type='string' default='';

		request.method = listLast(url.c,'.');
		request.controller = "appDir.cfc." & left(url.c,len(url.c)-len(request.method)-1);

		if(isMethod(request.controller,request.method)){
			
			//onRequest
			if(isMethod(request.controller,"onControlStart")){
				invoke(request.controller,"onControlStart");
			}
			
			//request
			invoke(request.controller,request.method);
			
			//onRequestEnd
			if(isMethod(request.controller,"onControlStartEnd")){
				invoke(request.controller,"onControlStartEnd");
			}
			
			if(request.view NEQ ''){
				var pageContent = application.zpm.view.page(request.view);
				writeOutput(pageContent);
			}
			
		}else{
			// inlcude 404 page here 
			writeOutput("404 not found");
			abort;
		}
	}
	
	
	


	public boolean function  isMethod(required string cfc, required string method){
		var cfcInfo = getComponentMetadata("#arguments.cfc#");
		 for(func in cfcInfo.functions){
		 	 if(func.name EQ arguments.method){
		 	 	return true;  
		 	 }
		 }
		 return false;
	}
	
	
}