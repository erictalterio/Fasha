/**
 * Trigger on the Order object that executes in the 'before update' context.
 * It calculates and sets the Net Amount on each Order record before saving to the database.
 * The Net Amount is calculated as the difference between the Total Amount and the Shipment Cost.
 */
trigger OrderNetAmountCalculationTrigger on Order (before update) {
    // Iterate over each Order record in the trigger context
    for (Order ord : Trigger.new) {
        // Perform calculation only if both TotalAmount and ShipmentCost__c are not null
        if (ord.TotalAmount != null && ord.ShipmentCost__c != null) {
            // Calculate the Net Amount and assign it to the NetAmount__c field
            ord.NetAmount__c = ord.TotalAmount - ord.ShipmentCost__c;
        }
    }
}
