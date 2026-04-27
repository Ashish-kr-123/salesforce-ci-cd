public class OppTaskScheduleableCreate implements schedulable{
    public void execute(schedulableContext sc){
        list<opportunity> opplist = [SELECT Id, ownerId, Name, CloseDate, StageName 
                                     FROM Opportunity 
                                     WHERE CloseDate < TODAY 
                                     AND IsClosed = FALSE];
        
        list<task> taskToCreate = new list<task>();
        if(!opplist.isEmpty()){
            for(opportunity opp : opplist){
                task taskRecord = new task();
                taskRecord.priority = 'normal';
                taskRecord.OwnerId = opp.OwnerId;
                taskRecord.Status = 'Open';
                taskRecord.Description = 'Close the open opportunity whose date is passed';
                taskRecord.WhatId = opp.Id;
                taskRecord.Subject= 'Reminder task';
                taskToCreate.add(taskRecord);
            }
        }
        if(!taskToCreate.isEmpty()){
            insert taskToCreate;
        }
    }
}