@IsTest
public class OppTriggerHandlerTest {
    @Testsetup
    static void TestDataSetup(){
         Account acc = new Account(Name = 'Test Account for Opportunity Trigger');
            insert acc;

            Opportunity opp = new Opportunity(
                Name = 'Test Opportunity',
                AccountId = acc.Id,
                StageName = 'Prospecting',
                CloseDate = Date.today().addDays(30),
                Amount = 50000
            );
            insert opp;
    }
    @IsTest
    static void  testClosedWonOpportunityTaskCreation(){
        Opportunity opp =[select Id, stageName, Amount from Opportunity where Name ='Test Opportunity' limit 1];
         opp.StageName = 'Closed Won';
         opp.Amount = 150000;
         update opp;
        
        List<Task> createdTasks = [SELECT Id, Subject, WhatId FROM Task WHERE WhatId = :opp.Id];
 
        System.assertEquals(5, createdTasks.size(), '5 tasks should be created for the Closed Won Opportunity.');
        System.assertEquals('Split Revenue1', createdTasks[0].Subject, 'Task subject should be "Split Revenue".');
        System.assertEquals(opp.Id, createdTasks[0].WhatId, 'Task should be related to the Opportunity.');
    }
     @isTest
        static void testOtherStageNameOpportunityNoTaskCreation() {

            Opportunity opp =[select Id, stageName, Amount from Opportunity where Name ='Test Opportunity' limit 1];
            opp.StageName = 'Closed lost';
            opp.Amount = 90000; 
            update opp;

            List<Task> createdTasks = [SELECT Id FROM Task WHERE WhatId = :opp.Id];

            System.assertEquals(0, createdTasks.size(), 'No task should be created if stagename is not closed won');
        }

}