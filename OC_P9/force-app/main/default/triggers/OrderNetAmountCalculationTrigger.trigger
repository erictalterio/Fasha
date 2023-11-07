/**
 * Trigger for calculating the Net Amount on Orders before they are updated in the database.
 * This trigger runs in the 'before update' context, ensuring that the calculation is made
 * with the most recent data before the Order is saved.
 */
trigger OrderNetAmountCalculationTrigger on Order (before update) {
    // Loop through each Order that is being updated.
    for (Order ord : Trigger.new) {
        // Calculate the Net Amount by subtracting the Shipment Cost from the Total Amount.
        // Net Amount is a custom field that holds the Order's total after shipment costs.
        ord.NetAmount__c = ord.TotalAmount - ord.ShipmentCost__c;
    }
}
