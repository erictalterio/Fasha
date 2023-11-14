@isTest
// Utility class for the TestDataFactory
private class PriceBookEntryTest {
    @isTest static void testPricebookEntryCreation() {
        // Creating products needed for pricebook entries
        List<Product2> products = TestDataFactory.createProducts(201, true);
        
        // Creating PricebookEntries for the created products
        List<PricebookEntry> pbEntries = TestDataFactory.createPricebookEntries(products, true);

        // Assertions to verify the correct number of pricebook entries are created and inserted
        System.assertEquals(201, pbEntries.size(), 'There should be 201 pricebook entries created.');
        for (PricebookEntry pbe : pbEntries) {
            System.assertNotEquals(null, pbe.Id, 'PricebookEntry Id should not be null after insertion.');
        }
    }
}
