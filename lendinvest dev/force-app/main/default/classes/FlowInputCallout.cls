/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 12-28-2022
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/

Global class FlowInputCallout {
    // This variable represents the phone number to send the message to
    @InvocableVariable(label='number to ' description='The phone number to send the message to' required=true)
    public String to;

    // This variable represents the message to send
    @InvocableVariable(label='message to send' description='The message to send to the specified phone number' required=true)
    public String message;
}


    

