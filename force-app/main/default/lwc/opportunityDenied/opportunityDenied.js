/**
 * @description Class to change stage opportunity to denied.
 * @author Reirysson Costa - Everymind
 */
import { LightningElement, api } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { CloseActionScreenEvent } from 'lightning/actions';
import setStageOpportunityDenied from '@salesforce/apex/OpportunityDeniedController.setStageOpportunityDenied';

export default class OpportunityDenied extends LightningElement {
    @api recordId;

    setStageOpportunityDenied() {
        setStageOpportunityDenied({ opportunitiesIds: [this.recordId] })
            .then(() => {
                this.showToast('Sucesso: oportunidade negada', 'Sucesso ao reprovar a oportunidade', 'success', 'dismissable');
                this.dispatchEvent(new CloseActionScreenEvent());
                window.location.reload( true );;
                console.log('Oportunidade atualizada para negada com sucesso.');
            })
            .catch(error => {
                this.showToast('Error: Falha ao negar a oportunidade', 'Falha na reprovação da oportunidade, favor tentar novamente.', 'error', 'dismissable ');
                console.error('Erro ao atualizar oportunidade para negada: ', error);
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