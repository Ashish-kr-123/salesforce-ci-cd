public class accTriggerHandler {
    public static void preventDuplicateAcc(list<account> acclist){
        
        set<string> accNames = new set<string>();
        
        for(account acc : acclist){
            accNames.add(acc.Name);
            system.debug('name of account ---> '+ accNames);  
        }
        
        Map<String, Account> accmap = new Map<String, Account>();

        for(Account acc : [
            SELECT Id, Name FROM Account WHERE Name IN :accNames
        ]){
            accmap.put(acc.Name.toLowerCase(), acc);
        }
        
        system.debug('map --->' + accmap);
        
        for(account acc: acclist){
            if(accmap.containskey(acc.Name.toLowerCase())){
                acc.addError('account name already exist in database');
            }
        }
    }
}