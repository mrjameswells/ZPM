component {
/*
    Zero Point Module Framework
    v3.1
    
    Author:  James Wells  (mrjameswells@gmail.com)

    How to setup:
	- Create a server alias /zpm to the ZPM application directory
	  For example  http://domain.com/zpm  should map to c:\.....\zpm
	- Or place the zpm folder in your root application directory
	- Use the /zpm/examples/skel to setup your applications
 
	
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

			//display the page content			
			if(request.view NEQ ''){
				var pageContent = application.zpm.view.page(request.view);
				writeOutput(pageContent);
			}
			
		}else{
			// inlcude 404 page here 
			//TODO:  Throw user to a defined 404 page
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