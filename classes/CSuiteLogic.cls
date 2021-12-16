public class CSuiteLogic {
    
    public static void createCSuiteContact( List<Contact> passedCons ) {
        List<Contact> cons = queryContractFields(passedCons);
        List<C_Suite_Contact__c> csuites;
        
        if ( !cons.isEmpty() ) {
            
            csuites = new List<C_Suite_Contact__c>();
            
            for( Contact con : cons ){
                
                if ( checkcSuite(con) && con.AccountId != null ) {
                    C_Suite_Contact__c csc = new C_Suite_Contact__c();
                    csc.Account__c = con.AccountId;
                    csc.Contact__c = con.id;
                    csc.Title__c = con.Title;
                    csc.Name = con.Account.name + ' - ' + con.Title;
                    csuites.add(csc);
                }   
            } 
            try {
                
                insert csuites;
                
            } catch(DMLException e) {
                
                System.debug('Error in createCSuiteContact = ' + e);
                System.debug('Error line in createCSuiteContact = ' + e.getLineNumber());
                System.debug('Error cause in createCSuiteContact = ' + e.getCause());
            
            }
        } 
    }
    public static List<Contact> queryContractFields(List<Contact> cons){
        
        Set<Id>conIds = new Set<Id>();
        for(Contact con : cons){
            conIds.add(con.id);
        }
        if(!conIds.isEmpty()){
            List<Contact> retCons = [SELECT id,
                                        AccountId,
                                        Title,
                                        Account.name
                                     FROM Contact 
                                     WHERE id IN :conIds];
            return retCons;
            
        }
        return null;
    }
    
    public static Boolean checkcSuite( Contact con) {

        if ( !String.isEmpty(con.Title) ) {
            if(con.Title.contains('CFO') ||
              con.Title.contains('CIO') ||
              con.Title.contains('CEO') ||
              con.Title.contains('CMO') ||
              con.Title.contains('COO') ||
              con.Title.contains('CDO') ||
              con.Title.contains('Chief')) {
                  
               return true; 
                  
            } else {
                
                return false;
            }
            
        } else {
            
            return false;
        }
    }
}