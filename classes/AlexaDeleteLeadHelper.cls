public class AlexaDeleteLeadHelper {

      //Request Wrapper
    public class Request_Body_Wrapper{
        public String lead_name;
    }
    
    //Response Wrapper
    public class Response_Wrapper{
       public String ssml;
    }
    
    public Boolean deleteLeadHelper(String leadName){
        try{
            List<Lead> currentLead = [Select id, name from lead where name =: leadName AND status != 'Closed - Converted' limit 1];
            if(currentLead.size()>0){
                delete currentLead;
                return true;
            }
            return false;
        }catch(Exception e){
            return false;
        }
    }
}