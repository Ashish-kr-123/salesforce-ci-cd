public class CreateAccOppCon {
    public static void CreateAccOppConMethod(){
        Account Acc = new Account();
        acc.Name='Vaibhavb gupta';
        insert Acc;
        
        Contact Con = new Contact(
            firstName = 'Vaibhavb',
            LastName = 'gupta',
            Email ='gupta.vaibhavb@gmail.com',
            AccountId = acc.Id
        );
        insert Con;
        
        Opportunity Opp = new Opportunity(
            Name = 'Vaibhavb',
            CloseDate = system.today(),
            stageName = 'closed lost',
            AccountId = acc.Id);
        INSERT Opp;
        
        System.debug('Created Account ID: ' + acc.Id);
        System.debug('Created Contact ID: ' + con.Id);
        System.debug('Created Opportunity ID: ' + opp.Id);
            
    }
}