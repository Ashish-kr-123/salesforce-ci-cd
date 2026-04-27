import { LightningElement, api, track } from 'lwc';
import { updateRecord } from 'lightning/uiRecordApi';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { refreshApex } from '@salesforce/apex';

// Import schema for fields
import ACCOUNT_ID from '@salesforce/schema/Account.Id';
import ACCOUNT_NAME from '@salesforce/schema/Account.Name';
import ACCOUNT_INDUSTRY from '@salesforce/schema/Account.Industry';
import ACCOUNT_RATING from '@salesforce/schema/Account.Rating';

export default class UpdateRecordLds extends LightningElement {
  @api recordId; // Automatically set when placed on a record page
  @track name = '';
  @track industry = '';
  @track rating = '';

  handleChange(event) {
    const field = event.target.name;
    if (field === 'name') {
      this.name = event.target.value;
    } else if (field === 'industry') {
      this.industry = event.target.value;
    } else if (field === 'rating') {
      this.rating = event.target.value;
    }
  }

  handleSave() {
    const fields = {};
    fields[ACCOUNT_ID.fieldApiName] = this.recordId;
    fields[ACCOUNT_NAME.fieldApiName] = this.name;
    fields[ACCOUNT_INDUSTRY.fieldApiName] = this.industry;
    fields[ACCOUNT_RATING.fieldApiName] = this.rating;

    const recordInput = { fields };

    updateRecord(recordInput)
      .then((record) => {
        this.dispatchEvent(
          new ShowToastEvent({
            title: 'Success',
            message: 'Account updated',
            variant: 'success'
          })
        );
        // Optionally refresh parts of UI, reset inputs, etc.
      })
      .catch((error) => {
        this.dispatchEvent(
          new ShowToastEvent({
            title: 'Error updating record',
            message: error.body ? error.body.message : 'Unknown error',
            variant: 'error'
          })
        );
      });
  }
}