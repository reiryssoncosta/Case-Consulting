/*
 * @description: Business Object class for Account SObject operations
 * @author Reirysson Costa
**/
public without sharing class AccountBO {

    OpportunityRepository opportunityRepository;
    OpportunityEnricher opportunityEnricher;
    OpportunityFilter opportunityFilter;

    public AccountBO() {
        this.opportunityRepository = new OpportunityRepository();
        this.opportunityEnricher = new OpportunityEnricher();
        this.opportunityFilter = new OpportunityFilter();
    }
   
    public List<Opportunity> updateStageOpportunityNegotiation( List<Account> accounts ){

        Set<Id> accountIds = new Set<Id>();

        for( Account account : accounts ){
            accountIds.add(account.Id);
        }

        List<Opportunity> opportunitiesToUpdate = opportunityFilter.byCompletedFields( opportunityEnricher.withStageAndFields( opportunityRepository.findByAccountId( accountIds ), 'Negociação' ) );

        return this.opportunityRepository.save( opportunitiesToUpdate );
    }
}