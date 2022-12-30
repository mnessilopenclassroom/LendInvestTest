/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 12-28-2022
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/

	@isTest
	private class TestCustomerClassificationUtil {
		@testSetup
		static void setup() {
			// Insert test accounts
			Account a1 = new Account(Name='Test Account 1', First_Time_Gold_Classification__c=false);
			Account a2 = new Account(Name='Test Account 2', First_Time_Gold_Classification__c=false);
			Account a3 = new Account(Name='Test Account 3', First_Time_Gold_Classification__c=false);
			Account a4 = new Account(Name='Test Account 4', First_Time_Gold_Classification__c=false);
			Account a5 = new Account(Name='Test Account 5', First_Time_Gold_Classification__c=false);
			Account a6 = new Account(Name='Test Account 6', First_Time_Gold_Classification__c=true);
			insert new Account[]{a1, a2, a3, a4, a5, a6};
	
		  // Insert test opportunities
		  Opportunity o1 = new Opportunity(Name='Test Opportunity 1', AccountId=a1.Id, Amount=50000, CloseDate=Date.today(), StageName='Closed Won');
		  Opportunity o2 = new Opportunity(Name='Test Opportunity 2', AccountId=a2.Id, Amount=25000, CloseDate=Date.today(), StageName='Closed Won');
		  Opportunity o3 = new Opportunity(Name='Test Opportunity 3', AccountId=a3.Id, Amount=10000, CloseDate=Date.today(), StageName='Closed Won');
		  Opportunity o4 = new Opportunity(Name='Test Opportunity 4', AccountId=a4.Id, Amount=5000, CloseDate=Date.today(), StageName='Closed Won');
		  Opportunity o5 = new Opportunity(Name='Test Opportunity 5', AccountId=a5.Id, Amount=0, CloseDate=Date.today(), StageName='Closed Won');
		  Opportunity o6 = new Opportunity(Name='Test Opportunity 6', AccountId=a6.Id, Amount=50000, CloseDate=Date.today(), StageName='Closed Won');
		  insert new Opportunity[]{o1, o2, o3, o4, o5, o6};

		}
		   
	
       

    @isTest
    static void testUpdateClassification() {
        test.startTest();

        // Retrieve test accounts
        List<Account> accounts = [SELECT Name, Total_Customer_Spend__c, First_Time_Gold_Classification__c, Customer_Classification__c FROM Account];

        // Update customer classifications
        CustomerClassificationUtil.updateClassification(accounts);

        // Check that customer classifications have been updated correctly
        for (Account a : accounts) {
            if (a.Name == 'Test Account 1' || a.Name == 'Test Account 6') {
                System.assertEquals('GOLD', a.Customer_Classification__c, 'Incorrect classification for ' + a.Name);
            } else if (a.Name == 'Test Account 2') {
                System.assertEquals('SILVER', a.Customer_Classification__c, 'Incorrect classification for ' + a.Name);
            } else if (a.Name == 'Test Account 3') {
                System.assertEquals('BRONZE', a.Customer_Classification__c, 'Incorrect classification for ' + a.Name);
            } else {
                System.assertEquals('', a.Customer_Classification__c, 'Incorrect classification for ' + a.Name);
            }
        }

        test.stopTest();
    }
}

