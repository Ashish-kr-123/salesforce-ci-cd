public with sharing class SiteContactController {
    @AuraEnabled
    public static Id createContact(String firstName, String lastName, String email) {
        // Basic validation
        if(String.isBlank(lastName) && String.isBlank(firstName)) {
            throw new AuraHandledException('Please provide at least a Last Name or First Name.');
        }

        // Replace this with a valid user Id in your org to be owner of created contacts.
        // Guest user may not be allowed to own records in recent orgs, so set to a real user.
        Id defaultOwnerId = '005gK000003jFnZQAU'; // <-- change this

        Contact c = new Contact(
            FirstName = firstName,
            LastName  = (String.isBlank(lastName) ? 'Unknown' : lastName),
            Email     = email,
            OwnerId   = defaultOwnerId
        );
        insert c;
        return c.Id;
    }
}