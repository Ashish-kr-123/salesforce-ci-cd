trigger AccountHandTrigger on Account (before insert) {
    {
        if(trigger.isbefore && trigger.isinsert)
        {
           AccountHand.ChangeRating(trigger.new);
        }
    }
}