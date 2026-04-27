import { LightningElement, track } from 'lwc';
import createContact from '@salesforce/apex/SiteContactController.createContact';

export default class ContactForm extends LightningElement {
    @track firstName = '';
    @track lastName = '';
    @track email = '';
    @track message = '';

    handleFirst(event) { this.firstName = event.target.value; }
    handleLast(event) { this.lastName = event.target.value; }
    handleEmail(event) { this.email = event.target.value; }

    handleClear() {
        this.firstName = '';
        this.lastName = '';
        this.email = '';
        this.message = '';
    }

    handleSave() {
        this.message = 'Saving...';
        createContact({ firstName: this.firstName, lastName: this.lastName, email: this.email })
            .then(result => {
                this.message = 'Contact created. Id: ' + result;
                this.handleClear();
            })
            .catch(error => {
                console.error(error);
                this.message = 'Error: ' + (error.body ? error.body.message : error.message);
            });
    }
}