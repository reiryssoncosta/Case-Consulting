/**
 * @description: Trigger handler for the SObject ContentDocumentLink 
 * @author: Reirysson Costa
 */
public with sharing class ContentDocumentHandler extends TriggerHandler {

    private List<ContentDocumentLink> tNew;
    private List<ContentDocumentLink> tOld;

    private ContentDocumentLinkBO contentDocumentLinkBO;
    private ContentDocumentLinkFilter filter;
    private OpportunityFilter opportunityFilter;
    private OpportunityRepository opportunityRepository;

    public ContentDocumentHandler() {

        this.tNew = (List<ContentDocumentLink>) Trigger.new;
        this.tOld = (List<ContentDocumentLink>) Trigger.old;

        this.contentDocumentLinkBO = new ContentDocumentLinkBO();
        this.filter = new ContentDocumentLinkFilter();
        this.opportunityFilter = new OpportunityFilter();
        this.opportunityRepository = new OpportunityRepository();
    }

    public override void afterInsert() {
        this.updateStageOpportunityFormalization();
        this.updateStageOpportunityClosed();
	}

    private void updateStageOpportunityFormalization(){
        Set<Id> opportunitiesIdsWithContentDocuments = this.filter.byOpportunities( this.tNew );

        List<Opportunity> opportunitiesInProspecting = this.opportunityFilter.byStage( this.opportunityRepository.findById(opportunitiesIdsWithContentDocuments), 'Negociação' );

        this.contentDocumentLinkBO.updateStageOpportunityFormalization( opportunitiesInProspecting );
    }

    private void updateStageOpportunityClosed(){
        Set<Id> opportunitiesIdsWithContentDocuments = this.filter.byOpportunities( this.tNew );

        List<Opportunity> opportunitiesInFormalization = this.opportunityFilter.byStage( this.opportunityRepository.findById(opportunitiesIdsWithContentDocuments), 'Formalização');

        List<Opportunity> opportunitiesToClosed = this.opportunityFilter.byFinished( opportunitiesInFormalization );
        
        this.contentDocumentLinkBO.updateStageOpportunityClosed( opportunitiesToClosed );
    }
}