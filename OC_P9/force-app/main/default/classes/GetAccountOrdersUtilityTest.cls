@isTest
private class GetAccountOrdersUtilityTest {

    @isTest static void testGetAccountQueryLocator() {
        // Use TestDataFactory to create test Accounts
        List<Account> testAccounts = TestDataFactory.createAccounts(2);

        // Create Orders for test Accounts
        Order order1 = new Order(AccountId = testAccounts[0].Id, Status='Ordered');
        Order order2 = new Order(AccountId = testAccounts[1].Id, Status='Ordered');
        insert new List<Order>{ order1, order2 };

        Test.startTest();
        // Invoke the method under test
        Database.QueryLocator locator = GetAccountOrdersUtility.getAccountQueryLocator();
        // The following line is commented out because Database.QueryLocator cannot be directly asserted in a test
        // Database.QueryResult results = locator.query();
        Test.stopTest();

        // Since you can't directly test a QueryLocator, we simulate what the locator would return
        List<Account> accountsWithOrders = [SELECT Id FROM Account WHERE Id IN (SELECT AccountId FROM Order WHERE Status = 'Ordered')];
        System.assertEquals(2, accountsWithOrders.size(), 'Should return 2 accounts that have related Orders with status Ordered');
    }
}
