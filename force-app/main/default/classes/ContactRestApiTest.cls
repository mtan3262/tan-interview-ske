/**
*   @Author: Cao Tan
*   @Description: Test for class ContactRestApi
*   @Date: 26/04/2022
**/
@isTest
public class ContactRestApiTest{
    @isTest
    static void doPutTest1() {
        Contact contact = new Contact(LastName='abc Contact test');
        INSERT contact;
        RestRequest req = new RestRequest(); 
        RestResponse res = new RestResponse();

        String bodyString = '{ "contacts" : [ { "Id": "'+contact.Id+'", "Phone": "0776645592","Email": "mtan5592@gmail.com"}]}';
        
        req.requestURI = '/services/apexrest/contacts/';
        req.httpMethod = 'PUT';
        req.requestBody = Blob.valueOf(bodyString);
        
        RestContext.request = req;
   	    RestContext.response= res;
        
        Test.startTest();
        ContactRestApi.doPut();
        Test.stopTest();
        
        System.assertEquals(200, res.statusCode);
    }
    
    @isTest
    static void doPutTest2() {
        Contact contact = new Contact(LastName='abc Contact test');
        INSERT contact;
        RestRequest req = new RestRequest(); 
        RestResponse res = new RestResponse();

        String bodyString = '{ "contacts" : [ { "Id": "'+contact.Id+'test", "Phone": "0776645592","Email": "mtan5592@gmail.com"}]}';
        
        req.requestURI = '/services/apexrest/contacts/';
        req.httpMethod = 'PUT';
        req.requestBody = Blob.valueOf(bodyString);
        
        RestContext.request = req;
   	    RestContext.response= res;
        
        Test.startTest();
        ContactRestApi.doPut();
        Test.stopTest();
        
        System.assertEquals(422, res.statusCode);
    }
    
    @isTest
    static void doPutTest3() {
        Contact contact = new Contact(LastName='abc Contact test');
        INSERT contact;
        RestRequest req = new RestRequest(); 
        RestResponse res = new RestResponse();
        
        req.requestURI = '/services/apexrest/contacts/';
        req.httpMethod = 'PUT';
        req.requestBody = Blob.valueOf(JSON.serializePretty(contact));
        
        RestContext.request = req;
   	    RestContext.response= res;
        
        Test.startTest();
        ContactRestApi.doPut();
        Test.stopTest();
        
        System.assertEquals(500, res.statusCode);
    }
}