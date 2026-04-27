public class AccountRelatedCount {
    public static void ContactCount(list<contact> newconList){
        
        Set<Id> setid = new Set<Id>();
        
        for(contact con1 : newconList){
            setid.add(con1.AccountId);
        }
        
        list<account> acc = [SELECT id, name, (select accountId from contacts) from account where id in : setid ];
        list<account> accToUpdate = new list<account>();
        
        for( account a : acc){
        a.Contacts_count__c = a.contacts.size();
        accToUpdate.add(a);    
        }
        
        update accToUpdate;
    }
    
    public static void ContactDeleteCount(List<Contact> oldconlist) {

        Set<Id> setoldid = new Set<Id>();	

        for(Contact c1 : oldconlist) {
            setoldid.add(c1.AccountId);
        }

        List<Account> accold = [SELECT Id, Name,(SELECT AccountId FROM Contacts) FROM Account WHERE Id In:setoldid];
        list<account> accToDelete = new list<account>();
        
        for(Account a : accold) {
        a.Contacts_count__c = a.contacts.size();
        accToDelete.add(a);    
        }

        update accToDelete;
    }
    public static void updatemethod(list<contact> newconlist, list<contact> oldconlist){
        
        Set<Id> accountIds = new Set<Id>();
        
        for (Contact c : newconlist) {
            if (c.AccountId != null) accountIds.add(c.AccountId);
        }
        for (Contact c : oldconlist) {
            if (c.AccountId != null) accountIds.add(c.AccountId);
        }
        
        List<Account> accountsToUpdate = new List<Account>();
         for (Account acc : [SELECT Id, Contacts_count__c, (SELECT Id FROM Contacts) FROM Account WHERE Id IN :accountIds]) {
             acc.Contacts_count__c = acc.Contacts.size();
             accountsToUpdate.add(acc);
        }

             if (!accountsToUpdate.isEmpty()) {
             update accountsToUpdate;
        }    
    }     
}