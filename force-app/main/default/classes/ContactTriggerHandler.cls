public class ContactTriggerHandler {
    public static void handleBeforeInsert(list<contact> newRecords){
        /*list<contact> existRec = [SELECT Id , LastName , phone , email from contact limit 50000];
        for(contact con : newRecords){
            for(contact existcon : existRec){
                if(con.LastName == existcon.LastName && con.Phone == existcon.Phone && con.Email == existcon.Email){
                      con.addError('Duplicate record found');
                   }
                }
            }*/
         
        list<Id> accIds = new list<Id>();
        for(contact con : newRecords){
             if (con.AccountId != null) {
                 accIds.add(con.AccountId);
             }
            
        Map<Id,Account> accountRecordMap = new map<Id,account>([SELECT Id, BillingStreet, BillingCity, BillingState, BillingPostalCode, BillingCountry from account where Id in :accIds]);
        
            for(contact con1 : newRecords){
                if(accountRecordMap.containskey(con.AccountId)){
                    con1.MailingCity = accountRecordMap.get(con.AccountId).BillingCity;
                    con1.MailingStreet = accountRecordMap.get(con.AccountId).BillingStreet;
                    con1.MailingState = accountRecordMap.get(con.AccountId).BillingState;
                    con1.MailingCountry = accountRecordMap.get(con.AccountId).BillingCountry;
                    con1.MailingPostalCode = accountRecordMap.get(con.AccountId).BillingPostalCode;
                }
            }
        }
    }   
}