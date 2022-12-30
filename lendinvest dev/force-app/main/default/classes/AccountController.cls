/**
 * @description       : This Apex class provides a method for retrieving a single Account record by Id
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 12-28-2022
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/
public with sharing class AccountController {
    // The @AuraEnabled annotation allows this method to be called from a Lightning Web Component
    // The cacheable=true parameter indicates that the result of this method can be cached by the client
    @AuraEnabled(cacheable=true)
    // This method returns a single Account record by Id
    public static Account getAccountList(String record) {
        // Query for a single Account record with the given Id and enforce sharing rules
        return [
            SELECT Id, Phone
            FROM Account
            WHERE Id =:record
            WITH SECURITY_ENFORCED
            LIMIT 1
        ];
    }
}
