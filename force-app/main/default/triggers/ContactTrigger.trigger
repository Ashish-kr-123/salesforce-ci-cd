trigger ContactTrigger on Contact (before insert) {
    if(Trigger.isbefore && Trigger.isinsert){
        ContactTriggerHandler.handleBeforeInsert(Trigger.new);
    }
}