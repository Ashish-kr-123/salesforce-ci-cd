trigger ContactRol1 on Contact (after update) {
    
    List<Contact> aset=new List<Contact>();
    for(Contact com:trigger.new)
    
    {
        
       if(com.lastName!=null  && com.LastName!=trigger.oldMap.get(com.Id).lastName)
       {
           Contact con=new Contact();
           con.id=com.id;
           con.Description=trigger.oldMap.get(con.Id).lastName;
               aset.add(con);
       }
 
        
    }
    if(!aset.isEmpty())
    {
        update aset;
    }


}