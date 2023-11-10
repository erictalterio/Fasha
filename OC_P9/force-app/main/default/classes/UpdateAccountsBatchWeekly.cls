/**
 * This class serves both as a batch class and a schedulable class.
 * It is designed to update the turnover (Chiffre d'affaire) for Accounts on a weekly schedule.
 */
global class UpdateAccountsBatchWeekly implements Database.Batchable<sObject>, Schedulable {

    /**
     * Implements the Schedulable interface's execute method.
     * Schedules the batch job to run on a defined schedule.
     * @param sc The context of the scheduled job.
     */
    global void execute(SchedulableContext sc) {
        // Execute the batch job
        Database.executeBatch(new UpdateAccountsBatch());
    }

    // The start, execute, and finish methods are similar to UpdateAccountsBatch
    // and are used when this class operates in batch mode

    /**
     * Schedule the batch job to run weekly.
     * Can be initiated from an anonymous Apex script.
     */
    public static void scheduleWeekly() {
        // Define the cron expression for weekly execution, e.g., every Sunday at 2 AM
        String cronExp = '0 0 2 ? * SUN';

        // Schedule the batch job
        System.schedule('Weekly UpdateAccountsBatch', cronExp, new UpdateAccountsBatchWeekly());
    }
}
