/**
*   @Author: Cao Tan
*   @Description: Class ContactRestApi for Task 4
*   @Date: 25/04/2022
**/
@RestResource(urlMapping='/contacts/*')
global with sharing class ContactRestApi {
    @HttpPut
    global static void doPut() {
        Response response = new Response();
        try {
            Request reqBody = new Request();
            update reqBody.listContact;
            response.message = 'Update Success';
        } catch (DmlException error) {
            response.statusCode = 422;
            response.success = false;
            response.message = 'Update Fail';
            response.error = error.getMessage();
        } catch (Exception error) {
            response.statusCode = 500;
            response.success = false;
            response.message = 'Internal Server Error';
            response.error = error.getMessage();
        } finally {
            response.send();
        }
    }
    class Request {
        List<Contact> listContact;
        public Request() {
            listContact = new List<Contact>();
            Map<String, Object> params = (Map<String, Object>) JSON.deserializeUntyped(RestContext.request.requestBody.toString());
            List<Object> data = (List<Object>) params.get('contacts');
            for (Object item : data) {
                listContact.add((Contact) JSON.deserializeStrict(JSON.serialize(item), Contact.class));
            }
        }
    }

    class Response {
        public Integer statusCode;
        public Boolean success;
        public String error;
        public String message;

        public Response() {
            this.statusCode = 200;
            this.success = true;
            this.message = '';
            this.error = '';
        }

        public void send() {
            RestContext.response.addHeader('Content-Type', 'application/json');
            RestContext.response.statuscode = this.statusCode;
            RestContext.response.responseBody = Blob.valueOf(JSON.serializePretty(this));
        }
    }
}