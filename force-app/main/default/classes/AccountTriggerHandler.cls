public class AccountTriggerHandler {
    
    public static void handleBeforUpdateActivities(list<account> newRecords ,map<Id,account> oldmap){
        for(account accRecords : newRecords){
            if(accRecords.Industry == 'Agriculture' && accRecords.Type  == 'Prospect'){
                IF(oldmap.get(accRecords.Id).Ownership != accRecords.Ownership && accRecords.Ownership == 'private'){
                    accRecords.addError('Ownership cannot be modified');
                }
            }
        }
    }  
    
    public static void handleAfterUpdateActivities(list<account> newRecords ,map<Id,account> oldmap){
        Map<Id,String> accToWebsiteMap = new Map<Id,String>();
        
        for(account acc : newRecords){
            if(acc.Website != oldMap.get(acc.Id).website){
                accToWebsiteMap.put(acc.Id,acc.Website);
            }
        }
        
        if(accToWebsiteMap.keyset().size() > 0){
            list<contact> addConToUpdate = new list<contact>();
            list<contact> conRecords = [Select id , firstname ,website__c , accountId from contact where accountId in : accToWebsiteMap.keyset()];
            for(Contact con : conRecords){
                con.website__c = accToWebsiteMap.get(con.accountId);
                addConToUpdate.add(con);
            }
            if(addConToUpdate.size() > 0){
                update addConToUpdate;
            }
        }
    }
}