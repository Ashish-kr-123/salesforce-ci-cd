public class listDemo {
    public static void listMethod(){
       // list<string> strlist = new list<string>();
        //list<string> strlist2 = new list<string>();
        //set<string> strset = new set<string>();
        //sObject sObj = [SELECT Id, Name from Contact limit 1];
        //boolean res;
        
        //strlist.add('india');
        //strlist.add('usa');
        //strlist.add(1,'uk'); 
        
        //strlist2.add('australia');
        //strlist2.addall(strlist);
        
        //system.debug(strlist.indexOf('uk'));
        
        //system.debug('Object ='+sObj);
        
        //system.debug('strlist ='+res);
        
        //system.debug('strlist ='+strlist);
        //system.debug('strlist2 ='+strlist2);
        //list<Account> acclist = new list<Account>();
        
        //acclist = [SELECT Id, Name from account limit 3];
        //system.debug('acclist ='+ acclist); 
        
        Integer[] myInts = new Integer[]{1, 2, 3, 4, 5, 6, 7, 8, 9, 10};
		List<Contact> accList = [SELECT Id,Name,Account.Id,Account.Name,Account.Phone,Account.Rating FROM Contact];
        System.debug(accList[0].Account.Rating);
    }
}