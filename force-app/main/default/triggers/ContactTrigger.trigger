trigger ContactTrigger on Contact (after insert, after update, after delete) {
    if (Trigger.isAfter) {
        if (Trigger.isInsert) {
            ContactTriggerHandler.autoSubmitApproval(Trigger.new);
        }
        
        if (Trigger.isUpdate) {
            ContactTriggerHandler.updateTotalContacts(Trigger.new, Trigger.oldMap);
        }

        if (Trigger.isDelete) {
            ContactTriggerHandler.updateTotalContactsWhenDelete(Trigger.old);
        }
    }
}