trigger OppTrigger on Opportunity (after update) {
    if(Trigger.isUpdate && Trigger.isAfter){
        OppTriggerHandler.HandleActivitiesAfterUpdate(Trigger.New , Trigger.oldmap);
    }
}