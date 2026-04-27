trigger oppNewTrigger on Opportunity (before insert, before update) {
    oppNewTriggerHandler.preventInactiveAccountCreation(trigger.new, trigger.oldmap);
}