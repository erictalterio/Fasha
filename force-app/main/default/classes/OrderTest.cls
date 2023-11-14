@isTest
// Utility class for the TestDataFactory
private class OrderTest {
    @isTest static void testOrderCreation() {
        // Creating accounts and associated orders
        List<Account> accounts = TestDataFactory.createAccountsAndOrders(201, 1000.0);

        // Query to verify the orders are created and associated correctly
        List<Order> orders = [SELECT Id, AccountId FROM Order WHERE AccountId IN :accounts];

        // Assertions to verify the correct number of orders are created and associated
        System.assertEquals(201, orders.size(), 'There should be 201 orders created.');
        for (Order ord : orders) {
            System.assertNotEquals(null, ord.Id, 'Order Id should not be null after insertion.');
            System.assert(accounts.contains(ord.AccountId), 'Order should be associated with one of the test accounts.');
        }
    }
}
