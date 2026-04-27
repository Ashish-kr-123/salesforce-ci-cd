import { LightningElement,api } from 'lwc';
import Name from '@salesforce/schema/Contact.Name'
import Phone from '@salesforce/schema/Contact.Phone'
import Email from '@salesforce/schema/Contact.Email'

export default class LightningRecordViewForm extends LightningElement {
    nameField = Name;
    phoneField = Phone;
    emailField = Email;

    @api objectApiName;
    @api recordId;
}