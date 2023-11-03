global class UpdateAccounts implements Database.Batchable<sObject>{
    
    global Database.QueryLocator start(Database.BatchableContext info)
    {
        private static final String ACCOUNT_QUERY =
            'SELECT Id ' +
            'FROM Account ' +
            'WHERE Id IN (SELECT AccountId ' +
            'FROM Order ' +
            'WHERE Status = \'Ordered\' ' +
            'AND AccountId != null)';
        return Database.getQueryLocator(ACCOUNT_QUERY);
    }
    
    global void execute(Database.BatchableContext info, List<Account> scope)
    {
        Map<Id, Decimal> accountIdToTotalAmountMap = new Map<Id, Decimal>();

        try {
            for (Order orderRecord : [SELECT AccountId, TotalAmount FROM Order WHERE AccountId IN :scope]) {
                if (accountIdToTotalAmountMap.containsKey(orderRecord.AccountId))
                    accountIdToTotalAmountMap.put(orderRecord.AccountId, accountIdToTotalAmountMap.get(orderRecord.AccountId) + orderRecord.TotalAmount);

                else
                    accountIdToTotalAmountMap.put(orderRecord.AccountId, orderRecord.TotalAmount);
            }

            for (Account myAccount : scope) {
                if (accountIdToTotalAmountMap.containsKey(myAccount.Id))
                    myAccount.Chiffre_d_affaire__c = accountIdToTotalAmountMap.get(myAccount.Id);
                else
                    myAccount.Chiffre_d_affaire__c = 0;

                update myAccount;
            }
        } catch (Exception e) {
            // Handle the exception, log it, or perform necessary actions
            System.debug('An error occurred: ' + e.getMessage());
        }
    }   
    
   global void finish(Database.BatchableContext info){     
       
   } 
}