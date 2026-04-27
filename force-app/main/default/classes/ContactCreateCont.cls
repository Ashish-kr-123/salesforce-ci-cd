public with sharing class ContactCreateCont {
    @AuraEnabled
    public static contact createContact(contact newContact) {
        insert newContact;
        return newContact;
    }
}