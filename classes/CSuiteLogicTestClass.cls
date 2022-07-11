@isTest
private class CSuiteLogicTestClass {
    
    private static List<Contact>cons = new List<Contact>();
    private static Account testAccount;
    private static Contact con;
    
    static void setupMethod(){
        
        testAccount = new Account(
            Name = 'Test Account',
            Phone = '404.727.1213');
        
        insert testAccount;
        
        con = new Contact(
            FirstName = 'Test',
            LastName = 'Contact',
            Phone = '404.727.1212',
            Title = 'CEO',
            AccountId = testAccount.id);
        
        insert con;
        
        cons.add(con);
    }
    
    static testMethod void testCreateCSuiteContact() {
        setupMethod();
        Test.startTest();
        CSuiteLogic.createCSuiteContact(cons);
        Test.stopTest();
        
        System.assertEquals(1, cons.size());
    }
    
    static testMethod void testQueryContractFields() {
        setupMethod();
        Test.startTest();
        List<Contact>contacts = CSuiteLogic.queryContractFields(cons);
        Test.stopTest();
        
        System.assertEquals(1, contacts.size());
    }
    
    static testMethod void testCheckcSuite() {
        setupMethod();
        Test.startTest();
        Boolean cCheck = CSuiteLogic.checkcSuite(con);
        Test.stopTest();
        
        System.assertEquals(cCheck, true);
    }
    
}