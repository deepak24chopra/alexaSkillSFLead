@RestResource(urlMapping='/adityaservice/test')
global class AlexaLeadEndPoint {

    // to get most recent leads
    @HttpGet
    global static void getRecentLead(){
        try{
            RestResponse res = RestContext.response;
            RestRequest req = RestContext.request;
            AlexaLeadEndPointHelper helper = new AlexaLeadEndPointHelper();
            
            //call the lead method 
            String leadDetailStatus =  helper.getMostRecentLead();
            if(!String.isEmpty(leadDetailStatus)){
                res.responseBody = Blob.valueOf(leadDetailStatus);
                res.statusCode = 200;}
            else{
                res.responseBody = Blob.valueOf('Unknown Parsing Error');
                res.statusCode = 404;
            }
        }
        catch(Exception e){
            System.debug(' Error Details ' + e.getLineNumber() + e.getMessage() + e.getStackTraceString()); }
    }
    
    
    //to convert lead
    @HttpPost
    global static void convertLead(){
        RestResponse res = RestContext.response;
        RestRequest req = RestContext.request;
        try{
            Blob body = req.requestBody;
            String requestString = body.toString();
            
            //null check for empty body
            if(String.isEmpty(requestString)){
                res.responseBody = Blob.valueOf('empty body');
                res.statusCode = 400;
                return;
            }
            else{
                AlexaLeadEndPointHelper.Request_Body_Wrapper obj = (AlexaLeadEndPointHelper.Request_Body_Wrapper)JSON.deserialize(requestString, AlexaLeadEndPointHelper.Request_Body_Wrapper.class);                
                AlexaLeadEndPointHelper helper = new AlexaLeadEndPointHelper();
                Boolean isConverted = helper.leadConvertHelper(obj.lead_name);
                if(isConverted){
                    res.responseBody = Blob.valueOf('Lead Successfully Converted');
                    res.statusCode = 200;
                    return; 
                }
                else{
                    res.responseBody = Blob.valueOf('Lead Conversion Failed');
                    res.statusCode = 417;
                    return;
                }
            }
        }
        catch(Exception e){
            System.debug(' Error Details ' + e.getLineNumber() + e.getMessage() + e.getStackTraceString()); 
        }
    }
    

    /*@HttpGet
    global static void getLeads(){
        try{
            RestResponse res = RestContext.response;
            RestRequest req = RestContext.request;
            AlexaLeadEndPointHelper helper = new AlexaLeadEndPointHelper();
            //	String leadId = req.requestURI.substring(req.requestURI.lastIndexOf('/')+1); 
            
            //call the lead method 
            String leadDetailStatus =  helper.getLeadDetails(leadId);
            if(!String.isEmpty(leadDetailStatus)){
                res.responseBody = Blob.valueOf(leadDetailStatus);
                res.statusCode = 200;}
            else{
                res.responseBody = Blob.valueOf('Parsing Error' + leadId);
                res.statusCode = 404;
            }
        }
        catch(Exception e){
            System.debug(' Error Details ' + e.getLineNumber() + e.getMessage() + e.getStackTraceString()); }
    }*/
	
   
}