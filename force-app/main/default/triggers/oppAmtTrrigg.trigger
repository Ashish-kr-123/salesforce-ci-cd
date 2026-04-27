trigger oppAmtTrrigg on Opportunity (after insert, after update, after delete) {
      if (trigger.isAfter){
        if (Trigger.isInsert){
            AccountOppAmountTriggHandler.OppInsertAmt(trigger.new);        
        }
        if (trigger.isDelete){
            AccountOppAmountTriggHandler.OppDeleteAmt(trigger.Old);        
        }
         if (trigger.isUpdate){
            AccountOppAmountTriggHandler.OppUpdateAmt(trigger.new ,trigger.Old);    
        }
    }
}