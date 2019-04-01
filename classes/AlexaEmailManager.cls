public class AlexaEmailManager {
    public static void sendMail(String addresses, String subjects, String messages){
        Messaging.SingleEmailMessage[] emails = new Messaging.SingleEmailMessage[]{};
            List<String> addr = new List<String>();
        	addr.add(addresses);
            Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
            email.setSubject(subjects);
            email.setToAddresses(addr);
            email.setPlainTextBody(messages);
            emails.add(email);
        Messaging.sendEmail(emails);
    }
}