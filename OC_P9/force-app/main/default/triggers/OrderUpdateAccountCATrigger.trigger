trigger OrderUpdateAccountCATrigger on Order (after update) {
    // Collecting Account IDs from updated Orders
    Set<Id> accountIds = new Set<Id>();
    for (Order ord : Trigger.new) {
        accountIds.add(ord.AccountId);
    }

    // Fetching existing totals for these Accounts
    Map<Id, Decimal> accountIdToTotalMap = new Map<Id, Decimal>();
    for (AggregateResult aggResult : [
        SELECT AccountId, SUM(TotalAmount) total
        FROM Order 
        WHERE AccountId IN :accountIds
        GROUP BY AccountId
    ]) {
        accountIdToTotalMap.put((Id)aggResult.get('AccountId'), (Decimal)aggResult.get('total'));
    }

    // Preparing Accounts for update
    List<Account> accountsToUpdate = new List<Account>();
    for (Id accId : accountIds) {
        Account acc = new Account(Id = accId, Chiffre_d_affaire__c = accountIdToTotalMap.get(accId));
        accountsToUpdate.add(acc);
    }

    // Updating Accounts in bulk
    update accountsToUpdate;
}
