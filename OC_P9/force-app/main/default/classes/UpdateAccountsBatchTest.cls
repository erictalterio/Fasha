@isTest
private class UpdateAccountsBatchTest {

    @isTest static void testBatchUpdate() {
        // Use TestDataFactory to create test Accounts
        List<Account> testAccounts = TestDataFactory.createAccounts(2);

        // Create test Orders and link them to the Accounts
        List<Order> testOrders = new List<Order>{
            new Order(AccountId = testAccounts[0].Id, Status='Ordered', TotalAmount=1000.0),
            new Order(AccountId = testAccounts[1].Id, Status='Ordered', TotalAmount=2000.0)
        };
        insert testOrders;

        Test.startTest();
        // Execute the batch job
        UpdateAccountsBatch batchJob = new UpdateAccountsBatch();
        Database.executeBatch(batchJob);
        Test.stopTest();

        // Query the updated Accounts to verify the changes
        List<Account> updatedAccounts = [SELECT Chiffre_d_affaire__c FROM Account WHERE Id IN :testAccounts];
        // Assert statements to ensure the batch job updated the Accounts correctly
        System.assertEquals(2, updatedAccounts.size());
        for (Account acc : updatedAccounts) {
            // Assert based on your expected logic
            System.assertNotEquals(null, acc.Chiffre_d_affaire__c);
        }
    }
}
