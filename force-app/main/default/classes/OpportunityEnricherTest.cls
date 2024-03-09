/**
 * @description: Test class for OpportunityEnricher class
 * @author: Reirysson Costa
 */
@isTest
public class OpportunityEnricherTest {

    @isTest
    static void itShouldReturnOpportunitiesWithStage() {

        Opportunity opportunity = new Opportunity();
        opportunity.Name = 'opportunityTeste';
        opportunity.StageName = 'Prospecção';
        opportunity.CloseDate = System.today();
        insert opportunity;

        OpportunityEnricher enricher = new OpportunityEnricher();

        Test.startTest();

        List<Opportunity> opportunitiesFiltered = enricher.withStage( new List<Opportunity>{ opportunity }, 'Formalização' );

        Test.stopTest();

        Assert.areEqual('Formalização', opportunitiesFiltered[0].StageName);
    }

    @isTest
    static void itShouldReturnOpportunitiesWithClosed() {

        Opportunity opportunity = new Opportunity();
        opportunity.Name = 'opportunityTeste';
        opportunity.StageName = 'Prospecção';
        opportunity.CloseDate = System.today();
        opportunity.Etapa__c = '';
        insert opportunity;

        OpportunityEnricher enricher = new OpportunityEnricher();

        Test.startTest();

        List<Opportunity> opportunitiesFiltered = enricher.withClosed( new List<Opportunity>{ opportunity } );

        Test.stopTest();

        Assert.areEqual('Primeira etapa', opportunitiesFiltered[0].Etapa__c);
    }

    @isTest
    static void itShouldReturnOpportunitiesWithStageAndFields() {

        Opportunity opportunity = new Opportunity();
        opportunity.Name = 'opportunityTeste';
        opportunity.StageName = 'Prospecção';
        opportunity.AvailableValue__c = 1000;
        opportunity.InitialDate__c = System.today();
        opportunity.CloseDate = System.today().addYears(1);
        insert opportunity;

        OpportunityEnricher enricher = new OpportunityEnricher();

        Test.startTest();

        List<Opportunity> opportunitiesFiltered = enricher.withStageAndFields( new List<Opportunity>{ opportunity }, 'Formalização' );

        Test.stopTest();

        Assert.areEqual('Formalização', opportunitiesFiltered[0].StageName);
        Assert.areEqual(12, opportunitiesFiltered[0].EstimatedProjectTime__c);
        Assert.areEqual(500, opportunitiesFiltered[0].EstimatedProjectCost__c);
        Assert.areEqual(500, opportunitiesFiltered[0].ProposalValue__c);
    }
}