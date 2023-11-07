public without sharing class MyTeamOrdersController {
    // Holds the sum of all orders
    public Decimal sumOrders {
        get; // This makes the variable accessible to the page or component that uses this controller
        private set; // This restricts setting the variable value to within this class only
    }

    // Constructor for the controller class
    public MyTeamOrdersController() {
        // When an instance of this controller is created, calculate the sum of orders
        sumOrders = calculateSumOrders();
    }

    // A helper method that calculates the total sum of orders
    private Decimal calculateSumOrders() {
        // Perform a SOQL query to calculate the sum of the 'TotalAmount' field across all Order records
        AggregateResult groupedResults = [SELECT SUM(TotalAmount) total FROM Order];
        // The result of the aggregation (SUM) is retrieved and cast to Decimal type, then returned
        return (Decimal)groupedResults.get('total');
    }
}
