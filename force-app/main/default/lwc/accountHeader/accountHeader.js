import { LightningElement, api, wire } from 'lwc';
import{ getRecord, getFieldValue } from 'lightning/uiRecordApi';
import NAME from '@salesforce/schema/Account.Name';
import INDUSTRY from '@salesforce/schema/Account.Industry';

const FIELDS = [NAME, INDUSTRY];

export default class AccountHeader extends LightningElement {

    @api recordId;
    @wire(getRecord, {recordId: '$recordId', fields: FIELDS})
        account;

    get name(){
        console.log('hiii',this.account.data);
        return getFieldValue(this.account.data, NAME);
        
        
    }
    
    get industry(){
        return getFieldValue(this.account.data, INDUSTRY);
    }
}