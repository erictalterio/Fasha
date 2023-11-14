@isTest
private class UpdateAccountsBatchTest {
    @isTest static void testBatchUpdate() {
        // Create test Accounts and associated Orders using TestDataFactory
        List<Account> testAccounts = TestDataFactory.createAccountsAndOrders(2, 1000.0);

        Test.startTest();
        // Execute the batch job
        UpdateAccountsBatch batchJob = new UpdateAccountsBatch();
        Database.executeBatch(batchJob);
        Test.stopTest();

        // Query the updated Accounts to verify the changes
        List<Account> updatedAccounts = [SELECT Chiffre_d_affaire__c FROM Account WHERE Id IN :testAccounts];
        System.assertEquals(2, updatedAccounts.size());
        for (Account acc : updatedAccounts) {
            System.assertNotEquals(null, acc.Chiffre_d_affaire__c);
        }
    }
}
