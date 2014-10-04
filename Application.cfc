component {
/*
    Zero Point Module Framework
    v3.2.101
    
    Author:  James Wells  (mrjameswells@gmail.com)

*/


	//default app settings
    this.sessionmanagement		= true;
	this.sessiontimeout 		= CreateTimeSpan(0,0,30,0);
	this.loginstorage			= "session";
	this.applicationTimeout 	= CreateTimeSpan(0,0,30,0);

	
	this.mappings = StructNew();
	//Mapping to project folder
	this.mappings["/appDir"] =trim(left( cgi.cf_template_path,   len(cgi.cf_template_path) - len(getFileFromPath(cgi.cf_template_path))-1 ));
	//Mapping to domain root 
	this.mappings["/domainDir"] = trim(left( cgi.cf_template_path,   len(cgi.cf_template_path) - len(cgi.script_name) ));
	//Mapping to zpm framework
	this.mappings["/zpm"] = left( getCurrentTemplatePath(),   len(getCurrentTemplatePath()) - len(getfileFromPath(getCurrentTemplatePath())));
	
	//Default controler to load
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

		if(application.zpm.isMethod(request.controller,request.method)){
			//call controller init
			var controlObj = new "#request.controller#"();
			
			//get available controllers
			var availableControllers  = structKeyExists(controlObj,"controllers") ? controlObj.controllers : arrayNew(1);
			   
			//if method is a controller type, okay  
			if(arrayContains(availableControllers,request.method)){
				controlObj.fn = controlObj[request.method];
				controlObj.fn();	
			}else{
				writeOutput("404 not found");
				abort;
			}
		
			//display the page content			
			if(request.view NEQ ''){
				var pageContent = application.zpm.view.page(request.view);
				writeOutput(pageContent);
			}else{
				writeOutput('Nothing to view');
				abort;
			}
			
		}else{
			// inlcude 404 page here 
			//TODO:  Throw user to a defined 404 page
			writeOutput("404 not found");
			abort;
		}
	}
	
	
	


}