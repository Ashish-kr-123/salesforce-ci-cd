public class DemoSObjects {
    public static void demoMethod(){
        list<account> acclist = new list<account>();
        Set<Id> accIds = new Set<Id>();
        //acclist = [SELECT Id, Name from account limit 4];
        
        //if(!acclist.isEmpty()){
           for(account acc : [SELECT Id, Name from account limit 4]){
            accIds.add(acc.Id);
           } 
        //}
        if(!accIds.isEmpty()){
            for(Id i : accIds)
            system.debug('i=' +i);
        }
        //system.debug('accids ='+accIds);
    }
}