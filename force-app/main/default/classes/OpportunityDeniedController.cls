/**
 * @description: Class to send data to opportuityDenied
 * @author Reirysson Costa - Everymind 
 */
public with sharing class OpportunityDeniedController {
    
    public static OpportunityRepository repository;

    static{
        repository = new OpportunityRepository();
    }

    @AuraEnabled
    public static void setStageOpportunityDenied( List<Id> opportunitiesIds ) {
        List<Opportunity> opportunitiesToUpdate = repository.findById( opportunitiesIds );

        for(Opportunity opportunity : opportunitiesToUpdate){
            opportunity.StageName = 'Negada';
        }

        try{
            update opportunitiesToUpdate;
        }catch(Exception e){
            System.debug('erro '+e);
        }
    }
}