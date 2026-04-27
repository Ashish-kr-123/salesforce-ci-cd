public class SoqlDemo {
    public static void DemoMethod(){
        
       //  1=>   SELECT Id,Name,(SELECT Id,Name FROM Contacts) from Account
       //  2=>   SELECT Id, Name ,(SELECT Id,Name FROM Book_histories__r) FROM Book__c
       //  3=>   SELECT Id,Name,Account.Id,Account.Name FROM Contact limit 5
       //  4=>   SELECT FIELDS(ALL) , Book__r.Id,  Book__r.Name FROM Book_history__c limit 5
       //  5=>   SELECT Id , NAME FROM Account 
       //        WHERE ID NOT IN (SELECT AccountId FROM Contact)
      //  6=>    
       //  SELECT Amount,Name  FROM Opportunity WHERE Amount !=null    ORDER BY  Amount DESC  LIMIT 1 OFFSET 1
       /*  List<Contact> listOfContacts = [SELECT FirstName, LastName FROM Contact limit 2];
        for(Contact con : listOfContacts) {
            String fullName = 'First Name: ' + con.FirstName + ', Last Name: ' + con.LastName;
            System.debug(fullName); 
        } */
    }
}