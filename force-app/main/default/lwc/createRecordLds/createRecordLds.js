import { LightningElement, track } from 'lwc';
import { createRecord } from 'lightning/uiRecordApi';
import ACCOUNT_OBJECT from '@salesforce/schema/Account';
import NAME_FIELD from '@salesforce/schema/Account.Name';
import INDUSTRY_FIELD from '@salesforce/schema/Account.Industry';
import ANNUAL_REVENUE_FIELD from '@salesforce/schema/Account.AnnualRevenue';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class CustomCreateAccount extends LightningElement {
  accName = '';
  industry = '';
  annualRevenue;

  handleInputChange(event) {
    const field = event.target.name;
    const value = event.target.value;
    console.log(`[handleInputChange] field: ${field}, value: `, value);

    if (field === 'accName') {
      this.accName = value;
    } else if (field === 'industry') {
      this.industry = value;
    } else if (field === 'revenue') {
      this.annualRevenue = value;
    }

    // Optional: log current state of all fields:
    console.log('[handleInputChange] current state → accName:', this.accName,
                ' industry:', this.industry,
                ' annualRevenue:', this.annualRevenue);
  }

  handleCreate() {
    console.log('[handleCreate] invoked');

    // Build fields map
    const fields = {};
    fields[NAME_FIELD.fieldApiName] = this.accName;
    fields[INDUSTRY_FIELD.fieldApiName] = this.industry;
    fields[ANNUAL_REVENUE_FIELD.fieldApiName] = this.annualRevenue;

    const recordInput = {
      apiName: ACCOUNT_OBJECT.objectApiName,
      fields
    };

    console.log('[handleCreate] recordInput:', recordInput);

    createRecord(recordInput)
      .then(account => {
        console.log('[createRecord] success response:', account);

        this.dispatchEvent(
          new ShowToastEvent({
            title: 'Success',
            message: `Account created with Id: ${account.id}`,
            variant: 'success'
          })
        );
        // optionally reset fields
        this.accName = '';
        this.industry = '';
        this.annualRevenue = null;

        console.log('[handleCreate] after reset state → accName:', this.accName,
                    ' industry:', this.industry,
                    ' annualRevenue:', this.annualRevenue);
      })
      .catch(error => {
        console.error('[createRecord] error response:', error);
        this.dispatchEvent(
          new ShowToastEvent({
            title: 'Error creating Account',
            message: error.body?.message || error.message,
            variant: 'error'
          })
        );
      });
  }
}