trigger updateAccRecDesc on Contact (after update) {
    set<Id> accIds = new set<Id>();
    if(trigger.isafter && trigger.isupdate){
        if(!trigger.new.isEmpty()){
            for(contact conObj : trigger.new){
                if(conObj.AccountId != null && (conobj.Description != trigger.oldMap.get(conObj.Id).Description)){
                    accIds.add(conObj.AccountId);
                }
            }
        }
    }
    system.debug('accids....' + accIds);
    if (!accIds.isEmpty()){
        AccDescUponConDesc.updateAccDesc(accIds);
    }   
}