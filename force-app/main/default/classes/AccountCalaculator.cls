public class AccountCalaculator {
      @future
    public static void countContacts(set<Id> accountIds) {
        
        List<AggregateResult> aggResults = [
            SELECT AccountId, COUNT(Id) cnt
            FROM Contact
            WHERE AccountId IN :accountIds
            GROUP BY AccountId
        ];
        system.debug('agg....' + aggResults);

        List<Account> accountsToUpdate = new List<Account>();
        for (AggregateResult ar : aggResults) {
            accountsToUpdate.add(new Account(
                Id = (Id)ar.get('AccountId'),
                contacts_count__c = (Integer)ar.get('cnt')
                )
            );
        }
        system.debug('acc....' + accountsToUpdate);

        if (!accountsToUpdate.isEmpty()) {
            update accountsToUpdate;
        }
    }
}