@IsTest
public class updateContactsAddressesTest {
    @testSetup
    static void TestDataSetup(){
        Account a = new Account(Name='Test', BillingCountry='India', BillingCity='Bhopal');
        insert a;
        insert new Contact(FirstName='John', LastName='Doe', AccountId=a.Id);
    }
    @IsTest
    static void testBatch(){
        Test.startTest();
        UpdateContactsAddresses batch = new UpdateContactsAddresses();
        ID batchId = Database.executeBatch(batch);
        Test.stopTest();
        
        integer counts = [SELECT Count() FROM Contact WHERE MailingCountry = 'India'];

        System.assertEquals(1, counts,'no. of contacts updated');
    }
}