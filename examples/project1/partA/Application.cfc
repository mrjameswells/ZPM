component extends="zpm.Application" {
	this.datasource 			= '';
    this.sessionmanagement		= true;
	this.sessiontimeout 		= CreateTimeSpan(0,0,30,0);
	this.loginstorage			= "session";
	this.applicationTimeout 	= CreateTimeSpan(0,0,30,0);
	this.name 					= 'project1';
	request.defaultControl='public.hello';

	
	
	public void function onRequest(required string TargetPage){
		super.onRequest(arguments.TargetPage);
		return;	
	} 

}