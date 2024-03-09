/**
 * @description Class to change level customer satisfaction.
 * @author Reirysson Costa - Everymind
 */
import { LightningElement, track, wire, api } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { getPicklistValues } from 'lightning/uiObjectInfoApi';
import { getRecord } from "lightning/uiRecordApi";

import LEVEL_SATISFACTION from '@salesforce/schema/Opportunity.LevelSatisfaction__c';
import saveLevelSatisfaction from '@salesforce/apex/LevelCustomerSatisfactionController.saveLevelSatisfaction';

const LEVEL_SATISFACTION_VALUES = {
    'Excelente': '100',
    'Bom': '80',
    'Regular': '60',
    'Ruim': '40',
    'Muito Ruim': '20',
};

const FIELDS = [
    'Opportunity.Id',
    'Opportunity.LevelSatisfaction__c'
]

export default class LevelCustomerSatisfaction extends LightningElement {

    @api recordId;

    @track levelSatisfaction = [];
    @track levelSatisfactionSelected = '';
    @track levelsSatisfaction = [];

    @track levelSatisfaction;

    @wire(getRecord, { recordId: '$recordId', fields: FIELDS})
    opportunity({ error, data }) {
        if (data) {
            this.levelSatisfaction = LEVEL_SATISFACTION_VALUES[data.fields.LevelSatisfaction__c.value];
        } else if (error) {
            console.error("Erro na execução do processo getRecord, error: ", error );
        }
    }

    @wire(getPicklistValues, { recordTypeId: '012000000000000AAA', fieldApiName: LEVEL_SATISFACTION })
    getPicklistValuesForField({ error, data }) {
        if (data) { 
            this.levelsSatisfaction = data.values.map(item => {
                return {
                    label: item.label,
                    value: item.value
                };
            });
        } else if (error) {
           console.error("Erro na execução do processo 'getPicklistValuesForField', error: ", error);
    }}

    handleChange(event) {
        this.levelSatisfactionSelected = event.detail.value;
        this.levelSatisfaction = LEVEL_SATISFACTION_VALUES[this.levelSatisfactionSelected];
    }

    handleSave(){
        saveLevelSatisfaction({ opportunityId: this.recordId, levelSatisfaction: this.levelSatisfactionSelected })
            .then(result => {
                this.showToast('Sucesso: nível atualizado', 'Sucesso ao atualizar o nível de satisfação', 'success', 'dismissable');
            })
            .catch(error => {
                this.showToast('Error: Falha ao salvar', 'Falha ao salvar o novo nível de satisfação, favor tentar novamente.', 'error', 'dismissable ');
                console.error('Erro ao salvar o novo do nível de satisfação:', error);
            });
    }

    showToast(sendTitle, sendMessage, sendVariant, sendMode) {
        const event = new ShowToastEvent({
            title: sendTitle,
            message: sendMessage,
            variant: sendVariant,
            mode: sendMode
        });
        this.dispatchEvent(event);
    }
}