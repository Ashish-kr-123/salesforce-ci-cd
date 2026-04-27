import { LightningElement, track } from 'lwc';
import getLatestContacts from '@salesforce/apex/ContactController.getLatestContacts';

export default class ContactList extends LightningElement {
    @track contacts;
    @track error;

    connectedCallback(){
        getLatestContacts()
            .then(result => {
                this.contacts = result;
                this.error = undefined;
            })
            .catch(error => {
                this.error = error;
                this.contacts = undefined;
            });
    }
}