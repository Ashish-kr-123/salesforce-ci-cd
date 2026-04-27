import { LightningElement } from 'lwc';
import getContacts from '@salesforce/apex/ContactPaginationController.getContacts';
import getTotalContacts from '@salesforce/apex/ContactPaginationController.getTotalContacts';

export default class ServerContactPagination extends LightningElement {
    contacts = [];
    currentPage = 1;
    pageSize = 10;
    totalPages = 0;

    columns = [
        { label: 'First Name', fieldName: 'FirstName' },
        { label: 'Last Name', fieldName: 'LastName' },
        { label: 'Email', fieldName: 'Email' }
    ];

    connectedCallback() {
        console.log('✅ Component loaded, initializing pagination...');
        this.initPagination();
    }

    async initPagination() {
        console.log('📌 Fetching total number of contacts...');
        const total = await getTotalContacts();
        console.log('🔢 Total contacts:', total);

        this.totalPages = Math.ceil(total / this.pageSize);
        console.log('📄 Total pages:', this.totalPages);

        this.fetchContacts();
    }

    async fetchContacts() {
        console.log(`📥 Fetching contacts for page ${this.currentPage} (pageSize = ${this.pageSize})...`);
        this.contacts = await getContacts({
            pageSize: this.pageSize,
            pageNumber: this.currentPage
        });
        console.log('✅ Contacts fetched:', JSON.stringify(this.contacts, null, 2));
    }

    handlePrevious() {
        if (this.currentPage > 1) {
            this.currentPage--;
            console.log('⬅️ Going to previous page:', this.currentPage);
            this.fetchContacts();
        } else {
            console.log('⚠️ Already on the first page, cannot go back.');
        }
    }

    handleNext() {
        if (this.currentPage < this.totalPages) {
            this.currentPage++;
            console.log('➡️ Going to next page:', this.currentPage);
            this.fetchContacts();
        } else {
            console.log('⚠️ Already on the last page, cannot go forward.');
        }
    }

    get isPreviousDisabled() {
        console.log('🔍 isPreviousDisabled check:', this.currentPage === 1);
        return this.currentPage === 1;
    }

    get isNextDisabled() {
        console.log('🔍 isNextDisabled check:', this.currentPage === this.totalPages);
        return this.currentPage === this.totalPages;
    }
}