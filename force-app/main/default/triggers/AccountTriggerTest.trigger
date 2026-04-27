trigger AccountTriggerTest on Account (before update,before insert,after insert,after update) {
    if(trigger.isBefore){
        if(trigger.isInsert){
            TestAccountHandler.method1(trigger.new);
        }
        
    }
    if(trigger.isAfter){
        
    }
}