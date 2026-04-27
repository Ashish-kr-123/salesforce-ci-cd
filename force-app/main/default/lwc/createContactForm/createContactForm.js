import { LightningElement, track } from 'lwc';
import createContact from '@salesforce/apex/ContactCreateCont.createContact';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class CreateContactForm extends LightningElement {
    @track firstName = '';
    @track lastName = '';
    @track email = '';

    handleInputChange(event) {
        const field = event.target.name;
        this[field] = event.target.value;
    }

    handleSubmit() {
        const contactInput = {
            FirstName: this.firstName,
            LastName: this.lastName,
            Email: this.email
        };

        createContact({ newContact: contactInput })
            .then((result) => {
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Success',
                        message: `Contact ${result.FirstName} ${result.LastName} created successfully!`,
                        variant: 'success'
                    })
                );
                /* Optionally, reset form fields
                this.firstName = '';
                this.lastName = '';
                this.email = '';*/
            })
            .catch((error) => {
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Error creating contact',
                        message: error.body ? error.body.message : error.message,
                        variant: 'error'
                    })
                );
            });
    }
}