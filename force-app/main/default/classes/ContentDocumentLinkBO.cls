/*
 * @description: Business Object class for ContentDocumentLink SObject operations
 * @author Reirysson Costa
**/
public without sharing class ContentDocumentLinkBO {

    OpportunityRepository opportunityRepository;
    OpportunityEnricher opportunityEnricher;
    ContentDocumentLinkFilter filter;

    public ContentDocumentLinkBO() {
        this.opportunityRepository = new OpportunityRepository();
        this.opportunityEnricher = new OpportunityEnricher();
        this.filter = new ContentDocumentLinkFilter();
    }

    public List<Opportunity> updateStageOpportunityFormalization( List<Opportunity> opportunitiesInProspecting ){

        List<Opportunity> opportunitiesUpdated = opportunityEnricher.withStage( opportunitiesInProspecting, 'Formalização' );

        List<Opportunity> opportunitiesFinal = opportunityEnricher.withClosed( opportunitiesUpdated );

        return this.opportunityRepository.save( opportunitiesFinal );
    }

    public List<Opportunity> updateStageOpportunityClosed( List<Opportunity> opportunitiesInFormalization ){

        List<Opportunity> opportunitiesUpdated = new List<Opportunity>();

        List<Opportunity> opportunitiesToUpdate = opportunityEnricher.withStage( opportunitiesInFormalization, 'Finalizada' );

        try{
            opportunitiesUpdated = this.opportunityRepository.save( opportunitiesToUpdate );
        }catch(Exception e){
            throw e;
        }

        return opportunitiesUpdated;
        
    }
}