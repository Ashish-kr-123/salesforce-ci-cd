public class updateContactsAddresses implements Database.Batchable<sObject>, Database.stateful {
    private integer recordsProcessed = 0;
    
    public Database.querylocator start(database.BatchableContext bc){
        return database.getQueryLocator([SELECT Id, MailingStreet, MailingCity, MailingState, MailingPostalCode, 
                   MailingCountry, AccountId, Account.BillingStreet, Account.BillingCity, Account.BillingState,
                   Account.BillingPostalCode, Account.BillingCountry
            FROM Contact
            WHERE Account.BillingCountry = 'India']);
        
    }
    public void execute(database.BatchableContext bc, list<contact> scope){
        List<Contact> toUpdate = new List<Contact>();
        for (Contact c : scope) {
            if(c.accountId != Null){
            c.MailingStreet     = c.Account.BillingStreet;
            c.MailingCity       = c.Account.BillingCity;
            c.MailingState      = c.Account.BillingState;
            c.MailingPostalCode = c.Account.BillingPostalCode;
            c.MailingCountry    = c.Account.BillingCountry;
            toUpdate.add(c);
            recordsProcessed++;
            }
        }
        if (!toUpdate.isEmpty()) {
            update toUpdate;
            //recordsProcessed = recordsProcessed + toUpdate.size();
        }     
    }
    public void finish(Database.BatchableContext bc){
        system.debug(recordsProcessed + 'records processed. shazam!');
        AsyncApexJob job = [SELECT Id, Status, NumberOfErrors,
            JobItemsProcessed,
            TotalJobItems, CreatedBy.Email
            FROM AsyncApexJob
            WHERE Id = :bc.getJobId()];
        // call some utility to send email
        Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
        email.setToAddresses(new String[] { job.CreatedBy.Email });
        email.setSubject('Batch Complete: ' + job.Id);
        email.setPlainTextBody('Records processed: ' + recordsProcessed);
        Messaging.sendEmail(new Messaging.SingleEmailMessage[] { email });
    }
}