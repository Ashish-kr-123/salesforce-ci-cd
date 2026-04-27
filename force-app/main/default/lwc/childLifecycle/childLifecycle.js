import { LightningElement, track } from 'lwc';
import get20Accounts from '@salesforce/apex/AccountListController.get20Accounts';

export default class ChildLifecycle extends LightningElement {
    @track accounts;
    @track error;

    constructor(){
        super();
        console.log('Child: constructor called');
    }

    connectedCallback(){

        get20Accounts()
        .then(result =>{
            this.accounts = result;
            console.log('Accounts fetched:', result)
        })
        .catch(error =>{
            this.error = error;
            console.error('Error fetching accounts:', error)
        });
    }

    renderedCallback(){

        console.log('Child: renderedCallback called (render completed)');
    }

    disconnectedCallback(){

        console.log('Child: disconnectedCallback called (removed from DOM)');
    }

}