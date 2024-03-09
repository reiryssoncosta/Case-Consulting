/**
 * @description: Class to send data to levelCustomerSatisfaction
 * @author Reirysson Costa - Everymind 
 */
public with sharing class LevelCustomerSatisfactionController {

    public static OpportunityRepository repository;

    static{
        repository = new OpportunityRepository();
    }

    @AuraEnabled
    public static void saveLevelSatisfaction( String opportunityId, String levelSatisfaction ) {
        
        Opportunity opportunityToUpdate = repository.findById( opportunityId );

        opportunityToUpdate.LevelSatisfaction__c = levelSatisfaction;

        try{
            update opportunityToUpdate;
        }catch(Exception e){
            System.debug('erro '+e);
        }
    }
}