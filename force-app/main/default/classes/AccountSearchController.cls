public with sharing class AccountSearchController {
    @AuraEnabled (cacheable=true)
    public static list<Account> SearchAccounts(string name, string rating, string type, string industry){
        string query = 'Select Id, Name, Rating, Type, Industry from Account where ';
        list<string> conditions = new list<string>();

        if (String.isNotBlank(name)) {
            conditions.add('Name LIKE \'%' + String.escapeSingleQuotes(name) + '%\'');
        }

        if (string.isNotBlank(rating)){
            conditions.add('Rating = \'' + String.escapeSingleQuotes(rating) + '\'');
        }
        
        if(string.isNotBlank(type)){
            conditions.add('Type = \'' + String.escapeSingleQuotes(type) + '\'');
        }
        
        if(string.isNotBlank(industry)){
            conditions.add('Industry = \'' + String.escapeSingleQuotes(industry) + '\'');
        }

        if(conditions.isEmpty()){
            return new list<account>();
        }

        query += String.join(conditions, ' AND ');
        system.debug('query----'+ query);
           // return new list<account>();
        system.debug('query----'+ database.query(query));

        return database.query(query);
    }
}