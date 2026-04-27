trigger AccCloneTrigger on Account (after update) {
    if(trigger.isafter && trigger.isupdate){
      AccCloneHand.cloneWithContacts(Trigger.New , Trigger.oldMap);
    }
}