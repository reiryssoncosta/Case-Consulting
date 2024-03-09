/**
 * @description: Class to filter Account collections
 * @author: Reirysson Costa
 */
public with sharing class AccountFilter {

    public List<Account> byCompletedFields( List<Account> accounts ) {

        List<Account> accountsCompleted = new List<Account>();

        for( Account account : accounts ) {
            
            if( account.CustomerEmail__c == null ) continue;
            
            accountsCompleted.add( account );
        }

        return accountsCompleted;
    }
}