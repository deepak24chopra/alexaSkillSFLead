@RestResource(urlMapping='/adityaservice/deletelead')
global class AlexaDeleteLead {
    
    @HttpPost
    global static void deleteLead(){
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
                AlexaDeleteLeadHelper.Request_Body_Wrapper obj = (AlexaDeleteLeadHelper.Request_Body_Wrapper)JSON.deserialize(requestString, AlexaDeleteLeadHelper.Request_Body_Wrapper.class);                
                AlexaDeleteLeadHelper helper = new AlexaDeleteLeadHelper();
                Boolean isDeleted= helper.deleteLeadHelper(obj.lead_name);
                if(isDeleted){
                    res.responseBody = Blob.valueOf('Lead Deleted Successfully');
                    res.statusCode = 200;
                    return; 
                }
                else{
                    res.responseBody = Blob.valueOf('Lead Deletion Failed');
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