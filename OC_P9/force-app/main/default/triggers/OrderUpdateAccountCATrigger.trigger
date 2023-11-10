/**
 * Trigger on the Order object that fires after records are updated.
 * It aggregates the TotalAmount of related Orders for each Account and updates
 * the Chiffre_d_affaire__c field on the Account records.
 */
trigger OrderUpdateAccountCATrigger on Order (after update) {
    // Collect unique Account IDs from updated Orders to process their related Orders
    Set<Id> accountIds = new Set<Id>();
    for (Order ord : Trigger.new) {
        // Add AccountId to the set if it's not null
        if (ord.AccountId != null) {
            accountIds.add(ord.AccountId);
        }
    }

    // Proceed only if there are Accounts to update
    if (!accountIds.isEmpty()) {
        // Map to store the aggregated TotalAmount for each Account
        Map<Id, Decimal> accountIdToTotalMap = new Map<Id, Decimal>();

        // Aggregate the TotalAmount for each Account from related Orders
        for (AggregateResult aggResult : [
            SELECT AccountId, SUM(TotalAmount) total
            FROM Order 
            WHERE AccountId IN :accountIds
            GROUP BY AccountId
        ]) {
            // Add the sum of TotalAmount to the map for each Account
            accountIdToTotalMap.put((Id)aggResult.get('AccountId'), (Decimal)aggResult.get('total'));
        }

        // Prepare a list of Accounts to update with the new aggregated TotalAmount
        List<Account> accountsToUpdate = new List<Account>();
        for (Id accId : accountIds) {
            // Create Account instances with updated Chiffre_d_affaire__c values
            Account acc = new Account(Id = accId, Chiffre_d_affaire__c = accountIdToTotalMap.get(accId));
            accountsToUpdate.add(acc);
        }

        // Perform a bulk update on the Accounts if there are any to update
        if (!accountsToUpdate.isEmpty()) {
            update accountsToUpdate;
        }
    }
}
