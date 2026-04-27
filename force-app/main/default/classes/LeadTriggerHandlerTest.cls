@IsTest
public class LeadTriggerHandlerTest {
    @IsTest
    static void TestTaskCreationAfterLeadInsert(){
         
                Lead ld = new Lead(
                    FirstName = 'Test',
                    LastName = 'Lead',
                    Company = 'TestCo',
                    Status = 'Open - Not Contacted'
                    
                );
                insert ld;
        
         Task t = [SELECT Id, WhoId,  Priority, Description, Status, Subject FROM Task WHERE WhoId = :ld.Id LIMIT 1];
        
         System.assertEquals(ld.Id, t.WhoId, 'Task should be related to the Lead');
         //System.assertEquals(ld.OwnerId, t.OwnerId, 'Task owner should match Lead owner');
         System.assertEquals('High', t.Priority, 'Task priority should be High');
         System.assertEquals('Not Started', t.Status, 'Task status should be Not started');
         System.assertEquals('Follow up with the new lead', t.Description, 'Task description');
         System.assertEquals('follow up', t.Subject, 'Task subject should be follow up');
    }
}