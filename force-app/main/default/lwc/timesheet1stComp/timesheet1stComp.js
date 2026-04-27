import { LightningElement, wire } from 'lwc';
import { getPicklistValues, getObjectInfo } from 'lightning/uiObjectInfoApi';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import TIMESHEET_OBJECT from '@salesforce/schema/TimeSheet__c';
import MONTH_FIELD from '@salesforce/schema/TimeSheet__c.Month__c';
import YEAR_FIELD from '@salesforce/schema/TimeSheet__c.Year__c'; 

export default class Timesheet1stComp extends LightningElement {
    selectedMonth = '';
    selectedYear = '';
    monthOptions = [];
    yearOptions = [];

    @wire(getObjectInfo, { objectApiName: TIMESHEET_OBJECT })
    objectInfo;

    @wire(getPicklistValues, { 
        recordTypeId: '$objectInfo.data.defaultRecordTypeId', 
        fieldApiName: MONTH_FIELD 
    })
    wireMonth({ error, data }) {
        if (data) {
            this.monthOptions = data.values;
        } else if (error) {
            console.error('Error fetching month picklist: ', error);
        }
    }

    @wire(getPicklistValues, { 
        recordTypeId: '$objectInfo.data.defaultRecordTypeId', 
        fieldApiName: YEAR_FIELD 
    })
    wireYear({ error, data }) {
        if (data) {
            this.yearOptions = data.values;
        } else if (error) {
            console.error('Error fetching year picklist: ', error);
        }
    }

    handleMonthChange(event) {
        this.selectedMonth = event.detail.value;
        console.log('Month: ' + this.selectedMonth);
    }

    handleYearChange(event) {
        this.selectedYear = event.detail.value;
        console.log('Year: ' + this.selectedYear);
    }

    handleSubmit(){

         // Validate before firing event
        if (!this.selectedMonth || !this.selectedYear) {
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Missing Fields',
                    message: 'Please select both Month and Year before submitting.',
                    variant: 'error'
                })
            );
            return; // Stop execution
        }

        const filterEvent = new CustomEvent('filterchange', {
            detail: {
                month: this.selectedMonth,
                year: this.selectedYear
            }
        });
        this.dispatchEvent(filterEvent);
    }
}