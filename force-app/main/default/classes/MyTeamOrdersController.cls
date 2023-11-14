/**
 * Controller class for displaying the total sum of all orders on a Visualforce page.
 * This class calculates and provides the aggregate total amount from all orders.
 */
public without sharing class MyTeamOrdersController {
    
    /**
     * Holds the aggregate sum of all orders' total amounts.
     * Accessible to the Visualforce page using this controller.
     */
    public Decimal sumOrders {
        get; // Enables access to the sumOrders property in the Visualforce page
        private set; // Restricts modification of sumOrders within this class only
    }

    /**
     * Constructor: Initializes the controller and calculates the total sum of orders.
     */
    public MyTeamOrdersController() {
        sumOrders = calculateSumOrders(); // Calculate the sum of orders upon instantiation
    }

    /**
     * Calculates the total sum of the 'TotalAmount' field from all Order records.
     * 
     * @return The aggregate sum of the total amounts from all orders.
     */
    private Decimal calculateSumOrders() {
        AggregateResult groupedResults = [SELECT SUM(TotalAmount) total FROM Order];
        return (Decimal)groupedResults.get('total'); // Convert and return the aggregate sum
    }
}
