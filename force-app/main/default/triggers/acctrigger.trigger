trigger acctrigger on Account (before insert) {
    if (trigger.isbefore && trigger.isinsert){
        accTriggerHandler.preventDuplicateAcc(trigger.new);
    }
}