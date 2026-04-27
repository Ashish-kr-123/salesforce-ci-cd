trigger TaskTrigger on Task (before insert) {
      // whenever a task is creted set priority as high
      
    if(Trigger.isInsert && Trigger.isBefore){
        for(Task taskRecord : Trigger.New){
            System.debug('found task Record');
            taskRecord.Priority = 'High';
        }
    }
}