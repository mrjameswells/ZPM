component{
	public void function init(){
		this.controllers = ["hello"];
	}
	
	public void function  hello() roles=''{
		request.view = '/zpm/examples/project1/AwesomePortal/view/dashboardTheme/index.cfm';
		request.attributes.body = 'Hello World - Skeleton';
	}
}
