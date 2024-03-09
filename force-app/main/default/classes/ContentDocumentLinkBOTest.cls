/**
 * @description: Test class for ContentDocumentLinkBO class
 * @author: Reirysson Costa - teste
 */
@isTest
public class ContentDocumentLinkBOTest {

    @isTest
    static void itShouldReturnOpportunitiesWithStageFormalization() {

        Opportunity opportunity = new Opportunity();
        opportunity.Name = 'opportunityTeste';
        opportunity.StageName = 'Prospecção';
        opportunity.CloseDate = System.today();
        insert opportunity;

        ContentDocumentLinkBO contentDocumentLinkBO = new ContentDocumentLinkBO();

        Test.startTest();

        List<Opportunity> opportunitiesFiltered = contentDocumentLinkBO.updateStageOpportunityFormalization( new List<Opportunity>{ opportunity } );

        Test.stopTest();

        Assert.areEqual('Formalização', opportunitiesFiltered[0].StageName);
        Assert.areEqual('Primeira etapa', opportunitiesFiltered[0].Etapa__c);
    }

    @isTest
    static void itShouldReturnOpportunitiesWithStageClosed() {

        Account account = new Account();
        account.Name = 'accountTeste';
        account.CustomerEmail__c = 'accountTeste@gmail.invalid.com';
        insert account;

        Account accountInserted = [SELECT Id, CustomerEmail__c FROM Account LIMIT 1];

        Opportunity opportunity = new Opportunity();
        opportunity.Name = 'opportunityTeste';
        opportunity.StageName = 'Prospecção';
        opportunity.SellerEmail__c  = 'selleremail@gmail.invalid.com';
        opportunity.CloseDate = System.today();
        opportunity.accountId = accountInserted.Id;
        insert opportunity;

        Opportunity opportunityWithFieldsFilled = [SELECT Id, CustomerEmail__c, SellerEmail__c FROM Opportunity LIMIT 1];

        ContentDocumentLinkBO contentDocumentLinkBO = new ContentDocumentLinkBO();

        Test.startTest();

        List<Opportunity> opportunitiesFiltered = contentDocumentLinkBO.updateStageOpportunityClosed( new List<Opportunity>{ opportunityWithFieldsFilled } );

        Test.stopTest();

        Assert.areEqual('Finalizada', opportunitiesFiltered[0].StageName);
    }
}