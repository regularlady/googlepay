### JSON EventTicketClass

    parameters = 
     {
        "kind": "walletobjects#eventTicketClass",
        "id": "3388000000002437969.123456789",
        "reviewStatus": "underReview",
        "issuerName": "Your Company Name",
        "eventName": {
          "kind": "walletobjects#localizedString",
          "translatedValues": [
              {
                  "kind": "walletobjects#translatedString",
                  "language": "en-US",
                  "value": "Exciting Event"
              }  ],
          "defaultValue": {
              "kind": "walletobjects#translatedString",
              "language": "en-US",
              "value": "Ticket"
          }
        }
      }

### JSON EventTicketObject

    parameters = 
      {
        "classId": "3388000000002437969.1234567890",
        "id": "3388000000002437969.123",
        "state": "active", 
        "origin": "https://brittanymartin.dev"   
      }    
