'use strict';
const Alexa = require('ask-sdk-core');
const https = require('https');
const token = '00D0o000001RLcN!ARkAQBtJ9W0FG9O4SOZb2LqcOERVqAuqXOh4ZVnNRkaRWwwHfGc_J14B.W38ats.mBLYSo1olYHdWt20dojt_FcrOTQ4zzmT';
const request = require('request');
const axios = require('axios');


const LaunchRequestHandler = {
	canHandle(handlerInput) {
		return handlerInput.requestEnvelope.request.type === 'LaunchRequest';
	},
	handle(handlerInput) {
		const speech = 'Welcome to the Alexa skills kit, you can say hello!.';
		return handlerInput.responseBuilder
				.speak(speechText)
				.reprompt(speechText)
				.withSimpleCard('Hello world', speechText)
				.getResponse();
	}
};


//// HELLO WORLD HANDLER
const HelloWorldIntentHandler = {
    canHandle(handlerInput) {
        return handlerInput.requestEnvelope.request.type === 'IntentRequest'
            && handlerInput.requestEnvelope.request.intent.name === 'HelloWorldIntent';
    },
    async handle(handlerInput) {
        let speechText = 'Hi Mirketa, Hope you guys are enjoying Hackathon. I am really Excited about today';
        await axios.get('https://404notfound-dev-ed.my.salesforce.com/services/apexrest/adityaservice/test', {
        	headers: {
        		'Authorization' : 'OAuth ' + token
        	}
        }).then((response) => {
        	console.log(JSON.stringify(response.data));
        	//speechText = response.data.ssml;
        })
        .catch((err) => {
        	console.log('error---' + err);
        });
        //const speechText = abc.data;
return handlerInput.responseBuilder
            .speak(speechText)
            .withSimpleCard('Hello World', speechText)
            .getResponse();    
    }
};


//MOST RECENT LEAD HANDLER
const mostRecentLeadIntentHandler = {
    canHandle(handlerInput) {
        return handlerInput.requestEnvelope.request.type === 'IntentRequest'
            && handlerInput.requestEnvelope.request.intent.name === 'mostRecentLeadIntent';
    },
    async handle(handlerInput) {
        let speechText = 'Cannot find the most recent lead right now. Sorry.';
        await axios.get('https://404notfound-dev-ed.my.salesforce.com/services/apexrest/adityaservice/test', {
            headers: {
                'Authorization' : 'OAuth ' + token
            }
        }).then((response) => {
            console.log(JSON.stringify(response.data));
            speechText = response.data.ssml;
        })
        .catch((err) => {
            console.log('error' + err);
        });
        //const speechText = abc.data;
return handlerInput.responseBuilder
            .speak(speechText)
            .withSimpleCard('Hello World', speechText)
            .getResponse(); 
    }
}

///CREATE LEAD HANDLER
const createLeadIntentHandler = {
    canHandle(handlerInput) {
        return handlerInput.requestEnvelope.request.type === 'IntentRequest'
            && handlerInput.requestEnvelope.request.intent.name === 'createLeadIntent';
    },
    async handle(handlerInput) {
        let speechText = "Cannot add a new lead right now. Sorry.";
        console.log('lead name--' + handlerInput.requestEnvelope.request.intent.slots.leadName.value);
        console.log('company name--' + handlerInput.requestEnvelope.request.intent.slots.company.value);
        await axios.post('https://404notfound-dev-ed.my.salesforce.com/services/apexrest/adityaservice/createlead', {
            lead_name: handlerInput.requestEnvelope.request.intent.slots.leadName.value,
            company: handlerInput.requestEnvelope.request.intent.slots.company.value
        }, {
            headers: {
                'Authorization' : 'OAuth ' + token
            }
        }).then((response) => {
            console.log(JSON.stringify(response.data));
            console.log('status---' + response.status);
            if(response.status.toString() == "200") {
                speechText = "Lead added successfully."
            }
            if(response.status.toString() != "200") {
                speechText = "Cannot add a lead right now. Sorry.";
            }
        })
        .catch((err) => {
            console.log('error---' + err);
        });

        return handlerInput.responseBuilder
            .speak(speechText)
            .withSimpleCard('Hello World', speechText)
            .getResponse();
    }
}


//CONVERT LEAD HANDLER
const convertLeadIntentHandler = {
    canHandle(handlerInput) {
        return handlerInput.requestEnvelope.request.type === 'IntentRequest'
            && handlerInput.requestEnvelope.request.intent.name === 'convertLeadIntent';
    },
    async handle(handlerInput) {
        let speechText = "Hey can't convert this lead at this moment. Sorry."
        console.log(handlerInput.requestEnvelope.request.intent.slots.leadName.value);
        await axios.post('https://404notfound-dev-ed.my.salesforce.com/services/apexrest/adityaservice/test',{
            lead_name: handlerInput.requestEnvelope.request.intent.slots.leadName.value
        } ,{
            headers: {
                'Authorization' : 'OAuth ' + token
            }
        }).then((response) => {
            console.log(JSON.stringify(response.data));
            console.log('status-- ' + response.status);
            //console.log(response.headers);
            if (response.status.toString() == "200") {
                speechText = "Hey got a good response, your lead is converted."
            }
            if (response.status.toString() != "200") {
                speechText = "Cannot find a lead."
            }
        })
        .catch((err) => {
            console.log('error--' + err)
        });

        return handlerInput.responseBuilder
            .speak(speechText)
            .withSimpleCard('Hello World', speechText)
            .getResponse();
    }
}


