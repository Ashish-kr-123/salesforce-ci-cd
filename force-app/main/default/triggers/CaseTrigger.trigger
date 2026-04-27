trigger CaseTrigger on Case (before insert) {
    
    if(Trigger.isinsert && Trigger.isBefore){
        for(Case CaseRecord : Trigger.New){
            if(caseRecord.Origin == 'Phone'){
                caseRecord.Priority = 'High';
            }
            else{
                caseRecord.Priority = 'low';
            }
        }
    }

}