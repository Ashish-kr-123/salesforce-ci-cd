import { LightningElement, wire, track } from 'lwc';
import get20Accounts from '@salesforce/apex/AccountListController.get20Accounts';
import DeleteAccountById from '@salesforce/apex/AccountListController.DeleteAccountById';
import { refreshApex } from '@salesforce/apex';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class AccountList extends LightningElement {
    @track accounts = [];
    wiredAccountsResult;

    @wire(get20Accounts)
    wiredAccounts(value) {
        this.wiredAccountsResult = value;
        const { data, error } = value;
        if (data) {
            this.accounts = data;
        } else if (error) {
            this.showToast('Error', 'Error loading accounts', 'error');
        }
    }

    handleDelete(event) {
        const accountId = event.target.value;
        DeleteAccountById({ accountId })
            .then(() => {
                this.showToast('Deleted', 'Account deleted successfully', 'success');
                return refreshApex(this.wiredAccountsResult);
            })
            .catch(error => {
                console.error('Delete error', error);
                this.showToast('Error', 'Failed to delete account', 'error');
            });
    }

    showToast(title, message, variant) {
        this.dispatchEvent(new ShowToastEvent({ title, message, variant }));
    }
}