trigger AccountTrigger on Account (before update , after update) {
     
    if(Trigger.isBefore && Trigger.isUpdate){
        AccountTriggerHandler.handleBeforUpdateActivities(Trigger.new , Trigger.oldmap);
    }
    
    if(Trigger.isAfter && Trigger.isUpdate){
        AccountTriggerHandler.handleAfterUpdateActivities(Trigger.new , Trigger.oldmap);
    }
}