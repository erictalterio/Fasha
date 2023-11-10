/**
 * The RevenueCalculator class is responsible for calculating the total revenue
 * for a list of Accounts. It updates each Account's revenue based on the total
 * amount of their associated Orders.
 */
public class RevenueCalculator {

    /**
     * Calculates and updates the revenue for a list of accounts.
     * 
     * @param accounts The list of Account records to be processed for revenue calculation.
     */
    public static void calculateRevenue(List<Account> accounts) {
        // Map to hold the total amount of Orders per Account
        Map<Id, Decimal> accountIdToTotalAmountMap = new Map<Id, Decimal>();

        // Retrieve and aggregate the total amount of Orders for each Account
        for (Order orderRecord : [SELECT AccountId, TotalAmount FROM Order WHERE AccountId IN :accounts WITH SECURITY_ENFORCED]) {
            if (accountIdToTotalAmountMap.containsKey(orderRecord.AccountId)) {
                // If the Account is already in the map, add to its total amount
                accountIdToTotalAmountMap.put(orderRecord.AccountId, accountIdToTotalAmountMap.get(orderRecord.AccountId) + orderRecord.TotalAmount);
            } else {
                // Otherwise, add the Account with its total amount to the map
                accountIdToTotalAmountMap.put(orderRecord.AccountId, orderRecord.TotalAmount);
            }
        }

        // List to hold Accounts that need to be updated
        List<Account> accountsToUpdate = new List<Account>();

        // Update each Account's revenue field
        for (Account myAccount : accounts) {
            if (accountIdToTotalAmountMap.containsKey(myAccount.Id)) {
                // Set the Account's revenue to the aggregated total amount from the map
                myAccount.Chiffre_d_affaire__c = accountIdToTotalAmountMap.get(myAccount.Id);
            } else {
                // If no Orders are associated with the Account, set revenue to 0
                myAccount.Chiffre_d_affaire__c = 0;
            }
            accountsToUpdate.add(myAccount);
        }

        // Perform a bulk update of the Accounts if there are any to update
        if (!accountsToUpdate.isEmpty()) {
            update accountsToUpdate;
        }
    }
}
