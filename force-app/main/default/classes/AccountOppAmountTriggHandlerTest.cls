@IsTest
public class AccountOppAmountTriggHandlerTest {
    
    @TestSetup
    static void setupData() {
        // Create Accounts
        Account acc1 = new Account(Name = 'Account A');
        Account acc2 = new Account(Name = 'Account B');
        insert new List<Account>{acc1, acc2};
        
        // Create Opportunities for acc1
        List<Opportunity> opps = new List<Opportunity>{
            new Opportunity(Name = 'Opp 1', StageName = 'Prospecting', CloseDate = Date.today().addDays(30), Amount = 100, AccountId = acc1.Id),
            new Opportunity(Name = 'Opp 2', StageName = 'Prospecting', CloseDate = Date.today().addDays(30), Amount = 200, AccountId = acc1.Id)
        };
        insert opps;
    }
    
    @isTest
    static void testInsertOpportunities() {
        // Insert a new Opportunity to trigger the insert handler
        Account acc = [SELECT Id, Tot_Amount__c FROM Account WHERE Name = 'Account A' LIMIT 1];
        Opportunity newOpp = new Opportunity(
            Name = 'Opp 3', StageName = 'Prospecting',
            CloseDate = Date.today().addDays(30), Amount = 300, AccountId = acc.Id
        );

        Test.startTest();
        insert newOpp;
        Test.stopTest();

        // Assert the Tot_Amount__c reflects the sum
        acc = [SELECT Tot_Amount__c FROM Account WHERE Id = :acc.Id];
        System.assertEquals(600, acc.Tot_Amount__c, 'Total amount after insert should be 600');
    }
    
    @isTest
    static void testDeleteOpportunities() {
        // Delete an opportunity and check handler logic
        Account acc = [SELECT Id, Tot_Amount__c FROM Account WHERE Name = 'Account A' LIMIT 1];
        system.debug('acc..:..'+ acc);
        
        Opportunity toDelete = [SELECT Id, amount FROM Opportunity WHERE AccountId = :acc.Id ORDER BY Amount ASC LIMIT 1];
        system.debug('opp..:..'+ toDelete);
        Test.startTest();
        delete toDelete;
        Test.stopTest();

        acc = [SELECT Tot_Amount__c FROM Account WHERE Id = :acc.Id];
        system.debug('acc..:..'+ acc);
        System.assertEquals(200, acc.Tot_Amount__c, 'Total amount after delete should be 200');
    }
     @isTest
    static void testUpdateOpportunities() {
        // Update an opportunity’s amount
        Account acc = [SELECT Id FROM Account WHERE Name = 'Account A' LIMIT 1];
         Account acc1 = [SELECT Id FROM Account WHERE Name = 'Account B' LIMIT 1];
        Opportunity oppToUpdate = [SELECT Id, Amount FROM Opportunity WHERE AccountId = :acc.Id ORDER BY Amount ASC LIMIT 1];
        oppToUpdate.AccountId = acc1.Id;

        Test.startTest();
        update oppToUpdate;
        Test.stopTest();

        acc = [SELECT Tot_Amount__c FROM Account WHERE Id = :acc.Id];
        acc1 = [SELECT Tot_Amount__c FROM Account WHERE Id = :acc1.Id];
        System.assertEquals(200, acc.Tot_Amount__c, 'Total amount after update should be 200');
        System.assertEquals(100, acc1.Tot_Amount__c, 'Total amount after update should be 100');
    }
    
     @isTest
    static void testBulkScenario() {
        list<account> accs = [select id from account where name= 'acc2'];
        
        list<opportunity> bulkopps = new list<opportunity>();
        for(account a : accs){
            for(integer i=0; i< 5; i++){
                opportunity opp = new opportunity();
                opp.Name = 'BulkOpp' + i;
                opp.StageName = 'Prospecting';
                opp.CloseDate = Date.today().addDays(30);
                opp.Amount = 100 * (i + 1);
                opp.AccountId = a.Id;
                bulkopps.add(opp);
            }
        }
        Test.startTest();
        insert bulkOpps;
        Test.stopTest();
        
        for(account b : accs){
            b = [select id, Tot_Amount__c from account where id = :b.id];
            Integer expectedSum = 100 + 200 + 300 + 400 + 500;
            System.assertEquals(expectedSum, b.Tot_Amount__c, 'Total ammount for account is 1500');
        }
    }
}