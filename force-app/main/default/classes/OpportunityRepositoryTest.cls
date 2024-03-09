/**
 * @description: Test class for OpportunityRepository class
 * @author: Reirysson Costa
 */
@isTest
public class OpportunityRepositoryTest {

    @isTest
    static void itShouldReturnOpportunitiesBySetId() {

        Opportunity opportunity = new Opportunity();
        opportunity.Name = 'opportunityTeste';
        opportunity.StageName = 'Prospecção';
        opportunity.CloseDate = System.today();
        insert opportunity;

        OpportunityRepository repository = new OpportunityRepository();

        Test.startTest();

        List<Opportunity> opportunitiesStored = repository.findById( new Set<Id>{ opportunity.Id } );

        Test.stopTest();

        Assert.areEqual(false, opportunitiesStored.isEmpty());
    }

    @isTest
    static void itShouldReturnOpportunitiesByListId() {

        Opportunity opportunity = new Opportunity();
        opportunity.Name = 'opportunityTeste';
        opportunity.StageName = 'Prospecção';
        opportunity.CloseDate = System.today();
        insert opportunity;

        OpportunityRepository repository = new OpportunityRepository();

        Test.startTest();

        List<Opportunity> opportunitiesStored = repository.findById( new List<Id>{ opportunity.Id } );

        Test.stopTest();

        Assert.areEqual(false, opportunitiesStored.isEmpty());
    }

    @isTest
    static void itShouldReturnOpportunityById() {

        Opportunity opportunity = new Opportunity();
        opportunity.Name = 'opportunityTeste';
        opportunity.StageName = 'Prospecção';
        opportunity.CloseDate = System.today();
        insert opportunity;

        OpportunityRepository repository = new OpportunityRepository();

        Test.startTest();

        Opportunity opportunityStored = repository.findById( opportunity.Id );

        Test.stopTest();

        Assert.areEqual('opportunityTeste', opportunityStored.Name);
    }

    @isTest
    static void itShouldReturnOpportunitiesByAccountId() {

        Account account = new Account();
        account.Name = 'accountTeste';
        insert account;

        Account accountInserted = [SELECT Id FROM Account LIMIT 1];

        Opportunity opportunity = new Opportunity();
        opportunity.Name = 'opportunityTeste';
        opportunity.StageName = 'Prospecção';
        opportunity.CloseDate = System.today();
        opportunity.AccountId = accountInserted.Id;
        insert opportunity;

        OpportunityRepository repository = new OpportunityRepository();

        Test.startTest();

        List<Opportunity> opportunitiesStored = repository.findByAccountId( new Set<Id>{ account.Id } );

        Test.stopTest();

        Assert.areEqual(false, opportunitiesStored.isEmpty());
    }
}