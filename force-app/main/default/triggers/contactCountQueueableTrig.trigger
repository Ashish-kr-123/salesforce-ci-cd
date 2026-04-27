trigger contactCountQueueableTrig on Contact (after insert, after update, after delete, after undelete) {
    set<id> accIds = new set<id>();
    
    if(trigger.isafter){
            if (Trigger.isInsert || Trigger.isUndelete) {
            for (Contact c : Trigger.new) if (c.AccountId != null) accIds.add(c.AccountId);
            }
            if (Trigger.isDelete) {
                for (Contact c : Trigger.old) if (c.AccountId != null) accIds.add(c.AccountId);
            }
            if (Trigger.isUpdate) {
                for (Contact c : Trigger.new) if (c.AccountId != null) accIds.add(c.AccountId);
                for (Contact c : Trigger.old) if (c.AccountId != null) accIds.add(c.AccountId);
            }
        }
    if (!accIds.isEmpty()) {
        System.enqueueJob(new UpdateContactCountJob(accIds));
    }
}