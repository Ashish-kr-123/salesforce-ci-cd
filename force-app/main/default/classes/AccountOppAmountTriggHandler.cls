public class AccountOppAmountTriggHandler {
    public static void OppInsertAmt(List<Opportunity> newOpps){
        set<id> accIds = new set<id>();
        
        for(opportunity opp : newOpps){
            if(opp.accountId != null)
                accIds.add(opp.AccountId);
            	
        }
        system.debug('acc idsss'  + accIds);

        
        
        list<aggregateResult> aggResult = [select accountId , Sum(amount) sumAmt from opportunity where accountId in : accIds group by accountId];
        system.debug('aggregate size'  +aggResult.size());
        list<account> acctoUpdate = new list<account>();
        
        for(aggregateResult agg : aggResult ){
            account acc = new account();
            acc.Id = (Id)agg.get('accountId');
            acc.Tot_Amount__c = (decimal)agg.get('sumAmt');
            acctoUpdate.add(acc);
        }
            Update acctoUpdate;
    }    
     public static void OppDeleteAmt(List<Opportunity> oldOpps){
        set<id> accOldIds = new set<id>();
        
        for(opportunity opp : oldOpps){
            if(opp.accountId != null)
                accOldIds.add(opp.AccountId);
            	
        }
        system.debug('acc idsss'  + accOldIds);

        
        
        list<aggregateResult> aggResult1 = [select accountId , Sum(amount) sumAmt from opportunity where accountId in : accOldIds group by accountId];
        system.debug('aggregate size'  +aggResult1.size());
        list<account> acctoUpdate1 = new list<account>();
        
        for(aggregateResult agg1 : aggResult1 ){
            account acc1 = new account();
            acc1.Id = (Id)agg1.get('accountId');
            acc1.Tot_Amount__c = (decimal)agg1.get('sumAmt');
            acctoUpdate1.add(acc1);
        }
            Update acctoUpdate1;
    }
    public static void OppUpdateAmt(List<Opportunity> newOpps, List<Opportunity> oldOpps){
        set<id> accountIds = new set<id>();
        
        for(opportunity opp : newOpps){
            if(opp.accountId != null)
                accountIds.add(opp.AccountId);     	
        }
        for(opportunity opp : oldOpps){
            if(opp.accountId != null)
                accountIds.add(opp.AccountId);     	
        }
        system.debug('acc idsss'  + accountIds);
     
        list<aggregateResult> aggResult2 = [select accountId , Sum(amount) sumAmt from opportunity where accountId in : accountIds group by accountId];
        system.debug('aggregate size'  +aggResult2.size());
        list<account> acctoUpdate2 = new list<account>();
        
        for(aggregateResult agg2 : aggResult2 ){
            account acc = new account();
            acc.Id = (Id)agg2.get('accountId');
            acc.Tot_Amount__c = (decimal)agg2.get('sumAmt');
            acctoUpdate2.add(acc);
        }
            Update acctoUpdate2;
    }    
}