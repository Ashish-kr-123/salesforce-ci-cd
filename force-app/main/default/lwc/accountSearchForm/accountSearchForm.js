import { LightningElement } from 'lwc';
import searchAccounts from '@salesforce/apex/AccountSearchController.SearchAccounts';

export default class AccountSearchForm extends LightningElement {
    name = '';
    rating = '';
    type = '';
    industry = '';

    get ratingOptions(){
        return[
            {label: 'Hot', value: 'Hot'},
            {label: 'Warm', value: 'Warm'},
            {label: 'Cold', value: 'Cold'}
        ]
    }

    get typeOptions(){
        return[
            {label: 'Prospect', value: 'Prospect'},
            {label: 'Customer', value: 'Customer'},
            {label: 'Partner', value: 'Partner'},
            {label: 'Competitor', value: 'Competitor'}
        ]
    }

    get industryOptions(){
        return[
            {label: 'Agriculture', value: 'Agriculture'},
            {label: 'Energy', value: 'Energy'},
            {label: 'Finance', value: 'Finance'},
            {label: 'Healthcare', value: 'Healthcare'},
            {label: 'Manufacturing', value: 'Manufacturing'},
            {label: 'Technology', value: 'Technology'},
            {label: 'Transportation', value: 'Transportation'},
            {label: 'Banking', value: 'Banking'},
            {label: 'Insurance', value: 'Insurance'}
        ]
    }

    handleNameChange(event){
        this.name = event.target.value;
        console.log('Name: ' + this.name);
    }

    handleRatingChange(event){
        this.rating = event.target.value;
        console.log('Rating: ' + this.rating);
    }

    handleTypeChange(event){
        this.type = event.target.value;
        console.log('Type: ' + this.type);
    }
    
    handleIndustryChange(event){
        this.industry = event.target.value;
        console.log('Industry: ' + this.industry);
    }

    handleSearch() {
        searchAccounts({ name: this.name, rating: this.rating, type: this.type, industry: this.industry })
            .then(result => {
                console.log('Accounts:', JSON.stringify(result));
                const searchEvent = new CustomEvent('search', { detail: result });
                console.log('Search Event:', searchEvent);
                this.dispatchEvent(searchEvent);
            })
            .catch(error => {
                console.error('Error fetching accounts:', error);
            });
    }
}