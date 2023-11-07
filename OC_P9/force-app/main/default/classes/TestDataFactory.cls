@isTest
public class TestDataFactory {
    // Reusable method to create Accounts
    public static List<Account> createAccounts(Integer numAccounts) {
        List<Account> accountsList = new List<Account>();
        for (Integer i = 0; i < numAccounts; i++) {
            accountsList.add(new Account(Name = 'Test Account ' + i));
        }
        insert accountsList;
        return accountsList;
    }

    // Additional methods to create other test data like Products, PricebookEntries, Orders, etc.
}
