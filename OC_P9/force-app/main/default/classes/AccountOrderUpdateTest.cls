@isTest
private class AccountOrderUpdateTest {
    @isTest static void test() {
        Account acc1 = new Account(Name = 'Test Account 1');
        insert acc1;

        Product2 pd1 = new Product2(Name = 'Chemise Verte longue XYX', Family = 'Chemise');
        Insert pd1;

        //Create the PricebookEntry
        PricebookEntry pbe = new PricebookEntry(
            Pricebook2Id = Test.getStandardPricebookId(),
            Product2Id = pd1.Id,
            UnitPrice = 1020,
            IsActive = true
        );
        Insert pbe;

        Order o1 = new Order(AccountId = acc1.Id);
        insert o1;

        OrderItem oi1 = new OrderItem(OrderId = o1.Id, PricebookEntryId = pbe.Id, Quantity=10, UnitPrice = 150);
        insert oi1;
        OrderItem oi2 = new OrderItem(OrderId = o1.Id, PricebookEntryId = pbe.Id, Quantity=20, UnitPrice = 1000);
        insert oi2;  

        // Assertions
        Test.startTest();
        // Perform test actions
        Test.stopTest();
        
        // Reload the order from the database to verify updates
        Order updatedOrder = [SELECT TotalAmount, NetAmount__c FROM Order WHERE Id = :o1.Id];
        System.assertEquals(150 * 10 + 1000 * 20, updatedOrder.TotalAmount, 'Total amount should be correctly calculated.');
        System.assertEquals(updatedOrder.TotalAmount - o1.ShipmentCost__c, updatedOrder.NetAmount__c, 'Net amount should be correctly calculated.');
    }
}
