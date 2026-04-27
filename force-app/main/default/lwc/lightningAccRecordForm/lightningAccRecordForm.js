import { LightningElement } from 'lwc';
import {ShowToastEvent} from 'lightning/platformShowToastEvent';
import ACCOUNT_OBJECT from '@salesforce/schema/Account';
import NAME_FIELD from '@salesforce/schema/Account.Name';
import INDUSTRY_FIELD from '@salesforce/schema/Account.Industry';
import ANNUAL_REVENUE_FIELD from '@salesforce/schema/Account.AnnualRevenue';

export default class LightningAccRecordForm extends LightningElement {

    objectApiName = ACCOUNT_OBJECT;
    fields = [NAME_FIELD, INDUSTRY_FIELD, ANNUAL_REVENUE_FIELD];

    recordId = null;

    handleSuccess(event) {
        const toast = new ShowToastEvent({
            title: 'Account Created',
            message: 'Record ID: ' + event.detail.id,
            variant: 'success'
        });
        this.dispatchEvent(toast);

        this.resetForm();
    }

    handleError(event) {
        const toast = new ShowToastEvent({
            title: 'Error creating Account',
            message: event.detail.message,
            variant: 'error'
        });
        this.dispatchEvent(toast);
    }

    resetForm() {
        
        const form = this.template.querySelector('lightning-record-form');
        if (form) {
            form.recordId = null;
        }
    }
}