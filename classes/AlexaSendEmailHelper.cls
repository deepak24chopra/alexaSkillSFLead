public class AlexaSendEmailHelper {

    //Request Wrapper
    public class Request_Body_Wrapper{
        public String lead_name;
       // public String subject;
        public String message;
    }
    
    //Response Wrapper
    public class Response_Wrapper{
       public String ssml;
    }
    
    public Boolean sendEmailHelper(Request_Body_Wrapper obj){
        List<Lead> l = [Select id, email from Lead where name =: obj.lead_name];
        if(l.size()>0){
            AlexaEmailManager.sendMail(l[0].email, 'Alexa Test', obj.message);
            return true;}
        else{ return false; }
    }
}