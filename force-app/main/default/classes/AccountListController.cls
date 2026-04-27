public with sharing class AccountListController {
    @AuraEnabled (cacheable=true)
    public static list<account> get20Accounts() {
        return [Select Id, Name, Rating from Account ORDER BY CreatedDate Desc LIMIT 20];
    }
    
    @AuraEnabled
    public static void DeleteAccountById(Id accountId) {
        delete [Select Id from Account where Id =: accountId];
    }
}