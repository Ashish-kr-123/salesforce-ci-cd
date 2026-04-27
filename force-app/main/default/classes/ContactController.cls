public with sharing class ContactController {
    @AuraEnabled(cacheable=true)
    public static list<contact> getContacts(Id accId){
        return [Select Id, FirstName, LastName, Email from contact where AccountId =: accId];

    }

    @AuraEnabled(cacheable=false)
    public static list<contact> getLatestContacts(){
        return [Select Id, Name, Email from contact LIMIT 10]; 
    }
}