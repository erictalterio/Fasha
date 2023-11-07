public with sharing class GetAccountOrdersUtility {
    // Query to find existing accounts with orders that have the status = 'Ordered'
    private static final String ACCOUNT_QUERY =
        'SELECT Id, Chiffre_d_affaire__c ' +
        'FROM Account ' +
        'WHERE Id IN (SELECT AccountId ' +
        'FROM Order ' +
        'WHERE Status = \'Ordered\' ' +
        'AND AccountId != null) ' +
        'WITH SECURITY_ENFORCED';

    public static Database.QueryLocator getAccountQueryLocator() {
        return Database.getQueryLocator(ACCOUNT_QUERY);
    }
}
