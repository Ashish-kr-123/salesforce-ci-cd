trigger OpportunityTrigger on Opportunity (after insert, after update, after delete, after undelete) {
    if(Trigger.isAfter){
        OpportunityTriggerHandler.updateAccountRollup(
            Trigger.isDelete ? Trigger.old : Trigger.new
        );
    }

}