@IsTest
public class AccountRelatedCountTest {
    @TestSetup
    static void setupData(){
        account acc1 = TestDataFactory.createAccount('Account One', true);
       
        account acc2 = TestDataFactory.createAccount('Account Two', true);

        contact con1 = TestDataFactory.createContact(acc1, 'Contact A1', true);
        
        contact con2 = TestDataFactory.createContact(acc1, 'Contact A2', true);
       
        contact con3 = TestDataFactory.createContact(acc2, 'Contact A2', true);
        
    }
      @isTest
    static void testInsertContactUpdatesCount() {
        // Arrange
        Account acc = TestDataFactory.createAccount('Account InsertTest', true);
        // Act
        Contact newCon = TestDataFactory.createContact(acc, 'New Contact', true);
        Test.startTest();
            AccountRelatedCount.ContactCount(new List<Contact>{ newCon });
        Test.stopTest();

        // Assert
        Account updated = [SELECT Contacts_count__c FROM Account WHERE Id = :acc.Id];
        System.assertEquals(1, updated.Contacts_count__c, 'Contacts_count__c should be 1 after insert');
    }
     @isTest
    static void testUpdateContactChangesAccountCount() {
        // Arrange
        Account fromAcc = [SELECT Id FROM Account WHERE Name = 'Account One' LIMIT 1];
        system.debug('acc..1..: ' + fromAcc);
        Account toAcc = [SELECT Id FROM Account WHERE Name = 'Account Two' LIMIT 1];
        system.debug('acc..2..:'+toAcc);
        Contact con = TestDataFactory.createContact(fromAcc, 'Moving Contact', true);
        system.debug('con..1..:'+con);

        // Act
        con.AccountId = toAcc.Id;
        update con;
        system.debug('con..2...:'+con);
        Test.startTest();
            AccountRelatedCount.updatemethod(new List<Contact>{con}, new List<Contact>{con});
        Test.stopTest();

        // Assert
        fromAcc = [SELECT Contacts_count__c FROM Account WHERE Id = :fromAcc.Id ];
        system.debug('acc...3...:'+fromAcc);
        toAcc   = [SELECT Contacts_count__c FROM Account WHERE Id = :toAcc.Id];
        system.debug('acc..4..:'+toAcc);
        System.assertEquals(2, fromAcc.Contacts_count__c, 'From-Account should decrement by one');
        System.assertEquals(2, toAcc.Contacts_count__c, 'To-Account should increment by one');
    }

      @isTest
    static void testDeleteContactUpdatesCount() {
        // Arrange
        Account acc = [SELECT Id FROM Account WHERE Name = 'Account One' LIMIT 1];
        Contact con = TestDataFactory.createContact(acc, 'To Be Deleted', true);

        // Act
        delete con;
        Test.startTest();
            AccountRelatedCount.ContactDeleteCount(new List<Contact>{con});
        Test.stopTest();

        // Assert
        Account updated = [SELECT Contacts_count__c FROM Account WHERE Id = :acc.Id];
        System.assertEquals(2, updated.Contacts_count__c, 'Contacts_count__c should decrement after delete');
    }
      
}