public class AccUponHotAfterUpdate {
    public static void accDescAfterUpdate(list<account> acclist, Map<id,Account> oldMap){
        list<account> accToUpdate = new list<account>();
        for (Account acc : acclist) {
             account oldacc = oldMap.get(acc.Id);
             if(oldAcc.rating != acc.rating){
             account UpdateAcc = new account(Id = acc.Id, Description = 'Account Rating: ' + acc.Rating);
             accToUpdate.add(UpdateAcc);                 
		}
    }
        if(!accToUpdate.isEmpty()){
        update accToUpdate;
        }
    }         
}