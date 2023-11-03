public without sharing class MyTeamOrdersController {
    public Decimal sumOrders {
        get;
        private set;
    }

    public TeamOrderSumController() {
        sumOrders = calculateSumOrders();
    }

    private Decimal calculateSumOrders() {
        AggregateResult groupedResults = [SELECT SUM(TotalAmount) total FROM Order];
        return (Decimal)groupedResults.get('total');
    }
}
