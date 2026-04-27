import { LightningElement, api } from 'lwc';

export default class AccountSearchResults extends LightningElement {
    @api accounts;

    columns =[
        {label: 'Id', fieldName: 'Id'},
        {label: 'Name', fieldName: 'Name'},
        {label: 'Rating', fieldName: 'Rating'},
        {label: 'Type', fieldName: 'Type'},
        {label: 'Industry', fieldName: 'Industry'}
    ]
}