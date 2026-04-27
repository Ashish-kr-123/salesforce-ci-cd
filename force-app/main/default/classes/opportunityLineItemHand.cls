public class opportunityLineItemHand {
    public static void opplineiteminsert(list<opportunity> opportunities){
       if(opportunities == null || opportunities.isEmpty()){
            return;
        }   
        set<id> pricebookIds = new set<id>();
        Id defaultPricebookId = [SELECT Id FROM Pricebook2 LIMIT 1].Id;
        for(opportunity opp : opportunities){
            if(opp.pricebook2Id != null)
                opp.Pricebook2Id = defaultPricebookId;
                pricebookIds.add(opp.Pricebook2Id); 
        }
        System.debug(LoggingLevel.ERROR, 'Pricebook IDs: ' + pricebookIds);
       
        list<product2> defaultProducts = [select id from product2 limit 1];
     
        system.debug('found1...' + defaultProducts);
        Id defaultProductId = defaultProducts[0].Id;
        system.debug('f3...' + defaultProductId);
        
        map<Id, PricebookEntry> pbeMap = new map<Id, PricebookEntry>();
        for(Pricebookentry pbe :[
            SELECT Id, Pricebook2Id, UnitPrice
            FROM PricebookEntry
            WHERE Product2Id = :defaultProductId
              AND Pricebook2Id IN :pricebookIds
              AND IsActive = true
        ]){
            pbeMap.put(pbe.Pricebook2Id, pbe);
        }
        system.debug('found2 ' + pbeMap);
        list<opportunitylineitem> olilist = new list<opportunitylineitem>();
        for(opportunity opp : opportunities){
            PricebookEntry pbe = pbeMap.get(opp.Pricebook2Id);
            if(pbe != null){
                opportunitylineitem oli = new opportunitylineitem(
                opportunityId = opp.Id,
                Product2Id = defaultProducts[0].Id, 
                PricebookEntryId = pbe.Id,
                quantity = 1,
                unitPrice = pbe.UnitPrice
                );
                olilist.add(oli);
            }
        }
        system.debug('found3  ' + olilist);
        insert olilist;
    }
}