import { LightningElement, track } from 'lwc';

export default class ParentCountdownOnClick extends LightningElement {
    @track showChild = false;   

    get toggleLabel() {
        return this.showChild ? 'Hide Timer' : 'Show Timer';
    }

    toggleChild() {
        this.showChild = !this.showChild;
        console.log('Parent: toggleChild, showChild =', this.showChild);
    }
}