/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 12-28-2022
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/
@isTest
public class TwilioHttpCalloutMock implements HttpCalloutMock {
    private HttpResponse response;

    public TwilioHttpCalloutMock(HttpResponse response) {
        this.response = response;
    }

    public HTTPResponse respond(HTTPRequest request) {
        return response;
    }
}
