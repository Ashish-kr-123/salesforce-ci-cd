trigger TaskCreateOnOppQueueableTrig on Opportunity (after update) {
    if(trigger.isafter && trigger.isupdate){
        list<id> oppIds = new list<id>();
        for( opportunity opp : trigger.new){
            if(opp.stageName == 'closed won' && Opp.StageName != trigger.oldMap.get(opp.Id).stageName){
                oppIds.add(opp.Id);
            }
        }
        if(!oppIds.isEmpty()){
            System.enqueueJob(new OppRevenueSplitTaskCreator(oppIds));
        } 
    }
}