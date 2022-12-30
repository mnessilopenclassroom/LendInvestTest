/**
 * @description       : This trigger updates the customer classification and first time gold classification
 *                      for accounts whose Total_Customer_Spend__c field has been updated.
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 12-27-2022
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/
trigger UpdateCustomerClassification on Account (before update) {
    // Retrieve the trigger accounts
    List<Account> accounts;
    if (Trigger.isUpdate) {
        // If this is an update trigger, loop through the new accounts and
        // add any accounts where the Total_Customer_Spend__c field was updated
        accounts = new List<Account>();
        for (Account a : Trigger.new) {
            Account oldAccount = Trigger.oldMap.get(a.Id);
            if (oldAccount.Total_Customer_Spend__c != a.Total_Customer_Spend__c) {
                accounts.add(a);
            }
        }
    } else {
        // If this is not an update trigger, just use the new accounts as is
        accounts = Trigger.new;
    }

    // Update the customer classification and first time gold classification for the trigger accounts
    CustomerClassificationUtil.updateClassification(accounts);
    
}

