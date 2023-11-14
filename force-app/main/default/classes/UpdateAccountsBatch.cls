/**
 * This batch class updates the Revenue for Accounts
 * based on their associated orders. It utilizes utility classes for querying and calculations.
 */
global class UpdateAccountsBatch implements Database.Batchable<sObject> {

    /**
     * The start method prepares the batch process.
     * Retrieves the query locator for accounts to process, based on specific criteria.
     * @param bc The context of the batch job.
     * @return A QueryLocator defining the scope of Account records to be processed.
     */
    global Database.QueryLocator start(Database.BatchableContext bc) {
        // Query accounts with criteria defined in GetAccountOrdersUtility
        return GetAccountOrdersUtility.getAccountQueryLocator();
    }

    /**
     * The execute method processes each batch of records.
     * @param bc The context of the batch job.
     * @param scope The list of Account records in the current batch to be processed.
     */
    global void execute(Database.BatchableContext bc, List<Account> scope) {
        // Calculate and update the turnover for each account in the batch
        RevenueCalculator.calculateRevenue(scope);
    }

    /**
     * The finish method is called after all batches are processed.
     * Used for post-processing steps and cleanup.
     * @param bc The context of the batch job.
     */
    global void finish(Database.BatchableContext bc) {
        // Log completion of the batch job
        System.debug('UpdateAccountsBatch: Batch job has finished.');
    }
}
