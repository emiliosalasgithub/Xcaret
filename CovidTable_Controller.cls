public with sharing class CovidTable_Controller {
    @AuraEnabled
    public static List<covid_tracking__c> getCovidInfo(){
        return [SELECT Id, dateChecked__c, positive__c, negative__c, hospitalizedCurrently__c FROM covid_tracking__c ORDER BY dateChecked__c DESC LIMIT 50000];
    }

    @AuraEnabled
    public static void syncData(){
        //Llamar al servicio y actualizar la base de datos
        try {
            HttpResponse response = Http_Covid_Resource.getCovidDailyResponse();
            if(response.getStatusCode() == 200) {
                List<covid_tracking__c> record2Upsert = new List<covid_tracking__c>();
                List<WrapperClass> elements = (List<WrapperClass>)JSON.Deserialize(response.getBody(), List<WrapperClass>.class);
                for(WrapperClass element : elements) {
                    covid_tracking__c record = new covid_tracking__c(
                        dateChecked__c = Date.ValueOf(element.dateChecked.substring(0,10)),
                        positive__c = element.positive,
                        negative__c = element.negative,
                        hospitalizedCurrently__c = element.hospitalizedCurrently,
                        hash__c = element.hash
                    );
                    record2Upsert.add(record);
                }
                upsert record2Upsert covid_tracking__c.hash__c;
            }
        } catch (Exception e) {
            System.debug('Error: '+e.getMessage());
        }
    }

    public class WrapperClass {
        public String dateChecked;
        public String hash;
        public Integer positive;
        public Integer negative;
        public Integer hospitalizedCurrently;
    }
}
