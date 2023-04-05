public with sharing class WeekTwoHomework{

    // CJ - perhaps a more descriptive method name here? such as 'printContactsWithAccount'
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

        // CJ - I usually ALL CAPS SELECT, FROM, etc soql keywords to make it more clear what's an ApiName vs soql keyword
        // CJ - personal preference is also to put the soql statement outside of the for like your original, 
        // CJ - but I believe this would help with larger queries, though I'm not sure the batching would happen the same way since you set a limit
        // CJ - remember to also follow casing of your ApiNames, which is PascalCase (ie: Id, Name, Account.Name...)
        for(Contact c:[select id,name,account.name,account.Industry from contact order by account.industry,account.name limit 200]){
            system.debug('Contact Account Name and Industry >> ' + c.account.name + ' -- ' + c.account.Industry);

        }

         

    }

    // CJ - same comments as above with the code hygiene, but method looks good otherwise
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

   public static void lessonC {
        // CJ - is there a reason you set the limit to 2?
        //A method that queries for Opportunity records that returns results in a map format.
        Map<Id,Opportunity> oppMapC = new Map<Id,Opportunity>([SELECT ID, Name, Amount,stageName FROM Opportunity limit 2]);
        system.debug('Map is >>> ' + oppMapC);
       
        // CJ - would you know how to return the Map from this method?

   }


   public static void lessonD {
        //An aggregate results query that returns an integer equal to the total number of open opportunities in your org.
        Integer numOpenOpps = [select count() from Opportunity where isClosed = false];
        system.debug('Number of open opps is >>> ' + numOpenOpps); 
        // CJ - System is a class that is already define by Salesforce in Apex. Since we capitalize classes (like this file), 
        // CJ - System should be capitalized too to call its methods, like debug
        // CJ - would you know how to return the Integer from this method?
   }

}
