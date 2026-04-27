import { LightningElement, wire, track, api} from 'lwc';
import { refreshApex } from '@salesforce/apex';
import getTimecards from '@salesforce/apex/timesheetController.getTimecards';

export default class TimeCardRecords extends LightningElement {
    @track timecardList = [];
    wiredTimecardsResult;

    columns = [
        { label: 'TimeCard Name', fieldName: 'Name' },
        { label: 'TimeSheet Name', fieldName: 'timesheetName' },
        { label: 'Status', fieldName: 'Status__c' },
        { label: 'Task Name', fieldName: 'Task_Name__c' },
        { label: 'Hours', fieldName: 'Hours__c' },
        { label: 'Created Date', fieldName: 'CreatedDate' }
    ];

     @wire(getTimecards)
    wiredTimecards(result) {
        this.wiredTimecardsResult = result; // store reference for refresh
        const { data, error } = result;

        if (data) {
            // Map related field
            this.timecardList = data.map(tc => ({
                ...tc,
                timesheetName: tc.TimeSheet_Name__r ? tc.TimeSheet_Name__r.Name : ''
            }));
        } else if (error) {
            console.error('Error fetching timecards:', error);
        }
    }

    // Public method to refresh list
    @api refreshRecords() {
        console.log('Refreshing timecard records...');
        if (this.wiredTimecardsResult) {
            refreshApex(this.wiredTimecardsResult);
        }
    }

   
    
}