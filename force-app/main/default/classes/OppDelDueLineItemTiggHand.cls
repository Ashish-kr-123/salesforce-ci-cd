public class OppDelDueLineItemTiggHand {
    public static void OppDelete(list<OpportunityLineItem> Oli){
        Set<Id> oppId=new Set<Id>();
        
        for(OpportunityLineItem oppProd : Oli){
        oppId.add(oppProd.OpportunityId);
        }

         List<Opportunity> oppList=[Select Id from Opportunity where Id=:oppId];
         if(oppList.size()>0){
         delete oppList;
       }
    }
}