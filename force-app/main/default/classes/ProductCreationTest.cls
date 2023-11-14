@isTest
// Utility class for the TestDataFactory
private class ProductCreationTest {
    @isTest static void testProductCreation() {
        // Creating 3 Product records and inserting them into the database
        List<Product2> products = TestDataFactory.createProducts(201, true);

        // Assertions to verify the correct number of products are created and inserted
        System.assertEquals(201, products.size(), 'There should be 201 products created.');
        for (Product2 prod : products) {
            System.assertNotEquals(null, prod.Id, 'Product Id should not be null after insertion.');
        }
    }
}
