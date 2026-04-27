public with sharing class timesheetController {
    @AuraEnabled(cacheable=true)
    public static list<Timesheet__c> getTimesheet() {
        List<Timesheet__c> timesheets = [SELECT Id, Name, Week_Start_Date__c, Week_End_Date__c, Status__c
                from Timesheet__c
                ORDER BY CreatedDate DESC
                LIMIT 5];

                System.debug('Number of timesheets retrieved: ' + timesheets.size());
                System.debug('Timesheets List: ' + timesheets);

                return timesheets;
    }

    @AuraEnabled(cacheable=true)
    public static List<Timesheet__c> getTimesheetsByMonthYear(String month, String year) {
        return [
            SELECT Id, Name, Week_Start_Date__c, Week_End_Date__c, Status__c
            FROM Timesheet__c
            WHERE Month__c = :month
              AND Year__c = :year
        ];
    }

    @AuraEnabled
    public static void saveTimecards(List<TimeCard__c> timecards) {
        if (timecards == null || timecards.isEmpty()) {
            throw new AuraHandledException('No timecards to save.');
        }
        try {
            insert timecards;
        } catch (Exception e) {
            throw new AuraHandledException('Error saving timecards: ' + e.getMessage());
        }
    }

    @AuraEnabled(cacheable=true)
    public static List<TimeCard__c> getTimecards() {
        try {
            return [
                SELECT Id, Name, Task_Name__c, Status__c, Hours__c, CreatedDate, TimeSheet_Name__r.Name
                FROM TimeCard__c
                ORDER BY CreatedDate DESC
                LIMIT 10
            ];
        } catch (Exception ex) {
            throw new AuraHandledException('Error retrieving TimeCards: ' + ex.getMessage());
        }
    }

    @AuraEnabled
    public static void submitForApproval(Id timesheetId) {
        // Query the record
        Timesheet__c ts = [SELECT Id, Status__c FROM Timesheet__c WHERE Id = :timesheetId LIMIT 1];

        // Update the status to trigger approval entry criteria
        ts.Status__c = 'Open';
        update ts;

        // Create approval request
        Approval.ProcessSubmitRequest req = new Approval.ProcessSubmitRequest();
        req.setComments('Submitted via LWC');
        req.setObjectId(ts.Id);

        Approval.ProcessResult result = Approval.process(req);

        if (result.isSuccess()) {
            System.debug('Approval process started successfully for record: ' + ts.Id);
        } else {
            throw new AuraHandledException('Error submitting for approval: ' + result.getErrors());
        }
    }

}