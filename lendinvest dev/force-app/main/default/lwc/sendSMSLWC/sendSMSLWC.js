import { LightningElement,api,wire } from 'lwc';
import SendSMSCtrl from "@salesforce/apex/SendSMSCtrl.SendSMS"; // Import the SendSMSCtrl Apex controller
import { ShowToastEvent } from 'lightning/platformShowToastEvent'; // Import the ShowToastEvent platform event
import getAccountList from '@salesforce/apex/AccountController.getAccountList'; // Import the getAccountList Apex controller

export default class SendSMSLWC extends LightningElement {
    smsBody; // Declare a property to store the SMS message body
    toPhoneNo; // Declare a property to store the phone number to send the message to
    @api recordId; // Declare a property to store the record ID of the current record (if applicable)
    accounts; // Declare a property to store the results of the getAccountList wire method
    error; // Declare a property to store any errors that occur

    @wire(getAccountList, { record: '$recordId' }) // Call the getAccountList Apex method and pass in the recordId as an argument
    wiredAccounts({ error, data }) { // Destructure the error and data properties from the wire method's response
        if (data) { // If data is returned
            this.accounts = data; // Set the accounts property to the returned data
            this.error = undefined; // Set the error property to undefined
            this.toPhoneNo = data.Phone; // Set the toPhoneNo property to the phone number retrieved from the data
        } else if (error) { // If an error occurs
            this.error = error; // Set the error property to the error
            this.accounts = undefined; // Set the accounts property to undefined
        }
    }
    
    sendSMS(){ // Declare the sendSMS method
       let inputFields = this.template.querySelectorAll('.fieldvalidate'); // Get all elements with the class "fieldvalidate"
        inputFields.forEach(inputField => { // Iterate over the input fields
            if(inputField.name == "smsBody"){ // If the input field is the SMS body field
                this.smsBody = inputField.value; // Set the smsBody property to the value of the field
            }
        });

        this.fromPhNumber = '6188925075'; // Set the fromPhNumber property to a fixed phone number

        this.handleSpinner(); // Call the handleSpinner method to update the spinner
        // Call the SendSMSCtrl Apex controller and pass in the toPhoneNo, smsBody, and fromPhNumber properties as arguments
        SendSMSCtrl({phoneNo : this.toPhoneNo, smsBody : this.smsBody, fromPhNumber : this.fromPhNumber})
            .then(result => { // If the Apex controller is successful
                console.log(result); // Log the result to the console

                // Dispatch a success toast event with a message indicating that the SMS was sent
                const evt = new ShowToastEvent({
                    title: "Yes, Sms sent!",
                    message: result,
                    variant: "success",
                });
                this.dispatchEvent(evt);

                this.handleSpinner(); // Call the handleSpinner
                                // method to update the spinner
            })
            .catch((error) => { // If an error occurs
                // Dispatch an error toast event with a message indicating that the SMS was unable to be sent
                const evt = new ShowToastEvent({
                    title: "Sorry, unable to send the Sms!",
                    message: error.body.message,
                    variant: "error",
                });
                this.dispatchEvent(evt);
                this.handleSpinner(); // Call the handleSpinner method to update the spinner
            })
    }
 
    handleSpinner(){ // Declare the handleSpinner method
        this.showSpinner = !this.showSpinner; // Toggle the value of the showSpinner property
    }
}

