import { LightningElement } from 'lwc';

export default class AccountSearchParent extends LightningElement {
    accounts =[];

    handleSearch(event){
        this.accounts = event.detail;
    }
}