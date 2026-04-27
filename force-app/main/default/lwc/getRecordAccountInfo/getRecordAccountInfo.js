import { LightningElement, api, wire } from 'lwc';
import { getRecord , getFieldValue } from 'lightning/uiRecordApi';
import Name_Field from '@salesforce/schema/Account.Name';
import Phone_Field from '@salesforce/schema/Account.Phone';
import Industry_Field from '@salesforce/schema/Account.Industry';

const Fields = [Name_Field, Phone_Field, Industry_Field];

export default class GetRecordAccountInfo extends LightningElement {

    @api recordId;
    account;
    error;

    @wire (getRecord, {recordId:'$recordId' , fields: Fields })
    wiredAccount({error, data}) {
        if(data){
            this.account = data;
            this.error = undefined;
        } else if(error){
            this.error = error;
            this.account = undefined;
        }
    }

    get name() {
        return this.account ? getFieldValue(this.account, Name_Field) : '';
    }

    get phone() {
        return this.account ? getFieldValue(this.account, Phone_Field) : '';
    }

    get industry() {
        return this.account ? getFieldValue(this.account, Industry_Field) : '';
    }
}