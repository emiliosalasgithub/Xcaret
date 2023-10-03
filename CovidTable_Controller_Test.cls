@IsTest
private with sharing class CovidTable_Controller_Test {
    @TestSetup
    static void makeData(){
        covid_tracking__c tracking = new covid_tracking__c(
                dateChecked__c = Date.today(),
                positive__c = 12,
                negative__c = 14,
                hospitalizedCurrently__c = 5,
                hash__c = 'hashTest'
        );
        insert tracking;
    }

    @IsTest
    private static void getCovidInfoTest() {
        Test.StartTest();
        List<covid_tracking__c> lis = CovidTable_Controller.getCovidInfo();
        Test.StopTest();
        System.AssertEquals(true, lis.size() >0);
    }

    @IsTest
    private static void syncDataTest() {
        Test.setMock(HttpCalloutMock.class, new mockHttpTest());
        Test.StartTest();
        CovidTable_Controller.syncData();
        List<covid_tracking__c> lis = CovidTable_Controller.getCovidInfo();
        Test.StopTest();
        System.AssertEquals(true, lis.size() >1 );
    }
}
