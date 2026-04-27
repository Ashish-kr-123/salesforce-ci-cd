import { LightningElement, api, wire, track } from 'lwc';
import getTimesheet from '@salesforce/apex/timesheetController.getTimesheet';
import getTimesheetsByMonthYear from '@salesforce/apex/timesheetController.getTimesheetsByMonthYear';
import submitForApproval from '@salesforce/apex/timesheetController.submitForApproval';
import { refreshApex } from '@salesforce/apex';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class TimesheetRecords extends LightningElement {
    @api month;
    @api year;
    @track timesheets = [];
    @track noRecords = false;
    selectedRecordId = null;
    wiredLastFiveResult;
    wiredFilteredResult;

    @wire(getTimesheet)     // defult 5 rec
    wiredLastFive(result) {
        this.wiredLastFiveResult = result;
        if (!this.month && !this.year) {
            if (result.data && result.data.length > 0) {
                this.noRecords = false;
                this.timesheets = result.data.map(rec => ({
                    ...rec,
                    isSubmitted: rec.Status__c === 'Submitted'
                }));
            } else {
                this.noRecords = true;
                this.timesheets = [];
            }
        }
    }

    @wire(getTimesheetsByMonthYear, { month: '$month', year: '$year' })   // Filter by Month and Year
    wiredFiltered(result) {
        this.wiredFilteredResult = result;
        if (this.month && this.year) {
            if (result.data && result.data.length > 0) {
                this.noRecords = false;
                this.timesheets = result.data.map(rec => ({
                    ...rec,
                    isSubmitted: rec.Status__c === 'Submitted'
                }));
            } else {
                this.noRecords = true;
                this.timesheets = [];
            }
        }
    }

    handleRadioChange(event) {
        this.selectedRecordId = event.target.dataset.id;
        console.log('event...:...', event);
        const selectedRecord = this.timesheets.find(ts => ts.Id === this.selectedRecordId);

        if (selectedRecord) {
            console.log('Selected record:', selectedRecord.Id);
            
            this.dispatchEvent(new CustomEvent('recordselect', {
                detail: {
                    timesheetId: selectedRecord.Id,
                    startDate: selectedRecord.Week_Start_Date__c,
                    endDate: selectedRecord.Week_End_Date__c
                }
            }));
        }
    }


    handleActionClick(event) {
        const recordId = event.target.dataset.id;
        console.log('Action clicked for record:', recordId);

        if (!recordId) return;

        submitForApproval({ timesheetId: recordId })
            .then(() => {
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Submitted for Approval',
                        message: 'Timesheet sent for approval successfully!',
                        variant: 'success'
                    })
                );

                // Refresh records to show updated status
                if (this.month && this.year) {
                    refreshApex(this.wiredFilteredResult);
                } else {
                    refreshApex(this.wiredLastFiveResult);
                }
            })
            .catch(error => {
                console.error('Error submitting for approval:', error);
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Error',
                        message: error.body ? error.body.message : 'Submission failed.',
                        variant: 'error'
                    })
                );
            });
    }

}