public with sharing class WeekTwoHomework{


    public static void lessonA {
        /*Started with this approach. First tested the SOQL specifically, then did my best to get the syntax correct from memory.
        I missed a couple things (specifying sObject type the loop and missed a semicolon)
        But was able to figure it out and then rewrote it into the more efficient SOQL loop
        List<Contact> contactListA = [select id,name,account.name,account.Industry from contact limit 200];
        for(Contact c:contactListA){
            system.debug('Contact Account Name and Industry >> ' + c.account.name + ' -- ' + c.account.Industry);
        }
        */
        
        //A method that includes a query for a List of contacts and returns the Account Name and Industry as well.  
        //Use a loop to print the name of each Contact’s Account Name with System.debug.

        for(Contact c:[select id,name,account.name,account.Industry from contact order by account.industry,account.name limit 200]){
            system.debug('Contact Account Name and Industry >> ' + c.account.name + ' -- ' + c.account.Industry);

        }

         

    }

   public static void lessonB {
        //A method that includes a query for a list of Accounts AND includes all their closed-won opportunities in a subquery. 
        //Use a loop to print out the name of each Account’s opportunity with System.debug.

        //List<Account> accountListB = [select id,Name,(select id,Name from Opportunities where stageName = 'Closed Won') from Account limit 200];
        List<Opportunity> oppListB = new List<Opportunity>();
        for(Account a : [select id,Name,(select id,Name from Opportunities where stageName = 'Closed Won' order by name) from Account order by name limit 200]){
            for(Opportunity o : a.Opportunities){
                system.debug('Opportunity Name and Account Name are >> ' + o.name + ' -- ' + a.Name);
            }
        }
        
   } 

}




//A method that queries for Opportunity records that returns results in a map format.

//An aggregate results query that returns an integer equal to the total number of open opportunities in your org.
