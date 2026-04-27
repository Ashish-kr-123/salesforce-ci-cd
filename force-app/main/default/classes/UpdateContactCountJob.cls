public class UpdateContactCountJob implements queueable {
     private set<Id> accIds;

    public UpdateContactCountJob(set<Id> accIds) {
        this.accIds = accIds;
    }

    public void execute(QueueableContext context) {
        List<Account> toUpdate = new List<Account>();
        list<account> accQuery =[SELECT Id, contacts_count__c, (SELECT Id FROM Contacts) FROM Account WHERE Id IN :accIds];
        
        for (Account acc : accQuery){
            acc.contacts_count__c = acc.Contacts.size();
            toUpdate.add(acc);
        }
        if (!toUpdate.isEmpty()) update toUpdate;
    }
}