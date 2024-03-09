/**
 * @description: Test class for OpportunityFilter class
 * @author: Reirysson Costa
 */
@isTest
public class OpportunityFilterTest {

    @isTest
    static void itShouldReturnOpportunitiesByStage() {

        Opportunity opportunity = new Opportunity();
        opportunity.Name = 'opportunityTeste';
        opportunity.StageName = 'Prospecção';
        opportunity.CloseDate = System.today();
        insert opportunity;

        OpportunityFilter filter = new OpportunityFilter();

        Test.startTest();

        List<Opportunity> opportunitiesFiltered = filter.byStage( new List<Opportunity>{ opportunity }, 'Prospecção' );

        Test.stopTest();

        Assert.areEqual(false, opportunitiesFiltered.isEmpty());
    }

    @isTest
    static void itShouldReturnOpportunitiesByCompletedFields() {

        Opportunity opportunity = new Opportunity();
        opportunity.Name = 'opportunityTeste';
        opportunity.StageName = 'Prospecção';
        opportunity.CloseDate = System.today();
        opportunity.InitialDate__c = System.today();
        opportunity.ProjectDetails__c = 'teste';
        opportunity.EstimatedProjectCost__c = 100;
        opportunity.ProposalValue__c = 100;
        insert opportunity;

        OpportunityFilter filter = new OpportunityFilter();

        Test.startTest();

        List<Opportunity> opportunitiesFiltered = filter.byCompletedFields( new List<Opportunity>{ opportunity } );

        Test.stopTest();

        Assert.areEqual(false, opportunitiesFiltered.isEmpty());
    }

    @isTest
    static void itShouldReturnOpportunitiesByFinished() {

        Account account = new Account();
        account.Name = 'accountTeste';
        account.CustomerEmail__c = 'accountTeste@gmail.invalid.com';
        insert account;

        Account accountInserted = [SELECT Id, CustomerEmail__c FROM Account LIMIT 1];

        Opportunity opportunity = new Opportunity();
        opportunity.Name = 'opportunityTeste';
        opportunity.StageName = 'Formalização';
        opportunity.CloseDate = System.today();
        opportunity.InitialDate__c = System.today();
        opportunity.ProjectDetails__c = 'teste';
        opportunity.EstimatedProjectCost__c = 100;
        opportunity.ProposalValue__c = 100;
        opportunity.Etapa__c = 'Primeira etapa';
        opportunity.accountId = accountInserted.Id;
        insert opportunity;

        Opportunity opportunityWithAccount = [SELECT Id, Etapa__c, StageName, CustomerEmail__c FROM Opportunity LIMIT 1];

        OpportunityFilter filter = new OpportunityFilter();

        Test.startTest();

        List<Opportunity> opportunitiesFiltered = filter.byFinished( new List<Opportunity>{ opportunityWithAccount } );

        Test.stopTest();

        Assert.areEqual(false, opportunitiesFiltered.isEmpty());
    }
}