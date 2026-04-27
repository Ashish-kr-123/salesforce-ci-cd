public class OppRevenueSplitTaskCreator implements queueable{    
    private list<id> oppIds;
    
    public OppRevenueSplitTaskCreator(list<id> oppIds){
        this.oppIds = oppIds ;
        system.debug('oppids--'+this.oppIds);
    }
    
    public void execute(queueableContext context){
        list<opportunity> opp1 = [select Id, ownerId, Name from opportunity where Id in : oppIds];
        system.debug('opp1--'+opp1);
        list<task> taskToinsert = new list<task>();
        for(opportunity op : opp1){
            task t = new task();
            t.ActivityDate = system.today();
            t.Priority = 'High';
            t.Subject = 'split the revenue';
            t.status = 'not started';
            t.WhatId = op.Id;
            t.OwnerId = op.OwnerId;
            taskToinsert.add(t);   
        system.debug('taskToinsert--'+taskToinsert);

        }
        if(!taskToinsert.isEmpty()){
            insert taskToinsert;
        }
    }
}