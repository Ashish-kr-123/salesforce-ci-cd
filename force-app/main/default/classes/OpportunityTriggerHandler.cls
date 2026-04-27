public class OpportunityTriggerHandler {
    public static void updateAccountRollup(list<opportunity> oppList){
        
        set<id> accIds = new set<id>();
        
        for(opportunity opp: oppList){
            if(opp.accountId != null){
                accIds.add(opp.AccountId);
            }
        }
    }

}