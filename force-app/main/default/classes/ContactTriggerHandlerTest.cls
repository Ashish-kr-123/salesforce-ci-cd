@IsTest
public class ContactTriggerHandlerTest {
    @TestSetup
    static void setupData(){
        // prepare an account with billing info
        account acc = TestDataFactory.createAccountWithBilling(
            'MyTestAccount',
            '123 Test St',
            'TestCity',
            'Bihar',
            '12345',
            'India',
            true
        );
        
        TestDataFactory.createContactsForAccount(acc.Id, 1, true);
    }
    @IsTest
    static void testMailingFieldsCopiedOnInsert() {
        // Fetch the test Account
        Account acc = [SELECT Id, BillingStreet, BillingCity, BillingState, BillingPostalCode, BillingCountry
                       FROM Account WHERE Name = 'MyTestAccount' LIMIT 1];

        // Create and insert a new Contact linked to the Account
        Contact con = new Contact(LastName = 'Smith', AccountId = acc.Id);
        Test.startTest();
            insert con;
        Test.stopTest();
        
        Contact inserted = [SELECT MailingStreet, MailingCity, MailingState, MailingPostalCode, MailingCountry
                            FROM Contact WHERE Id = :con.Id];
        
        system.assertEquals(acc.BillingStreet, inserted.MailingStreet, 'street are same');
        system.assertEquals(acc.Billingcity, inserted.MailingCity, 'city are same');
        system.assertEquals(acc.BillingState, inserted.MailingState, 'state are same');
        system.assertEquals(acc.BillingPostalCode, inserted.MailingPostalCode, 'postal are same');
        system.assertEquals(acc.BillingCountry, inserted.MailingCountry, 'country are same');

    }
}