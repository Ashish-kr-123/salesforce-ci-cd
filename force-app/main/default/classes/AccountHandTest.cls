@IsTest
public class AccountHandTest {
    @IsTest
    public static void testAccountRatingHot() {
        
        Account abc = new account(Name = 'Test Account', Rating = 'Hot');
        
        Test.startTest();
        insert abc;
        Test.stopTest();
        
        Account abcd = [select Description FROM Account where Id =: abc.Id];
        system.assertEquals('Hot', abcd.Description, 'Description should be set to the rating value when rating is Hot.');
        
        
    }
}