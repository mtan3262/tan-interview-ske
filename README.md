Technical Test

Username: caotan.interview@skedulo.com

Salesforce ORG: https://testexam-dev-ed.my.salesforce.com/

User for checking:

Username: thuannguyen.interview@skedulo.com

Email: thuan.nguyen@skedulo.com

# Task 1
Metadata:
| Metadata        | Type           | Note  |
| ------------- |:-------------:| :-----:|
| ContactTrigger      | Trigger| |
| ContactTriggerHandler      | Apex class      | |
| ContactTriggerTest | Apex class      | Coverage 100%|
| Active__c | Custom field      |    |
| Total_Contacts__c | Custom field      | |
| ApprovalContact | Approval Process     | |

# Task 2

Metadata:
| Metadata        | Type           | Note  |
| ------------- |:-------------:| :-----:|
| SearchAccountContactCtrl      | Apex class| |
| SearchAccountContactCtrlTest      | Apex class      | Coverage 100%|
| SearchAccountContactPage | Page      | |

Demo link :
https://testexam-dev-ed--c.visualforce.com/apex/SearchAccountContactPage

# Task 3

Metadata:
| Metadata        | Type           | Note  |
| ------------- |:-------------:| :-----:|
| SearchAccountContactCtrl      | Apex class| |
| SearchAccountContactCtrlTest      | Apex class      | Coverage 100%|
| Counter__c  (Account)    | Custom field      | |
| Counter__c  (Contact)    | Custom field      | |
| SearchAccountContactWithCounterPage | Page      | |

Demo link :
https://testexam-dev-ed--c.visualforce.com/apex/SearchAccountContactWithCounterPage

# Task 4

Metadata:
| Metadata        | Type           | Note  |
| ------------- |:-------------:| :-----:|
| ContactRestApi      | Apex class| |
| ContactRestApiTest      | Apex class      | Coverage 100%|
| RestApi | connected Apps      | |

URL RestAPI : https://testexam-dev-ed.my.salesforce.com/services/apexrest/contacts

1. Normal case

Request: 

    {
      "contacts" : [
          {
              "Id": "0035i0000027nvp",
              "Phone": "0776645592",
              "Email": "mtan5592@gmail.com",
              "LastName": "ABC Test 2"
          }
      ]
    }

Response:

    {
      "success": true,
      "statusCode": 200,
      "message": "Update Success",
      "error": ""
    }

2. Abnormal case

Request: 

    {
      "contacts" : [
          {
              "Id": "0035i0000027nvpTest",
              "Phone": "0776645592",
              "Email": "mtan5592@gmail.com",
              "LastName": "ABC Test 2"
          }
      ]
    }

Response:

    {
      "success": false,
      "statusCode": 422,
      "message": "Update Fail",
      "error": "Update failed. First exception on row 0 with id 0035i0000027nvpTest; first error: MALFORMED_ID, Contact ID: id value of incorrect type: 0035i0000027nvpTest: [Id]"
    }
    
3. Abnormal case

Request: 

    {
      "contactss" : [
          {
              "Id": "0035i0000027nvp",
              "Phone": "0776645592",
              "Email": "mtan5592@gmail.com",
              "LastName": "ABC Test 2"
          }
      ]
    }

Response:

    {
        "success": false,
        "statusCode": 500,
        "message": "Internal Server Error",
        "error": "Attempt to de-reference a null object"
    }
