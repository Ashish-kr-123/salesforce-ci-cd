import { LightningElement, api, wire} from 'lwc';
import { getPicklistValues, getObjectInfo } from 'lightning/uiObjectInfoApi';
import ACCOUNT_OBJECT from '@salesforce/schema/Account';
import INDUSTRY_FIELD from '@salesforce/schema/Account.Industry';

export default class AccountIndustryPicklist extends LightningElement {
    @api recordTypeId;
    rtId;

    @wire(getObjectInfo, { objectApiName: ACCOUNT_OBJECT })
    objInfo({data}){
        if(data){
            this.rtId = this.recordTypeId || data.defaultRecordTypeId;
        }
    }

    @wire(getPicklistValues, { recordTypeId: '$rtId', fieldApiName: INDUSTRY_FIELD })
    industryValues;

    get options(){
        return this.industryValues.data?.values || [];
    }
}