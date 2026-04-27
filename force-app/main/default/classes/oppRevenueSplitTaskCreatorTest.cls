@IsTest
public class oppRevenueSplitTaskCreatorTest {
    @IsTest
    static void oppRevenueTaskCreationTest(){
        opportunity opp = new opportunity(
        Name = 'test opportunity',
        CloseDate= system.today().addDays(30),
        StageName= 'Prospecting'
        );
        insert opp;
        system.debug('opp1..:' + opp);
        test.startTest();
        opp.StageName = 'closed won';
        update opp;
        system.debug('opp2..:' + opp);
        test.stopTest();
       
       Task newtsk = [Select Id from task where whatId = :opp.Id limit 1];
        system.debug('newTsk--'+newtsk);
        System.assertEquals(opp.StageName, 'closed won');
       // System.assertEquals('split the revenue', tsk[0].subject, 'One task should be created.');
    }

}