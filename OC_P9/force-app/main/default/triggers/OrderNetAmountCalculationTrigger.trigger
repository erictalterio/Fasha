trigger OrderNetAmountCalculationTrigger on Order (before update) {
    for (Order ord : Trigger.new) {
        ord.NetAmount__c = ord.TotalAmount - ord.ShipmentCost__c;
    }
}
