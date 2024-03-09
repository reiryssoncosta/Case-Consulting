/**
 * @description: Test class for OpportunityDeniedController class
 * @author: Reirysson Costa
 */
@isTest
public class OpportunityDeniedControllerTest {

    @isTest
    static void itShouldReturnOpportunitiesDenied() {

        Opportunity opportunity = new Opportunity();
        opportunity.Name = 'opportunityTeste';
        opportunity.StageName = 'Prospecção';
        opportunity.CloseDate = System.today();
        insert opportunity;

        Test.startTest();

        OpportunityDeniedController.setStageOpportunityDenied( new List<Id>{ opportunity.Id } );

        Test.stopTest();

        List<Opportunity> opportunitiesDenied = [SELECT Id, StageName FROM Opportunity];

        Assert.areEqual('Negada', opportunitiesDenied[0].StageName);
    }
}