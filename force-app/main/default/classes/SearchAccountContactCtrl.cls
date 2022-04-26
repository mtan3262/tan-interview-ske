/**
*   @Author: Cao Tan
*   @Description: SearchAccountContactCtrl for Task2 and Task 3
*   @Date: 25/04/2022
**/
public class SearchAccountContactCtrl {
    public String wordKey {get;set;}
    public List<ResultWrapper> results {get; set;}
    public SearchAccountContactCtrl() {}

    public void search(){
        this.results = new List<ResultWrapper>();
        List<List<SObject>> searchList = [
            FIND :wordKey IN NAME FIELDS 
            RETURNING Account(Id, Name, Counter__c), Contact(Id, Name, Counter__c)
        ];
        Account[] accounts = (Account[]) searchList[0];
        Contact[] contacts = (Contact[]) searchList[1];
        for (Account account : accounts) {
            this.results.add(new ResultWrapper(account, SObjectType.Account.getLabel()));
        }
        for (Contact contact : contacts) {
            this.results.add(new ResultWrapper(contact, SObjectType.Contact.getLabel()));
        }
    }

    @RemoteAction
    public static Decimal incrementCounter(Id recordId) {
        String sObjName = recordId.getSObjectType().getDescribe().getName();
        Decimal counterReturn = 0;
        if (sObjName == SObjectType.Account.getName()) {
            Account account = [Select Id, Counter__c from Account where Id = :recordId];
            Decimal counter = account.Counter__c == NULL ? 0 : account.Counter__c;
            account.Counter__c = counter + 1;
            UPDATE account;
            counterReturn = account.Counter__c;
        }
        if (sObjName == SObjectType.Contact.getName()) {
            Contact contact = [Select Id, Counter__c from Contact where Id = :recordId];
            Decimal counter = contact.Counter__c == NULL ? 0 : contact.Counter__c;
            contact.Counter__c = counter + 1;
            UPDATE contact;
            counterReturn = contact.Counter__c;
        }
        return counterReturn;
    }

    public class ResultWrapper {
        public String id {get; set;}
        public String name {get; set;}
        public String objectName {get; set;}
        public String link {get; set;}
        public Decimal counter {get; set;}
 
        public ResultWrapper(SObject record, String objectName) {
            this.id = (String) record.get('Id');
            this.name = (String) record.get('Name');
            this.objectName = objectName;
            this.link = System.URL.getSalesforceBaseUrl().toExternalForm() + '/' + (String) record.get('Id');
            Decimal counter = (Decimal) record.get('Counter__c');
            this.counter = counter != NULL ? counter : 0;
           
        }
    }
}