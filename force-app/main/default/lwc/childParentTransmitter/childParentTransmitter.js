import { LightningElement } from 'lwc';

export default class ChildParentTransmitter extends LightningElement {
    childMsg = 'this message is from child to parrent';

    handlebuttonclick(){
        const event = new CustomEvent('childevent', {detail: this.childMsg});
        this.dispatchEvent(event);
    }
}