/**
 * @description: Trigger handler for the SObject Account
 * @author: Reirysson Costa
 */
public with sharing class AccountHandler extends TriggerHandler {

    private List<Account> tNew;
	private List<Account> tOld;
	private Map<Id, Account> tNewMap;
	private Map<Id, Account> tOldMap;

    private AccountBO accountBO;
    private AccountFilter filter;

    public AccountHandler() {
		
		this.tNew = (List<Account>) Trigger.new;
		this.tOld = (List<Account>) Trigger.old;
		this.tNewMap = (Map<Id, Account>) Trigger.newMap;
		this.tOldMap = (Map<Id, Account>) Trigger.oldMap;

        this.accountBO = new AccountBO();
        this.filter = new AccountFilter();
	}

    public override void afterUpdate() {

        List<Account> filteredAccounts = this.filter.byCompletedFields( this.tNew );

        System.debug('filteredAccounts '+filteredAccounts);

        this.accountBO.updateStageOpportunityNegotiation( filteredAccounts );
	}
}