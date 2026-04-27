public class AccountHand {
    public static void ChangeRating(list<Account> acc){
        
        for(Account abc : acc){
            
            if(abc.Rating != NULL && abc.Rating == 'Hot')
            {
                
				abc.description=abc.Rating;                
                
            }
            
        }  
    }
}