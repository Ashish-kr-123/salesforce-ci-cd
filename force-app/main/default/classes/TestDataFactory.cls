@IsTest
public class TestDataFactory {
     public static Account createAccountWithBilling(String name, String street,
                                                  String city, String state,
                                                  String postal, String country,
                                                  Boolean doInsert) {
        Account acc = new Account(
            Name = name,
            BillingStreet = street,
            BillingCity = city,
            BillingState = state,
            BillingPostalCode = postal,
            BillingCountry = country
        );
        if (doInsert) {
            insert acc;
        }
        return acc;
    }
    
    public static List<Contact> createContactsForAccount(Id accId, Integer count, Boolean doInsert) {
        List<Contact> contacts = new List<Contact>();
        for (Integer i = 0; i < count; i++) {
           contact con = new Contact(
                LastName = 'TestContact' + i,
                AccountId = accId
            );
            contacts.add(con);
        }
        if (doInsert && !contacts.isEmpty()) {
            insert contacts;
        }
        return contacts;
    }
    
    public static Account createAccount(String name, Boolean doInsert) {
        Account acc = new Account(Name = name);
        if (doInsert) insert acc;
        return acc;
    }

    public static Contact createContact(Account acc, String lastName, Boolean doInsert) {
        Contact c = new Contact(LastName = lastName, AccountId = acc.Id);
        if (doInsert) insert c;
        return c;
    }

}