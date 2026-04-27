import { LightningElement, track } from 'lwc';

export default class TimesheetParent extends LightningElement {
    @track selectedMonth;
    @track selectedYear;
    @track selectedStartDate;
    @track selectedEndDate;
    @track selectedTimesheetId;
    @track selectedWorkingDay;

    handleFilterChange(event) {
        this.selectedMonth = event.detail.month;
        this.selectedYear = event.detail.year;
    }

    handleRecordSelect(event) {
        this.selectedStartDate = event.detail.startDate;
        this.selectedEndDate = event.detail.endDate;
        this.selectedTimesheetId = event.detail.timesheetId;
        console.log('Selected start-end date : ', this.selectedStartDate, this.selectedEndDate);
    }

    handleDaySelect(event){
        this.selectedWorkingDay = event.detail.date;
        console.log('Working Day selected in parent:', this.selectedWorkingDay);
    }

    handleTimecardSaved() {
        console.log('New timecard saved — refreshing list...');
        const recordsComp = this.refs.timecardRecords;
        if (recordsComp) {
            recordsComp.refreshRecords(); // correct method name
        }
    }

    get showWorkingDays(){
        return this.selectedStartDate && this.selectedEndDate;
    }

    get showTimeCard(){
        return this.selectedWorkingDay;
    }
}