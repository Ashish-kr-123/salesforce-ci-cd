trigger OppDelDueItemTrigg on OpportunityLineItem (after Delete) {
    if(trigger.isafter && trigger.isdelete){
         OppDelDueLineItemTiggHand.OppDelete(trigger.old);
    }
}