/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 12-29-2022
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/
@isTest
private class TestSendSMSCtrl {
    @isTest
    static void testSendSMS() {
        // Start the test
        Test.startTest();
        // Set up the mock HTTP callout
        HttpResponse mockResponse = new HttpResponse();
        mockResponse.setBody('{"sid": "SM1234567890", "status": "queued"}');
        mockResponse.setStatusCode(200);
        HttpRequest mockRequest = new HttpRequest();
        mockRequest.setEndpoint('https://api.twilio.com/2010-04-01/Accounts/AC1234567890/Messages.json');
        mockRequest.setMethod('POST');
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator(mockResponse));
        // Set up the test data
        String phoneNo = '+1234567890';
        String smsBody = 'This is a test SMS message';
        String fromPhNumber = '+1234567891';
        // Call the SendSMS method
        String result = SendSMSCtrl.SendSMS(phoneNo, smsBody, fromPhNumber);
        // Verify that the result is 'SMS Sent Successfully'
        System.assertEquals('SMS Sent Successfully', result);
        // Stop the test
        Test.stopTest();
    }
}


