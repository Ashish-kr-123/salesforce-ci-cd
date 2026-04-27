trigger contactCountOnAcc on Contact (after insert, after update, after delete) {
    Set<Id> accountIds = new Set<Id>();

    if (Trigger.isDelete) {
        for (Contact oldCon : Trigger.old) {
            if (oldCon.AccountId != null) {
                accountIds.add(oldCon.AccountId);
            }
        }
    } else {
        for (Contact newCon : Trigger.new) {
            if (newCon.AccountId != null) {
                accountIds.add(newCon.AccountId);
            }
        }
    }
    system.debug('accountids....' + accountIds);
    if (!accountIds.isEmpty()) {
        AccountCalaculator.countContacts(accountIds);
    }
}