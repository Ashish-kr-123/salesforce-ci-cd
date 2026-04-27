public class CreateAcc2OppCon {
    public static void CreateAcc2OppConMethod(){
         Account acc = new Account(Name = 'Asima');
        
        insert acc;  

        Contact con = new Contact(
            FirstName = 'asima',
            LastName  = 'khan',
            Email     = 'jane.doe@.com',
            AccountId = acc.Id);
        
        insert con; 

        List<Opportunity> oppsToInsert = new List<Opportunity>();
        for (Integer i = 1; i <= 2; i++) {
            Opportunity opp = new Opportunity();
            opp.Name = 'Opportunity ' + i;
            opp.StageName = (i == 1 ? 'Prospecting' : 'Qualification');
            opp.CloseDate = system.today();
            opp.AccountId = acc.Id;
            oppsToInsert.add(opp);
        }

        insert oppsToInsert;
        
    }
}