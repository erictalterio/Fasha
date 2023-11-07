/**
 * Trigger for updating the Chiffre_d_affaire__c field on Account records after related Orders are updated.
 * This trigger fires after an Order record is updated to ensure that the Account's financials are
 * reflective of the most recent Order data.
 */
trigger OrderUpdateAccountCATrigger on Order (after update) {
    // Initialize a set to store unique Account IDs associated with the updated Orders
    Set<Id> accountIds = new Set<Id>();
    for (Order ord : Trigger.new) { // Loop over each updated Order record
        accountIds.add(ord.AccountId); // Add the AccountId of the Order to the set
    }

    // Map to hold the sum of TotalAmount for each Account based on related Orders
    Map<Id, Decimal> accountIdToTotalMap = new Map<Id, Decimal>();
    for (AggregateResult aggResult : [
        SELECT AccountId, SUM(TotalAmount) total
        FROM Order 
        WHERE AccountId IN :accountIds // Only select Orders related to the updated Orders' Accounts
        GROUP BY AccountId // Group the results by AccountId to calculate the sum of TotalAmount per Account
    ]) {
        // Store the summed TotalAmount in the map using AccountId as the key
        accountIdToTotalMap.put((Id)aggResult.get('AccountId'), (Decimal)aggResult.get('total'));
    }

    // Prepare a list of Accounts with their Chiffre_d_affaire__c field updated to the summed TotalAmount
    List<Account> accountsToUpdate = new List<Account>();
    for (Id accId : accountIds) { // Iterate through each AccountId collected from updated Orders
        // Create a new Account instance with the updated Chiffre_d_affaire__c value
        Account acc = new Account(Id = accId, Chiffre_d_affaire__c = accountIdToTotalMap.get(accId));
        accountsToUpdate.add(acc); // Add the Account to the list for bulk update
    }

    // Execute a bulk update of the Account records to reflect the new Chiffre_d'affaire__c values
    update accountsToUpdate;
}
