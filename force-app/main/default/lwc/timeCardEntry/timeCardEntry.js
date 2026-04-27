import { LightningElement , api, track, wire} from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent'; 
import { getObjectInfo, getPicklistValues } from 'lightning/uiObjectInfoApi';
import TIMECARD_OBJECT from '@salesforce/schema/TimeCard__c';
import TASKNAME_FIELD from '@salesforce/schema/TimeCard__c.Task_Name__c';
import STATUS_FIELD from '@salesforce/schema/TimeCard__c.Status__c';
import saveTimecards from '@salesforce/apex/timesheetController.saveTimecards';

export default class TimeCardEntry extends LightningElement {
    @api selectedDate;
    @api timesheetId;
    @track timecards= [];

    taskNameOptions=[];
    statusOptions=[];

    @wire(getObjectInfo, {objectApiName: TIMECARD_OBJECT})
    objectInfo;
   
    @wire(getPicklistValues, { 
        recordTypeId: '$objectInfo.data.defaultRecordTypeId', 
        fieldApiName: TASKNAME_FIELD 
    })
    wireTaskName({ error, data }) {
        if (data) {
            this.taskNameOptions = data.values;
        }
    }

    @wire(getPicklistValues,{
        recordTypeId: '$objectInfo.data.defaultRecordTypeId',
        fieldApiName: STATUS_FIELD
    })
    wireStatus({error, data}) {
        if(data){
            this.statusOptions = data.values;
        }
    }

    connectedCallback(){
        this.addTimecard();
    }

    addTimecard(){
        this.timecards=[
            ...this.timecards,
            {
                id: Date.now(),
                taskName: '',
                status: '',
                hours: '',
                userStory: ''
            }
        ];
        console.log('Timecards row added_id: ', JSON.stringify(this.timecards));
    }

    removeTimecard(event){
        const id = Number(event.currentTarget.dataset.id);  //dataset values (strings), but tc.id =(Date.now() gives a number).
        console.log('Delete clicked for id:', id);
        console.log('Timecards before delete:', JSON.stringify(this.timecards));

        if(this.timecards.length <= 1){
            this.showToast('Info', 'At least one row must remain.', 'info');
            return;
        }

        this.timecards = this.timecards.filter(tc => tc.id !== id);
        console.log('Timecards after delete:', JSON.stringify(this.timecards));
    }

    handleChange(event){
        const id = Number(event.currentTarget.dataset.id);
        const field = event.target.name;
        const value = event.target.value;

        this.timecards= this.timecards.map(tc =>{
            if(tc.id == id){
                return{ ...tc, [field]: value};
            }
            return tc;
        });
    }

    handleSave(){

        // Validate all inputs visually
        const allInputs = this.template.querySelectorAll('lightning-input, lightning-combobox');
        let allValid = true;

        allInputs.forEach(input => {
            if (!input.checkValidity()) {
                input.reportValidity(); // highlights the field in red
                allValid = false;
            }
        });

        if (!allValid) {
            this.showToast(
                'Validation Error',
                'Please fill in all required fields before saving.',
                'error'
            );
            return;
        }

        const recordsToSave = this.timecards.map(tc => ({
            Task_Name__c: tc.taskName,
            Status__c: tc.status,
            Hours__c: tc.hours,
            User_Story__c: tc.userStory,
            Date__c: this.selectedDate, // Add date from parent
            TimeSheet_Name__c: this.timesheetId // add id from parent
        }));

        console.log('Saving records:', JSON.stringify(recordsToSave));

        saveTimecards({ timecards: recordsToSave })
            .then(() => {
                console.log('Records saved successfully');

                this.showToast(
                    'Success',
                    'Timecard(s) saved successfully!',
                    'success'
                );

                // Dispatch event to notify parent
                this.dispatchEvent(new CustomEvent('timecardsaved'));

                // Reset to a single empty row
                this.timecards = [];
                this.addTimecard();             
            })
            .catch(error => {
                console.error('Error saving timecards:', error);

                this.showToast(
                    'Error',
                    error.body?.message || 'Error saving timecards.',
                    'error'
                );
            });
    }

    showToast(title, message, variant) {
        this.dispatchEvent(
            new ShowToastEvent({
                title,
                message,
                variant
            })
        );
    }

}