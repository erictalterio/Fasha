@isTest
public class TestDataFactory {

    /**
     * Creates a list of Account records.
     * 
     * @param numRecords The number of Account records to create.
     * @param doInsert   If true, inserts the records into the database.
     * @return           A list of Account records.
     */
    public static List<Account> createAccounts(Integer numRecords, Boolean doInsert) {
        List<Account> accounts = new List<Account>();
        for(Integer i = 0; i < numRecords; i++) {
            // Creating new Account with a unique name
            accounts.add(new Account(Name = 'Test Account ' + i));
        }
        // Insert accounts into the database if doInsert is true
        if(doInsert) {
            insert accounts;
        }
        return accounts;
    }

    /**
     * Creates a list of Accounts and associated Orders in bulk.
     * 
     * @param numAccounts The number of Account and Order pairs to create.
     * @param orderAmount The total amount for each Order.
     * @return            A list of created Account records.
     */
    public static List<Account> createAccountsAndOrders(Integer numAccounts, Decimal orderAmount) {
        List<Account> accounts = new List<Account>();
        List<Order> orders = new List<Order>();

        for(Integer i = 0; i < numAccounts; i++) {
            Account acc = new Account(Name = 'Bulk Test Account ' + i);
            accounts.add(acc);
        }
        insert accounts;

        for(Account acc : accounts) {
            Order ord = new Order(AccountId = acc.Id, TotalAmount = orderAmount, Status = 'Ordered');
            orders.add(ord);
        }
        insert orders;

        return accounts;
    }

    /**
     * Creates a list of Product records.
     * 
     * @param numRecords The number of Product records to create.
     * @param doInsert   If true, inserts the records into the database.
     * @return           A list of Product records.
     */
    // Method to create Products
    // This method follows the same pattern as createAccounts, creating a specified
    // number of Product records and optionally inserting them into the database.
    // It returns a list of created Product records.
    public static List<Product> createProducts(Integer numRecords, Boolean doInsert) {
        List<Product> products = new List<Product>();
        for(Integer i = 0; i < numRecords; i++) {
            // Creating new Product with a unique name and family
            products.add(new Product(Name = 'Product ' + i, Family = 'Family ' + i));
        }
        // Insert products into the database if doInsert is true
        if(doInsert) {
            insert products;
        }
        return products;
    }

    /**
     * Creates a list of PricebookEntry records associated with given products.
     * 
     * @param products The list of Product records to associate with PricebookEntries.
     * @param doInsert If true, inserts the records into the database.
     * @return         A list of PricebookEntry records.
     */
    // Method to create PricebookEntries
    // This method generates PricebookEntry records linked to a list of provided
    // Product records. It also follows the pattern of conditional insertion.
    public static List<PricebookEntry> createPricebookEntries(List<Product> products, Boolean doInsert) {
        List<PricebookEntry> pbEntries = new List<PricebookEntry>();
        for(Product product : products) {
            // Creating a new PricebookEntry for each product
            pbEntries.add(new PricebookEntry(
                Pricebook2Id = Test.getStandardPricebookId(),
                ProductId = product.Id,
                UnitPrice = 1000,
                IsActive = true
            ));
        }
        // Insert PricebookEntries into the database if doInsert is true
        if(doInsert) {
            insert pbEntries;
        }
        return pbEntries;
    }

    /**
     * Creates a list of Order records associated with given accounts.
     * 
     * @param accounts   The list of Account records to associate with Orders.
     * @param numRecords The number of Order records to create.
     * @param doInsert   If true, inserts the records into the database.
     * @return           A list of Order records.
     */
    // Method to create Orders
    // This method creates Order records associated with a list of Account records.
    // The conditional insertion pattern is used here as well.
    public static List<Order> createOrders(List<Account> accounts, Integer numRecords, Boolean doInsert) {
        List<Order> orders = new List<Order>();
        for(Integer i = 0; i < numRecords; i++) {
            // Creating new Order associated with an Account
            Order newOrder = new Order();
            newOrder.AccountId = accounts[i % accounts.size()].Id;
            orders.add(newOrder);
        }
        // Insert orders into the database if doInsert is true
        if(doInsert) {
            insert orders;
        }
        return orders;
    }
    

    /**
     * Creates a list of OrderItem records associated with given orders and pricebook entries.
     * 
     * @param orders    The list of Order records to associate with OrderItems.
     * @param pbEntries The list of PricebookEntry records to associate with OrderItems.
     * @param doInsert  If true, inserts the records into the database.
     * @return          A list of OrderItem records.
     */
     // Method to create OrderItems
    // This method creates OrderItem records linked to Orders and PricebookEntries.
    // The records can be inserted into the database based on the doInsert flag.
    public static List<OrderItem> createOrderItems(List<Order> orders, List<PricebookEntry> pbEntries, Boolean doInsert) {
        List<OrderItem> orderItems = new List<OrderItem>();
        for(Order order : orders) {
            for(PricebookEntry pbe : pbEntries) {
                // Creating new OrderItem for each Order and PricebookEntry
                orderItems.add(new OrderItem(
                    OrderId = order.Id, 
                    PricebookEntryId = pbe.Id, 
                    Quantity = 10, 
                    UnitPrice = pbe.UnitPrice
                ));
            }
        }
        // Insert OrderItems into the database if doInsert is true
        if(doInsert) {
            insert orderItems;
        }
        return orderItems;
    }
}
