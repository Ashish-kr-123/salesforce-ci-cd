public with sharing class AccountService {
    @AuraEnabled
    public static list<Account> getAccounts(String searchKey) {
        return [Select Id, Name from account where Name like :('%'+ searchKey +'%')];    
    }
}