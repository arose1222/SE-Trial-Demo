@IsTest
private class AccountProcessingTest {
    @isTest static void setDefaultDescription(){
        Account acc = new Account(Name = 'My Test Account',Description='Default description');
        insert acc;
        acc = AccountProcessing.setDefaultDescription(acc);
        System.assertEquals('Default description', acc.Description);
    }
}