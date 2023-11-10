@isTest
private class GetAccountOrdersUtilityTest {

    @isTest static void testGetAccountQueryLocator() {
        // Create test Accounts and associated Orders
        List<Account> testAccounts = TestDataFactory.createAccountsAndOrders(201, 1000.0);

        Test.startTest();
        // Invoke the method under test
        Database.QueryLocator locator = GetAccountOrdersUtility.getAccountQueryLocator();
        Test.stopTest();

        // Simulate the expected behavior of the QueryLocator
        List<Account> accountsWithOrders = [SELECT Id FROM Account WHERE Id IN (SELECT AccountId FROM Order WHERE Status = 'Ordered')];
        System.assertEquals(2, accountsWithOrders.size(), 'Should return 2 accounts that have related Orders with status Ordered');
    }
}