//EMAIL MESSAGE HANDLER
const emailMessageIntentHandler = {
    canHandle(handlerInput) {
        return handlerInput.requestEnvelope.request.type === 'IntentRequest'
            && handlerInput.requestEnvelope.request.intent.name === 'emailMessageIntent';
    },
    async handle(handlerInput) {
        let speechText = "Hey can't send an email right now, check your limits on Salesforce."
        console.log(handlerInput.requestEnvelope.request.intent.slots.leadName.value);
        console.log(handlerInput.requestEnvelope.request.intent.slots.emailMessage.value);
        await axios.post('https://404notfound-dev-ed.my.salesforce.com/services/apexrest/adityaservice/email',{
            lead_name: handlerInput.requestEnvelope.request.intent.slots.leadName.value,
            message: handlerInput.requestEnvelope.request.intent.slots.emailMessage.value
        } ,{
            headers: {
                'Authorization' : 'OAuth ' + token
            }
        }).then((response) => {
            console.log(JSON.stringify(response.data));
            console.log('status-- ' + response.status);
            //console.log(response.headers);
            speechText = "Hey got a good response, your email is sent."
        })
        .catch((err) => {
            console.log('error--' + err)
        });

        return handlerInput.responseBuilder
            .speak(speechText)
            .withSimpleCard('Hello World', speechText)
            .getResponse();
    }
}


//DELETE LEAD HANDLER
const deleteLeadIntentHandler = {
    canHandle(handlerInput) {
        return handlerInput.requestEnvelope.request.type === 'IntentRequest'
            && handlerInput.requestEnvelope.request.intent.name === 'deleteLeadIntent';
    },
    async handle(handlerInput) {
        let speechText = "Cannot delete the lead this moment."
        console.log(handlerInput.requestEnvelope.request.intent.slots.leadName.value);
        await axios.post('https://404notfound-dev-ed.my.salesforce.com/services/apexrest/adityaservice/deletelead',{
            lead_name: handlerInput.requestEnvelope.request.intent.slots.leadName.value
        }, {
            headers: {
                'Authorization' : 'OAuth ' + token
            }
        }).then((response) => {
            console.log(JSON.stringify(response.data));
            console.log('status---' + response.status);
            speechText = "Lead deleted successfully."
        })
        .catch((err) => {
            console.log('error---' + err);
        });
        return handlerInput.responseBuilder
            .speak(speechText)
            .withSimpleCard('Hello World', speechText)
            .getResponse();
    }
}

//LAST MESSAGE INTENT
const lastMessageIntentHandler = {
    canHandle(handlerInput) {
        return handlerInput.requestEnvelope.request.type === 'IntentRequest'
            && handlerInput.requestEnvelope.request.intent.name === 'lastMessageIntent';
    },
    handle(handlerInput) {
        const speechText = "Thank you Mirketa. I had a great time working with you guys. Hope to see you soon, till then have a great time and Enjoy the Pizza and Beer. Ta da";
        return handlerInput.responseBuilder
            .speak(speechText)
            .withSimpleCard('Hello World', speechText)
            .getResponse();
    }
}

const HelpIntentHandler = {
    canHandle(handlerInput) {
        return handlerInput.requestEnvelope.request.type === 'IntentRequest'
            && handlerInput.requestEnvelope.request.intent.name === 'AMAZON.HelpIntent';
    },
    handle(handlerInput) {
        const speechText = 'You can say hello to me!';
return handlerInput.responseBuilder
            .speak(speechText)
            .reprompt(speechText)
            .withSimpleCard('Hello World', speechText)
            .getResponse();
    }
};

const CancelAndStopIntentHandler = {
    canHandle(handlerInput) {
        return handlerInput.requestEnvelope.request.type === 'IntentRequest'
            && (handlerInput.requestEnvelope.request.intent.name === 'AMAZON.CancelIntent'
                || handlerInput.requestEnvelope.request.intent.name === 'AMAZON.StopIntent');
    },
    handle(handlerInput) {
        const speechText = 'Goodbye!';
return handlerInput.responseBuilder
            .speak(speechText)
            .withSimpleCard('Hello World', speechText)
            .getResponse();
    }
};


const SessionEndedRequestHandler = {
    canHandle(handlerInput) {
        return handlerInput.requestEnvelope.request.type === 'SessionEndedRequest';
    },
    handle(handlerInput) {
        //any cleanup logic goes here
        return handlerInput.responseBuilder.getResponse();
    }
};

const ErrorHandler = {
    canHandle() {
      return true;
    },
    handle(handlerInput, error) {
      console.log(`Error handled: ${error.message}`);
return handlerInput.responseBuilder
        .speak('Sorry, I can\'t understand the command. Please say again.')
        .reprompt('Sorry, I can\'t understand the command. Please say again.')
        .getResponse();
    },
};


exports.handler = Alexa.SkillBuilders.custom()
     .addRequestHandlers(LaunchRequestHandler,
                         HelloWorldIntentHandler,
                         mostRecentLeadIntentHandler,
                         createLeadIntentHandler,
                         convertLeadIntentHandler,
                         emailMessageIntentHandler,
                         deleteLeadIntentHandler,
                         lastMessageIntentHandler,
                         HelpIntentHandler,
                         CancelAndStopIntentHandler,
                         SessionEndedRequestHandler)
     .lambda();