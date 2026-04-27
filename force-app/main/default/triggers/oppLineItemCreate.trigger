trigger oppLineItemCreate on Opportunity (after insert) {
      if(trigger.isafter && trigger.isInsert){
        opportunityLineItemHand.opplineiteminsert(trigger.new);
    }
}