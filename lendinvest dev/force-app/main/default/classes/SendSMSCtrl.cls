/**
 * @description       : This Apex class provides a method for sending an SMS using the Twilio API
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 12-29-2022
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/
public class SendSMSCtrl {
    // The @AuraEnabled annotation allows this method to be called from a Lightning Web Component
    @AuraEnabled
    // This method sends an SMS using the Twilio API
    public static String SendSMS(String phoneNo, String smsBody, String fromPhNumber){

      List<Oauth__mdt> oA1 = [SELECT AccountSid__c, Password__c FROM Oauth__mdt LIMIT 1];
        // The account SID and auth token are used to authenticate the request to the Twilio API
        String accountSid = oA1[0].AccountSid__c; 
        String token =  oA1[0].Password__c; 

   
        // The endpoint for sending SMS messages using the Twilio API
        String endPoint = 'https://api.twilio.com/2010-04-01/Accounts/'+accountSid+'/SMS/Messages.json';
        // The credentials are encoded in base64
        Blob creds = Blob.valueOf(accountSid+':' +token);
        // Create an HTTP request
        HttpRequest req = new HttpRequest();
        Http http = new Http();
        HTTPResponse res = new HTTPResponse();
        // Set the endpoint and method for the request
        req.setEndpoint(endPoint);
        req.setMethod('POST');
        // The version of the Twilio Salesforce library being used
        String VERSION  = '3.2.0';
        // Set the headers for the request
        req.setHeader('X-Twilio-Client', 'salesforce-' + VERSION);
        req.setHeader('User-Agent', 'twilio-salesforce/' + VERSION);
        req.setHeader('Accept', 'application/json');
        req.setHeader('Accept-Charset', 'utf-8');
        // Set the authorization header with the base64-encoded credentials
        req.setHeader('Authorization', 'Basic '+EncodingUtil.base64Encode(creds));
        // Set the body of the request with the phone number, message, and from number
        req.setBody('To=' + EncodingUtil.urlEncode(phoneNo, 'UTF-8') + '&From=' + EncodingUtil.urlEncode(fromPhNumber,'UTF-8') + '&Body=' + smsBody);
        // Send the request and store the response
        res = http.send(req);
        // Debug the response body
        System.debug(res.getBody());
 
       // If the request was successful (HTTP status code 201), return a success message
       if(res.getStatusCode() == 201){
           return 'SMS Sent Successfully';
       } 
       //
       // If there was an error, deserialize the error response and throw an exception with the error message
       else{
        errorWrapper er = (errorWrapper)json.deserialize(res.getBody(), errorWrapper.class);
        throw newMessageException('Error : ' + er.message);
    }
 }

 // This inner class is used to deserialize the error response from Twilio
 public class errorWrapper{
    String code;
    String message;
    String moreInfo;
    String status; 
}

 // This helper method creates and returns a new AuraHandledException with the given message
 private static AuraHandledException newMessageException(String message) {
     AuraHandledException e = new AuraHandledException(message);
     e.setMessage(message);
     return e;
 }
}
