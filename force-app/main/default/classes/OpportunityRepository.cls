/**
 * @description: Class to provide stored Opportunity collections
 * @author: Reirysson Costa
 */
public virtual class OpportunityRepository extends AbstractRepository {

    public virtual List<Opportunity> findById( Set<Id> opportunitiesIds ) {
        return[
                SELECT
                    Id
                    , StageName
                    , SellerEmail__c
                    , CustomerEmail__c
                    , Etapa__c
                FROM
                    Opportunity
                WHERE Id IN :opportunitiesIds
        ];
    }

    public virtual List<Opportunity> findById( List<Id> opportunitiesIds ) {
        return[
                SELECT
                    Id
                    , StageName
                    , SellerEmail__c
                    , CustomerEmail__c
                    , Etapa__c
                FROM
                    Opportunity
                WHERE Id IN :opportunitiesIds
        ];
    }

    public virtual Opportunity findById( String opportunityId ) {
        return[
                SELECT
                    Id
                    , Name
                    , StageName
                    , SellerEmail__c
                    , CustomerEmail__c
                    , LevelSatisfaction__c
                    , Etapa__c
                FROM
                    Opportunity
                WHERE Id = :opportunityId
        ];
    }

    public virtual List<Opportunity> findByAccountId( Set<Id> accountIds ) {
        return[
                SELECT
                    Id
                    , StageName
                    , SellerEmail__c
                    , CustomerEmail__c
                    , AccountId
                    , ProjectDetails__c 
                    , InitialDate__c 
                    , CloseDate 
                    , EstimatedProjectCost__c 
                    , AvailableValue__c 
                    , Etapa__c
                FROM
                    Opportunity
                WHERE AccountId IN :accountIds
        ];
    }
}