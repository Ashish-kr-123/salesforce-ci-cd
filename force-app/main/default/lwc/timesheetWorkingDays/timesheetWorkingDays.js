import { LightningElement, api, track } from 'lwc';

export default class timesheetWorkingDays extends LightningElement {
    @track workingDays = [];

    @api
    set startDate(value) {
        this._startDate = value;
        this.calculateDays();
    }
    get startDate() {
        return this._startDate;
    }

    @api
    set endDate(value){
        this._endDate = value;
        this.calculateDays();
    }
    get endDate(){
        return this._endDate;
    }

    calculateDays(){
        if(this._startDate && this._endDate){
            this.generateWorkingDays(this._startDate , this._endDate);
        }
    }

    generateWorkingDays(start, end) {
        let days = [];
        let current = new Date(start);
        let endDate = new Date(end);

        while (current <= endDate) {
            let day = current.getDay(); // 0 = Sun, 6 = Sat
            if (day !== 0 && day !== 6) {
                const isoDate = current.toISOString().split('T')[0]; // yyyy-MM-dd (Salesforce format)
                const displayDate = current.toLocaleDateString('en-GB', { 
                    day: '2-digit', month: '2-digit', year: 'numeric' 
                }); // dd/MM/yyyy (for UI only)

                days.push({
                    date: isoDate,       // Correct format for backend
                    label: current.toLocaleDateString('en-US', { weekday: 'long' }),
                    displayDate: displayDate // For showing in UI if needed
                });
            }
            current.setDate(current.getDate() + 1);
        }
        this.workingDays = days;
        console.log('Generated working days : ', JSON.stringify(this.workingDays, null, 2));
    }

    handleDaySelect(event) {
        const selectedDate = event.target.dataset.date;
        console.log('Selected working day (ISO): ', selectedDate);
        
        this.dispatchEvent(new CustomEvent('dayselect',{
            detail:{date: selectedDate}
        }));
    }
}