@RestResource(urlMapping='/adityaservice/createlead')
global class AlexaCreateLead {
    
    @HttpPost
    global static void createLead(){
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
                AlexaCreateLeadHelper.Request_Body_Wrapper obj = (AlexaCreateLeadHelper.Request_Body_Wrapper)JSON.deserialize(requestString, AlexaCreateLeadHelper.Request_Body_Wrapper.class);                
                AlexaCreateLeadHelper helper = new AlexaCreateLeadHelper();
                Boolean isCreated= helper.createLeadHelper(obj);
                if(isCreated){
                    res.responseBody = Blob.valueOf('Lead Created Successfully');
                    res.statusCode = 200;
                    return; 
                }
                else{
                    res.responseBody = Blob.valueOf('Lead Creation Failed');
                    res.statusCode = 417;
                    return;
                }
            }
        }
        catch(Exception e){
            System.debug(' Error Details ' + e.getLineNumber() + e.getMessage() + e.getStackTraceString()); 
        }
    }
}