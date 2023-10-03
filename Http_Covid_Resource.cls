public with sharing class Http_Covid_Resource {
    public static HttpResponse getCovidDailyResponse(){
        HttpResponse response = new HttpResponse();
        HttpRequest request = new HttpRequest();
        Http httpInstance = new Http();
        try {
            request.setMethod('GET');
            request.setEndpoint('callout:Daily_Covid_Service');
            response = httpInstance.send(request);
            System.debug('Response: '+response);
        } catch (Exception e) {
            System.debug('Exception: '+e.getMessage());
        }
        return response;
    }
}
