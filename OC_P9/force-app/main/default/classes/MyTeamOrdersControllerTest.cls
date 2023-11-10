@isTest
private class MyTeamOrdersControllerTest {
    
    @isTest static void testSumOrdersWithBulkData() {
        // Arrange: Create 201 Accounts and associated Orders using TestDataFactory
        TestDataFactory.createAccountsAndOrders(201, 1000.0);

        // Act: Instantiate the controller and retrieve the sum of orders
        MyTeamOrdersController controller = new MyTeamOrdersController();
        Decimal sumOfOrders = controller.sumOrders;

        // Assert: Verify that the sum of orders is correctly calculated for 201 Accounts
        Decimal expectedSum = 201000.0; // 201 Accounts each with an Order of 1000.0
        System.assertEquals(expectedSum, sumOfOrders, 'The sum of orders for 201 accounts should be correctly calculated.');
    }
}
