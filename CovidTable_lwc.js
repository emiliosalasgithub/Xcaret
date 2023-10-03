import { LightningElement } from 'lwc';
import getCovidInfo from '@salesforce/apex/CovidTable_Controller.getCovidInfo';
import syncData from '@salesforce/apex/CovidTable_Controller.syncData';
import { deleteRecord } from 'lightning/uiRecordApi';

const columns = [
    { label: 'dateChecked', fieldName: 'dateChecked__c', type: 'date' },
    { label: 'positive', fieldName: 'positive__c'},
    { label: 'negative', fieldName: 'negative__c',},
    { label: 'hospitalizedCurrently', fieldName: 'hospitalizedCurrently__c'},
    { type: 'button-icon', typeAttributes: {
        alternativeText: 'Eliminar',
        name: 'Eliminar',
        iconName: 'utility:delete',
        disabled: false
        }
    }    
]

export default class CovidTable_lwc extends LightningElement {
    data = [];
    columns = columns;

    connectedCallback() {
        getCovidInfo().then(data => {
            this.data = data;
        }   
        )
    }

    sync(event) {
        syncData().then(() => {
           this.connectedCallback(); 
        })
    }

    handleRowAction(event) {
        console.log('handleRowAction');
        const rowId = event.detail.row.Id;
        const actionName = event.detail.action.name;
        switch (actionName) {
            case 'Eliminar':
                console.log('eliminar');
                deleteRecord(rowId).then(() => {
                    this.connectedCallback();
                });
               
                break;
            default:
        }
    }
}
