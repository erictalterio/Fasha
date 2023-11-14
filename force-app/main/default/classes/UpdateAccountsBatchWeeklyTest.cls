@isTest
private class UpdateAccountsBatchWeeklyTest {

    @isTest static void testBatchProcessing() {
        // Prepare test data - Create 201 accounts and associated orders
        List<Account> testAccounts = TestDataFactory.createAccountsAndOrders(201, 1000.0); // Assuming each order has a total amount of 1000.0

        Test.startTest();
        // Instantiate and execute the batch job
        UpdateAccountsBatchWeekly batchWeekly = new UpdateAccountsBatchWeekly();
        Id batchJobId = Database.executeBatch(batchWeekly);

        // Test the scheduled execution
        Test.setMock(SchedulableContext.class, new MockSchedulableContext(batchJobId));
        batchWeekly.execute(null);
        Test.stopTest();

        // Assertions to verify batch job processing
        // For example, assert that the Chiffre_d'affaire__c field is updated correctly for each account
        // ...

        // Assert the batch job has processed the correct number of records
        AsyncApexJob job = [SELECT TotalJobItems, NumberOfErrors FROM AsyncApexJob WHERE Id = :batchJobId];
        System.assertEquals(201, job.TotalJobItems, 'Job should process 201 accounts.');
        System.assertEquals(0, job.NumberOfErrors, 'There should be no errors in batch processing.');
    }

    // Mock class for SchedulableContext, necessary for testing schedulable classes
    private class MockSchedulableContext implements SchedulableContext {
        private final Id batchJobId;

        public MockSchedulableContext(Id batchJobId) {
            this.batchJobId = batchJobId;
        }

        public Id getTriggerId() {
            return batchJobId;
        }
    }
}
