trigger AccUponHotAfterUpdateTrigg on Account (after update) {
    if(trigger.isupdate && trigger.isafter){
        AccUponHotAfterUpdate.accDescAfterUpdate(Trigger.new, Trigger.oldmap);
    }

}