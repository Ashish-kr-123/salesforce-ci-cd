public class OppTriggerHandler {
    
    public static void HandleActivitiesAfterUpdate(list<opportunity> newRecords , map<Id , opportunity> oldmap){
        list<task> insertToList = new list<task>();
        
        for(opportunity opp : newRecords){
            Opportunity oldopp = oldmap.get(opp.id);
            if(oldopp.StageName == 'Prospecting' && opp.StageName =='Closed Won'){
                
                for(integer i=1 ; i<=5 ; i++){
                    task taskRecord = new task();
                    taskRecord.priority = 'High';
                    taskRecord.OwnerId = opp.OwnerId;
                    taskRecord.Status = 'Not started';
                    taskRecord.Description = 'please split the revenue among the team members';
                    taskRecord.WhatId = opp.Id;
                    taskRecord.Subject= 'Split Revenue' + i;
                    insertToList.add(taskRecord); 
                }
            }
        }
        if(!insertToList.isempty())
            insert insertToList;     
    }
}