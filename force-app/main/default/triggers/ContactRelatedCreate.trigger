trigger ContactRelatedCreate on Contact (after insert, after update, after delete) {
   if (trigger.isAfter){
        if (trigger.isInsert){
            AccountRelatedCount.contactCount(trigger.new);        
        }
        if (trigger.isDelete){
            AccountRelatedCount.ContactDeleteCount(trigger.Old);        
        }
         if (trigger.isUpdate){
            AccountRelatedCount.updatemethod(trigger.new ,trigger.Old);        
        }
    }

 
}