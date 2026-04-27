public class leadTriggerHandler {
    public static void HandleActivitiesafterInsert(list<lead> leadRecords){
        
        list<task> taskListToInsert = new list<task>();
        for(lead leadRec : leadRecords){
            
            task taskRecord = new task();
                taskRecord.priority = 'High';
                taskRecord.OwnerId = leadRec.OwnerId;
                taskRecord.Status = 'Not started';
                taskRecord.Description = 'Follow up with the new lead';
                taskRecord.WhoId = leadRec.Id;
                taskRecord.Subject= 'follow up';
                taskListToInsert.add(taskRecord);
        }
        if(!taskListToInsert.isempty())
            insert taskListToInsert;
    }
}