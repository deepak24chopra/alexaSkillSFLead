public class AlexaLeadEndPointHelper {
	
    //Request Wrapper
    public class Request_Body_Wrapper{
        //public String lead_id;
        public String lead_name;
    }
    
    //Response Wrapper
    public class Response_Wrapper{
       public String ssml;
    }
    
    //Get Method
    public String getMostRecentLead(){
        try{
            List<Lead> a = [Select id, name from Lead Order By CreatedDate DESC limit 1];
            if(a != NULL && a.size()>0){
                JSONGenerator res = JSON.createGenerator(true);
                res.writeStartObject();
                res.writeStringField('ssml', 'Your most recent lead is ' + a[0].Name);
                res.writeEndObject();
                String leadDetails = res.getAsString();
                return leadDetails;
            }
            else {
                JSONGenerator res = JSON.createGenerator(true);
                res.writeStartObject();
                res.writeStringField('ssml', 'No lead exist present yet');
                res.writeEndObject();
                String leadDetails = res.getAsString();
                return leadDetails;
            }
        }
        catch(Exception e){
        }
        return '';
    }
    
    //PostMethod
    public Boolean leadConvertHelper(String leadName){
        try{
        List<Lead> currentLead = [Select id, name from Lead where name =: leadName];
        if(currentLead.size()>0){
        Database.LeadConvert lc = new database.LeadConvert();        
        lc.setLeadId(currentLead[0].id);          
        LeadStatus convertStatus = [SELECT Id, MasterLabel FROM LeadStatus WHERE IsConverted=true LIMIT 1];
        lc.setConvertedStatus(convertStatus.MasterLabel);            
        Database.LeadConvertResult lcr = Database.convertLead(lc);
        System.assert(lcr.isSuccess());
        return true;
            }
            else{ return false;  }
        }
        catch(Exception e){}
        return false;
    }
    
    //get an lead details
    public String getLeadDetails(String Lid){
        try{
            List<Lead> a = [select id, name from Lead where id =: lid];
            if(a != NULL && a.size()>0){
                JSONGenerator res = JSON.createGenerator(true);
                res.writeStartObject();
                res.writeStringField('ssml', 'Your most recent lead is ' + a[0].Name);
                res.writeEndObject();
                String leadDetails = res.getAsString();
                return leadDetails;
            }
            else {
                JSONGenerator res = JSON.createGenerator(true);
                res.writeStartObject();
                res.writeStringField('ssml', 'No lead exists with the id: ' + Lid);
                res.writeEndObject();
                String leadDetails = res.getAsString();
                return leadDetails;
            }
        }
        catch(Exception e){
            //System.debug(e.getLineNumber(), e.getMessage(), e.getStackTraceString());
            //return null;
        }
        return '';
    }
}