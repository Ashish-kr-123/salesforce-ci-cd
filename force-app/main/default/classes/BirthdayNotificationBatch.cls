public class BirthdayNotificationBatch implements Database.Batchable<sObject>{
    
    public Database.QueryLocator start(Database.BatchableContext bc){
        return Database.getQueryLocator([SELECT Id, Name, Birthdate FROM Contact WHERE Birthdate = TODAY]);
    }
    public void execute(Database.BatchableContext bc, list<contact> scope){
        if(!scope.isEmpty()){
            system.debug('birthdayData....'  + scope );
            Messaging.singleEmailMessage mail = new Messaging.singleEmailMessage();
            
            mail.setToAddresses(new String[]{'ashish30071997@gmail.com'});
            
            mail.setSubject('Contacts having Birthday Today');
            
            List<String> lines = new List<String>();
            lines.add('The following contacts have birthdays today:');
            for (Contact c : scope) {
                lines.add('- ' + c.Name);
            }
            String body = String.join(lines, '\n');
            mail.setPlainTextBody(body);
            
            Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });            
        }
    }
    public void finish(Database.BatchableContext bc){
        
    }

}