trigger LeadTrigger on Lead (after insert) {
    if(Trigger.isinsert && Trigger.isafter){
        leadTriggerHandler.HandleActivitiesafterInsert(Trigger.new);
    }
}