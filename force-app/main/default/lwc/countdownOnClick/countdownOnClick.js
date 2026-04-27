import { LightningElement, track } from 'lwc';

export default class CountdownOnClick extends LightningElement {
    @track isRunning = false;
    @track hasCompleted = false;
    @track seconds = 0;
    timerId;

    connectedCallback() {
        console.log('Child: connectedCallback');
    }

    renderedCallback() {
        console.log('Child: renderedCallback, seconds =', this.seconds);
        if (this.isRunning && this.seconds === 0){
            this.stopTimer();
            this.hasCompleted = true;
            this.isRunning = false;
        console.log('Child: countdown completed');
        }
    }

    disconnectedCallback() {
        console.log('Child: disconnectedCallback');
        this.cleanupTimer();
    }

    startCountdown(){
        if(this.isRunning) return;

        this.seconds = 10;
        this.hasCompleted = false;
        this.isRunning = true;
        console.log('Child: startCountdown');

        this.timerId = setInterval(() => {
            if(this.seconds > 0){
                this.seconds--;
            }
            console.log('Child: tick, seconds =', this.seconds);
        }, 1000);
    }

    stopTimer(){
        if(this.timerId){
            clearInterval(this.timerId);
            this.timerId = null;
            console.log('Child: stopTimer');
        }
    }

    cleanupTimer(){
        this.stopTimer();
    }

    get showStartButton() {
        return !this.isRunning && !this.hasCompleted;
    }

    get showCountdown() {
        return this.isRunning;
    }

    get showCompletedMessage() {
        return this.hasCompleted;
    }
    

}