@RestResource(urlMapping='/adityaservice/email')
global class AlexaSendEmail {
    
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
                AlexaSendEmailHelper.Request_Body_Wrapper obj = (AlexaSendEmailHelper.Request_Body_Wrapper)JSON.deserialize(requestString, AlexaSendEmailHelper.Request_Body_Wrapper.class);                
                AlexaSendEmailHelper helper = new AlexaSendEmailHelper();
                Boolean isSent= helper.sendEmailHelper(obj);
                if(isSent){
                    res.responseBody = Blob.valueOf('Mail Sent Successfully');
                    res.statusCode = 200;
                    return; 
                }
                else{
                    res.responseBody = Blob.valueOf('Mail Failed');
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