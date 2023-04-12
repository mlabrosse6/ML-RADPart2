trigger LeadTrigger on Lead (after insert, after update){
    //*********************************************************************************************** */
    // Instantiate the Handler and set Trigger records
    LeadTriggerHandler handler = new LeadTriggerHandler(Trigger.new, Trigger.oldMap);

    if (Trigger.isInsert) {
        if(Trigger.isAfter){
            handler.handleAfterInsert();
        }
        
    } else if (Trigger.isUpdate){
        if(Trigger.isAfter){
            handler.handleAfterUpdate();
        }
    }
    
}