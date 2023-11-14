@isTest
// Utility class for the TestDataFactory
private class OrderItemTest {
    @isTest static void testOrderItemCreation() {
        // Creating accounts and associated orders
        List<Account> accounts = TestDataFactory.createAccountsAndOrders(201, 1000.0); // Assuming an order total amount of 1000.0

        // Creating necessary products and pricebook entries for order items
        List<Product2> products = TestDataFactory.createProducts(201, true);
        List<PricebookEntry> pbEntries = TestDataFactory.createPricebookEntries(products, true);

        // Retrieve the created orders for these accounts
        List<Order> orders = [SELECT Id FROM Order WHERE AccountId IN :accounts];

        // Creating OrderItems and associating them with Orders and PricebookEntries
        List<OrderItem> orderItems = TestDataFactory.createOrderItems(orders, pbEntries, true);

        // Assertions to verify the correct number of order items are created and inserted
        System.assertEquals(201, orderItems.size(), 'There should be 201 order item created.');
        for (OrderItem oi : orderItems) {
            System.assertNotEquals(null, oi.Id, 'OrderItem Id should not be null after insertion.');
        }
    }
}
