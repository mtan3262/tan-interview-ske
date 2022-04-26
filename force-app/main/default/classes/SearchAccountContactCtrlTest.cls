/**
*   @Author: Cao Tan
*   @Description: Test for class SearchAccountContactCtrl
*   @Date: 25/04/2022
**/
@isTest
public class SearchAccountContactCtrlTest {
    @isTest static void searchTest(){
        SearchAccountContactCtrl searchAccountContactCtrl = new SearchAccountContactCtrl();
        searchAccountContactCtrl.wordKey = 'ABC';
        Account account = new Account(Name = 'ABC Test');
        INSERT account;
        Contact contact = new Contact(AccountId=account.id, LastName='abc Contact test');
        INSERT contact;
        Id [] fixedSearchResults= new Id[2];
        fixedSearchResults[0] = account.Id;
        fixedSearchResults[1] = contact.Id;
        System.Test.setFixedSearchResults(fixedSearchResults);
        searchAccountContactCtrl.search();
        system.assert(searchAccountContactCtrl.results.size() == 2);
    }
    
    @isTest static void incrementCounterTest1(){
        Account account = new Account(Name = 'ABC Test');
        INSERT account;
        Decimal result = SearchAccountContactCtrl.incrementCounter(account.id);
        system.assert(result == 1);
    }
    
     @isTest static void incrementCounterTest2(){
        Account account = new Account(Name = 'ABC Test');
        INSERT account;
        Contact contact = new Contact(AccountId=account.id, LastName='ABC Contact test');
        INSERT contact;
        Decimal result = SearchAccountContactCtrl.incrementCounter(contact.Id);
        system.assert(result == 1);
    }


}