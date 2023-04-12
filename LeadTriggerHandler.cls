public with sharing class LeadTriggerHandler {
    // -----------Trigger Recursion Control------------------------------------------------------
	static Boolean hasRunOnce = false;
    
    // -----------Trigger Handler Class Variables -----------------------------------------------
    List<Lead> newLeads;
    Map<ID, Lead> oldLeadMap;
    Map<ID, Lead> newLeadMap;

    // Constructor receives the accounts being processed by this trigger and assigns them to class variables
    public LeadTriggerHandler (List<Lead> newLeads, Map<ID, Lead> oldLeadMap) {
        this.newLeads = newLeads;
        this.oldLeadMap = oldLeadMap;
        this.newLeadMap = newLeadMap;
    }



    public void handleAfterInsert(){
        if(hasRunOnce) {
            return;
        }
        hasRunOnce = true;
        handleNewLeadsAfterInsert();
        hasRunOnce = false;             
    }

    public void handleAfterUpdate(){
        if(hasRunOnce) {
            return;
        }
        hasRunOnce = true;
        //handleLeadsAfterUpdate();
        hasRunOnce = false; 
    }

    //After Insert create a task to follow-up with the lead
    private void handleNewLeadsAfterInsert() {
        
        List<Task> newTaskList = new List<Task>();
        for (Lead l:newLeads) {
            Task newTask = new Task();
            newTask.WhatId = l.newLeadMap.Id;
            newTask.Subject = l.newLeadMap.ProductInterest__c;
            newTaskList.add(newTask);
        }
        insert newTaskList;
    }
    //After Udpate create a task to follow-up with the lead only if the product interest is updated
    /*private void handleLeadsAfterUpdate() {

    }*/
}