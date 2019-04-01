public class AlexaCreateLeadHelper {

    //Request Wrapper
    public class Request_Body_Wrapper{
        public String lead_name;
        public String company;
        //public String status;
    }
    
    //Response Wrapper
    public class Response_Wrapper{
       public String ssml;
    }
    
    public Boolean createLeadHelper(Request_Body_Wrapper obj){
        try{
            Lead newLead = new Lead();
            newLead.LastName = obj.lead_name;
            newLead.Status = 'Open - Not Contacted';
            newLead.Company = obj.company;
            newLead.Email ='deepak.chopra@mirketa.com';
            insert newLead;
            return true;
        }catch(Exception e){
            return false;
        }
    }
}