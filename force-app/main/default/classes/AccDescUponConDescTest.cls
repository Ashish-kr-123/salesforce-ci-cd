@IsTest
public class AccDescUponConDescTest {
    @testSetup
    static void setupTestData() {
        // Create one account with no contacts (edge case)
        Account acctNoContact = new Account(Name = 'No Contact Account');
        insert acctNoContact;

        // Create an account with two contacts having different descriptions
        Account acctWithContacts = new Account(Name = 'Account With Contacts');
        insert acctWithContacts;

        Contact firstContact = new Contact(
            FirstName = 'John',
            LastName = 'Doe',
            AccountId = acctWithContacts.Id,
            Description = 'First Contact Description'
        );
        insert firstContact;

        // Delay to ensure last modified order (optional)
        Contact secondContact = new Contact(
            FirstName = 'Jane',
            LastName = 'Smith',
            AccountId = acctWithContacts.Id,
            Description = 'Most Recent Contact Description'
        );
        insert secondContact;
    }

    @isTest
    static void testUpdateAccDescWithNoContacts() {
        // Fetch account that has no contacts
        Account acct = [SELECT Id, Description FROM Account WHERE Name = 'No Contact Account' LIMIT 1];
        System.assertEquals(null, acct.Description, 'Initial description should be blank');

        Test.startTest();
            AccDescUponConDesc.updateAccDesc(new Set<Id>{acct.Id});
        Test.stopTest();

        acct = [SELECT Description FROM Account WHERE Id = :acct.Id];
        System.assertEquals(
            null,
            acct.Description,
            'Description should remain null when no contacts are present'
        );
    }

    @isTest
    static void testUpdateAccDescWithContacts() {
        // Fetch the account with contacts
        Account acct = [SELECT Id FROM Account WHERE Name = 'Account With Contacts' LIMIT 1];

        Test.startTest();
            AccDescUponConDesc.updateAccDesc(new Set<Id>{acct.Id});
        Test.stopTest();

        acct = [SELECT Description FROM Account WHERE Id = :acct.Id];
        System.assertEquals(
            'Most Recent Contact Description',
            acct.Description,
            'Account.Description should match the most recently modified Contact.Description'
        );
    }
}