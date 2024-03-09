/**
 * @description: Class to filter Opportunity collections
 * @author: Reirysson Costa
 */
public with sharing class OpportunityFilter {

    public List<Opportunity> byStage( List<Opportunity> opportunities, String stage ) {

        List<Opportunity> opportunitiesFiltered = new List<Opportunity>();

        for( Opportunity opportunity : opportunities ) {
            
            if( opportunity.StageName != stage) continue;
            
            opportunitiesFiltered.add( opportunity );
        }

        return opportunitiesFiltered;
    }
    
    public List<Opportunity> byCompletedFields( List<Opportunity> opportunities ) {

        List<Opportunity> opportunitiesCompleted = new List<Opportunity>();

        for( Opportunity opportunity : opportunities ) {
            
            if( opportunity.ProjectDetails__c == null 
                || opportunity.InitialDate__c == null 
                || opportunity.CloseDate == null
                || opportunity.EstimatedProjectCost__c == null
                || opportunity.ProposalValue__c == null) continue;
            
            opportunitiesCompleted.add( opportunity );
        }

        return opportunitiesCompleted;
    }

    public List<Opportunity> byFinished( List<Opportunity> opportunities ) {

        List<Opportunity> opportunitiesFiltered = new List<Opportunity>();

        for( Opportunity opportunity : opportunities ) {
            
            if( opportunity.Etapa__c != 'Primeira etapa' && opportunity.StageName != 'Formalização' && opportunity.CustomerEmail__c == null ) continue;
            
            opportunitiesFiltered.add( opportunity );
        }

        return opportunitiesFiltered;
    }
}