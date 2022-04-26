/**
*   @Author: Cao Tan
*   @Description: ContactTriggerHandler for Task 1
*   @Date: 25/04/2022
**/
public class ContactTriggerHandler {
    public static void autoSubmitApproval(List<Contact> contacts) {
        List<User> users = [SELECT id FROM User WHERE email = 'mtan3262@gmail.com' LIMIT 1];
        if (!users.isEmpty()) {
            for (Contact contact : contacts) {
                if (contact.AccountId != null) {
                    Approval.ProcessSubmitRequest approvalRequest = new Approval.ProcessSubmitRequest();
                    approvalRequest.setObjectId(contact.Id);
                    approvalRequest.setComments('Create contact approval');
                    approvalRequest.setNextApproverIds(new List<ID>{users[0].id});
                    Approval.ProcessResult approvalResult = Approval.process(approvalRequest);
                }
            }
        }
    }
    public static void updateTotalContactsWhenDelete(List<Contact> contacts) {
        Set<Id> accountIds = new Set<Id>();
        for(Contact contact : contacts) {
            if (contact.AccountId != null && contact.Active__c == true) {
                accountIds.add(contact.AccountId);
            }
        }
        if(!accountIds.isEmpty()) {
            updateTotalContactByAccountIds(accountIds);
        }
    }


    public static void updateTotalContacts(List<Contact> newContacts, Map<Id, Contact> oldContactMap) {
        Set<Id> accountIds = new Set<Id>();
        for(Contact contact : newContacts) {
            if (contact.AccountId != null && oldContactMap.get(contact.Id).Active__c != contact.Active__c) {
                accountIds.add(contact.AccountId);
            }
        }
        if(!accountIds.isEmpty()) {
            updateTotalContactByAccountIds(accountIds);
        }
    }



    private static void updateTotalContactByAccountIds(Set<Id> accountIds) {
        List<Account> needUpdateAccounts = [
            SELECT Id, Total_Contacts__c, (SELECT Id FROM Account.Contacts WHERE Active__c = TRUE) 
            FROM Account WHERE Id IN :accountIds
        ];
        if (!needUpdateAccounts.isEmpty()) {
            for(Account account : needUpdateAccounts) {
                account.Total_Contacts__c = account.Contacts.size();
            }
            UPDATE needUpdateAccounts;
        }
    }
}