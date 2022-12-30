/**
 * @description       : This class contains a utility method for updating the customer classification
 *                      for a list of accounts based on their Total_Customer_Spend__c field.
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 12-27-2022
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/
public class CustomerClassificationUtil {
    /**
     * Updates the customer classification for a list of accounts based on their Total_Customer_Spend__c field.
     * @param accounts A list of accounts to update.
     */
    public static void updateClassification(List<Account> accounts) {
        // Loop through the accounts and update their customer classification based on their Total_Customer_Spend__c field
        for (Account a : accounts) {
            if (a.Total_Customer_Spend__c >= 50000 && a.First_Time_Gold_Classification__c==false ) {
                a.Customer_Classification__c='GOLD';
                a.First_Time_Gold_Classification__c=true;
            } else if (a.Total_Customer_Spend__c >= 50000) {
                a.Customer_Classification__c='GOLD';
            }else if (a.Total_Customer_Spend__c >= 25000) {
                a.Customer_Classification__c='SILVER';
            } else if (a.Total_Customer_Spend__c >= 10000) {
                a.Customer_Classification__c='BRONZE';
            } else {
                a.Customer_Classification__c='';
            }
        }
    }
}
