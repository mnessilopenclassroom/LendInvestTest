/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 12-28-2022
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/
@isTest
private class TestAccountController {
    @isTest
    static void testGetAccountList() {
        // Start the test
        Test.startTest();
        // Set up the test data
        Account testAccount = new Account(Name='Test Account', Phone='+1234567890');
        insert testAccount;
        // Call the getAccountList method
        Account result = AccountController.getAccountList(testAccount.Id);
        // Verify that the result is the test account
        System.assertEquals(testAccount.Id, result.Id);
        System.assertEquals(testAccount.Phone, result.Phone);
        // Stop the test
        Test.stopTest();
    }
}
