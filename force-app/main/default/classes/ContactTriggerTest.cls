/**
*   @Author: Cao Tan
*   @Description: Test for class ContactTriggerHandler
*   @Date: 25/04/2022
**/
@isTest
public class ContactTriggerTest {
    @isTest static void autoSubmitApprovalTest() {
        Account account = new Account(Name = 'Test');
        INSERT account;
        Contact contact = new Contact();
        contact.AccountId = account.id;
        contact.LastName = 'Contact test';
        INSERT contact;
        List<Contact> result = [SELECT id, Active__c FROM Contact LIMIT 1];
        system.assert(!result.isEmpty());
    }
    
    @isTest static void updateTotalContactsTest() {
        Account account = new Account(Name = 'Test');
        INSERT account;
        Contact contact = new Contact();
        contact.AccountId = account.id;
        contact.LastName = 'Contact test';
        INSERT contact;
        contact.Active__c = true;
        UPDATE contact;
        List<Account> results = [SELECT id, Total_Contacts__c FROM Account LIMIT 1];
        system.assert(results[0].Total_Contacts__c == 1);
    }
    
    @isTest static void updateTotalContactsWhenDeleteTest() {
        Account account = new Account(Name = 'Test');
        INSERT account;
        Contact contact = new Contact();
        contact.AccountId = account.id;
        contact.LastName = 'Contact test';
        INSERT contact;
        contact.Active__c = true;
        UPDATE contact;
        List<Account> results = [SELECT id, Total_Contacts__c FROM Account LIMIT 1];
        system.assert(results[0].Total_Contacts__c == 1);
        DELETE contact;
        results = [SELECT id, Total_Contacts__c FROM Account LIMIT 1];
        system.assert(results[0].Total_Contacts__c == 0);
    }
}