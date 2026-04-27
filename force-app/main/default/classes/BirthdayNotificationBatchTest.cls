@isTest
private class BirthdayNotificationBatchTest {
    @testSetup
    static void setupData() {
        insert new Contact(LastName = 'TestUser', Birthdate = Date.today());
    }

    @isTest
    static void testBatchSchedulesAsyncJob() {
        Test.startTest();
            Id batchId = Database.executeBatch(new BirthdayNotificationBatch(), 1);
        Test.stopTest();

        AsyncApexJob job = [
            SELECT Id, Status, JobItemsProcessed, TotalJobItems, ApexClass.Name
            FROM AsyncApexJob
            WHERE Id = :batchId
        ];
        System.assertEquals('Completed', job.Status, 'Batch job should complete.');
        System.assert(job.JobItemsProcessed > 0, 'It should process at least one contact.');
        System.assertEquals('BirthdayNotificationBatch', job.ApexClass.Name);
    }
}