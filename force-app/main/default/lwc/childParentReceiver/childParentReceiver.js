import { LightningElement } from 'lwc';

export default class ChildParentReceiver extends LightningElement {
    receivedMessage;

    handleChildEvent(event){
        console.log('Received from child:', event.detail);
        this.receivedMessage = event.detail;
    }
}