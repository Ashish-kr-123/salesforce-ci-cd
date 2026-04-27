trigger accountTrigger1 on Account (after update) {
    Set<Id> accIds = new Set<Id>();
    if(trigger.isafter && trigger.isupdate){
                for (Account acc : Trigger.new) {
                    accIds.add(acc.Id);
                } 
        if (!accIds.isEmpty()) {
            AccountCalaculator.countContacts(accIds);
        }
    }
}