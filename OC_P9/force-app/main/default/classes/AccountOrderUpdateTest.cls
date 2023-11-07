@isTest
private class AccountOrderUpdateTest {
    @isTest static void test() {
        // Create a test Account record
        Account acc1 = new Account(Name = 'Test Account 1');
        insert acc1; // Insert the Account record into the database

        // Create a test Product record
        Product2 pd1 = new Product2(Name = 'Chemise Verte longue XYX', Family = 'Chemise');
        Insert pd1; // Insert the Product record into the database

        // Create a PricebookEntry record to establish a price for the product
        PricebookEntry pbe = new PricebookEntry(
            Pricebook2Id = Test.getStandardPricebookId(), // Get the standard Pricebook ID
            Product2Id = pd1.Id, // Reference the created Product's ID
            UnitPrice = 1020, // Set the unit price
            IsActive = true // Make the PricebookEntry active
        );
        Insert pbe; // Insert the PricebookEntry into the database

        // Create an Order record associated with the test Account
        Order o1 = new Order(AccountId = acc1.Id); // Set the AccountId field to the test Account's ID
        insert o1; // Insert the Order into the database

        // Create OrderItem records to add line items to the Order
        OrderItem oi1 = new OrderItem(OrderId = o1.Id, PricebookEntryId = pbe.Id, Quantity=10, UnitPrice = 150);
        insert oi1; // Insert the first OrderItem into the database
        OrderItem oi2 = new OrderItem(OrderId = o1.Id, PricebookEntryId = pbe.Id, Quantity=20, UnitPrice = 1000);
        insert oi2;  // Insert the second OrderItem into the database

        // Assertions block
        Test.startTest();
        // Normally, you would perform test actions here, like updating records or calling a method.
        Test.stopTest();

        // Reload the order from the database to get the latest values
        Order updatedOrder = [SELECT TotalAmount, NetAmount__c FROM Order WHERE Id = :o1.Id];
        // Check if the TotalAmount field on the Order is correctly calculated
        System.assertEquals(150 * 10 + 1000 * 20, updatedOrder.TotalAmount, 'Total amount should be correctly calculated.');
        // Check if the NetAmount__c field on the Order is correctly calculated
        System.assertEquals(updatedOrder.TotalAmount - o1.ShipmentCost__c, updatedOrder.NetAmount__c, 'Net amount should be correctly calculated.');
    }
}
