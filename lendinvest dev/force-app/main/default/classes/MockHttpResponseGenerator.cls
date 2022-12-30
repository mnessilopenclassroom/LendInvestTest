/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 12-29-2022
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/
// Mock HTTP response generator
public class MockHttpResponseGenerator implements HttpCalloutMock {
    private HttpResponse response;
    public MockHttpResponseGenerator(HttpResponse response) {
        this.response = response;
    }
    public HTTPResponse respond(HTTPRequest request) {
        return response;
    }
}
