public class AccDescUponConDesc {
    @future
    public static void updateAccDesc(set<Id> accIds){
         List<Account> accountsToUpdate = [
            SELECT Id, Description,
                (SELECT Id, Description, LastModifiedDate 
                 FROM Contacts  
                 ORDER BY LastModifiedDate DESC 
                 LIMIT 1)
            FROM Account
            WHERE Id IN :accIds
        ];
        system.debug('acctoupdate....' + accountsToUpdate );

        List<Account> updates = new List<Account>();

        for (Account acc : accountsToUpdate) {
             if (!acc.Contacts.isEmpty()) {
                acc.Description = acc.Contacts[0].Description;
                system.debug('acc.Description....' +acc.Contacts[0].Description );
                updates.add(acc);
            }
        }
        system.debug('updates....' + Updates);
        if (!updates.isEmpty()) {
            update updates;
        }
    }
}