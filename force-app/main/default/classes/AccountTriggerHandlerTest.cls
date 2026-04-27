@IsTest
public class AccountTriggerHandlerTest {
   @Testsetup
      static void setupTestData() {
        // Create an Account that meets the criteria
        Account acc1 = new Account(
            Name = 'Agri Prospect',
            Industry = 'Agriculture',
            Type = 'Prospect',
            Ownership = 'public',
            Website = 'http://example.com'
        );
        insert acc1;
          
        //Create associated contact
        Contact con = new Contact(
            FirstName = 'Contact1',
            LastName = 'Test',
            AccountId = acc1.Id,
            website__c = 'http://old.com'
        );
        insert con;
}
    @IsTest
    static void  testChangeToPrivate_IsBlocked(){
        Account acc = [select Id, Name, Ownership from Account where Name = 'Agri Prospect' limit 1];
        acc.Ownership = 'Private';
        
        Test.StartTest();
        Try{
            update acc;
            system.assert(false, 'Expected an exception, but none occurred.');
        } Catch(DmlException e){
            system.assert(e.getMessage().contains('Ownership cannot be modified'), 'Expected ownership change to be blocked');
        }
        Test.StopTest();
    }
    @IsTest
    static void testAfterUpdateWebsiteUpdatesContacts(){
        account acc = [select Id, Name, website from account where Name = 'Agri Prospect' limit 1];
        contact con = [select Id, Website__c from contact where accountId =: acc.Id limit 1];
        acc.website = 'http://newsite.com';
        
        Test.StartTest();
        Update acc;
        Test.StopTest();
        
        contact UpdatedCon =[select Id, Website__c from contact where Id =: con.Id];
        system.assertEquals('http://newsite.com', updatedCon.website__c,
            'Contact website__c should match updated Account website');
        
    }   
}