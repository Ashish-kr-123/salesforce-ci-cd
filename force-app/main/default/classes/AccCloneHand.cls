public class AccCloneHand {
    public static void cloneWithContacts(List<Account> newlist, Map<Id, Account> oldMap){
       list<account> accountsToclone = new list<account>();
        
        for(account acc: newlist){
            account accold = oldMap.get(acc.id);
            if(acc.Clone_Acc_Con__c == true &&(accold.Clone_Acc_Con__c == false || accold == null)){
                accountsToclone.add(acc);
            }     
        }
        system.debug('fo...' + accountsToclone);
        if(accountsToclone.isEmpty()){
            return;
        }
        list<account> clonedAccounts = new list<account>();
        
        for(account orig : accountsToclone ){
            account cloneAcc = orig.clone(false, true, false, false);
            cloneAcc.Name = orig.Name + '(cloned)';
            clonedAccounts.add(cloneAcc);       
        }
        insert clonedAccounts;
        system.debug('fo1...' + clonedAccounts);
        
         Map<id, id> originaltoCloneMap = new Map<id, id>();
        for(integer i = 0 ; i < accountsToclone.size(); i++){
            originaltoCloneMap.put(accountsToclone[i].id, clonedAccounts[i].id);       
        }
        system.debug('fo2...' + originaltoCloneMap);
        
        List<Contact> contactsToClone = [
        SELECT FirstName, LastName, Email, Phone, AccountId
        FROM Contact
        WHERE AccountId IN :originalToCloneMap.keySet()];
        
        system.debug('fo3...' + contactsToClone);
        
        List<Contact> contactClones = new List<Contact>();
  
        for (Contact con : contactsToClone) {
            Contact conClone = con.clone(false, true, false, false);
            conClone.LastName = con.LastName + '(cloned)';
            conClone.AccountId = originalToCloneMap.get(con.AccountId);
            contactClones.add(conClone);
    	}
        system.debug('fo3...' + contactClones);
        if (!contactClones.isEmpty()) {
            insert contactClones;
        }
    }
}