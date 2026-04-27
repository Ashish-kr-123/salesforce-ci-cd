import { LightningElement, track } from 'lwc';

export default class ParentLifecycle extends LightningElement {
    @track showChild = true;

    toggleChild() {
        this.showChild = !this.showChild;
    }
    
     get buttonLabel() {
        return this.showChild ? 'Hide Child' : 'Show Child';
    }
}