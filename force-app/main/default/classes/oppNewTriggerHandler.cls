public class oppNewTriggerHandler {
    public static void preventInactiveAccountCreation(list<opportunity> oppList, map<id, opportunity> oldOpp){
        
        set<id> oppIds = new set<id>();
        
        for(opportunity opp : opplist){
            if(oldOpp == null){
                if(opp.accountId != null){
                    oppIds.add(opp.accountId);
                }
            }
            else{
                if(opp.accountId != null && oldopp.get(opp.Id).accountId != opp.accountId){
                    oppIds.add(opp.accountId);
                }
            }
        }
        
        map<id, account> accMap = new map<id, account>(
            [select id, Active__c from account where id in : oppIds]
        );
        
        for(opportunity opps : opplist){
            
            Account acc = accMap.get(opps.AccountId);
            
            if(oldOpp == null){
                if(acc != null && acc.Active__c == 'No'){
                    opps.addError('Cannot create Opportunity for inactive Account');
                }
            }
            else{  
                if(oldopp.get(opps.Id).accountId != null && oldopp.get(opps.Id).accountId != opps.accountId){
                    if(acc != null && acc.Active__c == 'No'){
                        opps.addError('Cannot create Opportunity for inactive Account');
                    }
                }
            }
        }
        
    }
}