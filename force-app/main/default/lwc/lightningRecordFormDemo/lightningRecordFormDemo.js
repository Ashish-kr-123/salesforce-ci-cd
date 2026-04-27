import { LightningElement, api } from 'lwc';
import NAME_FIELD from '@salesforce/schema/Contact.Name';
import PHONE_FIELD from '@salesforce/schema/Contact.Phone';
import EMAIL from '@salesforce/schema/Contact.Email';


export default class LightningRecordFormDemo extends LightningElement {
    fields =[NAME_FIELD, PHONE_FIELD, EMAIL]

    @api objectApiName;
    @api recordId;

}