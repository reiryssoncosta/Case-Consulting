/**
 * @description: Enricher class for Opportunity object
 * @author: Reirysson Costa - Everymind
 */
public class OpportunityEnricher {

    public List<Opportunity> withStage( List<Opportunity> opportunities, String stage ) {
        List<Opportunity> updatedOpportunties = new List<Opportunity>();

        for( Opportunity opportunity : opportunities ) {
            updatedOpportunties.add( this.withStage( opportunity, stage ) );
        }

        return updatedOpportunties;
    }

    public Opportunity withStage( Opportunity opportunity, String stage ) {
        opportunity.StageName = stage;

        return opportunity;
    }

    public List<Opportunity> withClosed( List<Opportunity> opportunities ) {
        List<Opportunity> updatedOpportunties = new List<Opportunity>();

        for( Opportunity opportunity : opportunities ) {
            updatedOpportunties.add( this.withClosed( opportunity ) );
        }

        return updatedOpportunties;
    }

    public Opportunity withClosed( Opportunity opportunity ) {
        opportunity.Etapa__c = 'Primeira etapa';

        return opportunity;
    }

    public List<Opportunity> withStageAndFields( List<Opportunity> opportunities, String stage ) {
        List<Opportunity> updatedOpportunties = new List<Opportunity>();

        for( Opportunity opportunity : opportunities ) {
            updatedOpportunties.add( this.withStageAndFields( opportunity, stage ) );
        }

        return updatedOpportunties;
    }

    public Opportunity withStageAndFields( Opportunity opportunity, String stage ) {
        opportunity.StageName = stage;
        Integer monthsDifference = 12 * (opportunity.CloseDate.year() - opportunity.InitialDate__c.year()) + (opportunity.CloseDate.month() - opportunity.InitialDate__c.month());
        opportunity.EstimatedProjectTime__c = monthsDifference;
        opportunity.EstimatedProjectCost__c = opportunity.AvailableValue__c * 0.5;
        opportunity.ProposalValue__c = opportunity.AvailableValue__c * 0.5;

        return opportunity;
    }
}