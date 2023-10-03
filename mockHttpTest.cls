
@isTest
global class mockHttpTest implements HttpCalloutMock {
    global HTTPResponse respond(HTTPRequest req) {
        HTTPResponse response = new HTTPResponse();
        response.setStatusCode(200);
        CovidTable_Controller.WrapperClass element = new CovidTable_Controller.WrapperClass();       
        element.dateChecked = '2021-03-04T24:00:00Z';
        element.hash = 'test';
        element.positive = 19;
        element.negative = 213;
        element.hospitalizedCurrently = 10;
        List<CovidTable_Controller.WrapperClass> body = new List<CovidTable_Controller.WrapperClass>();
        body.add(element);
        response.setBody(JSON.Serialize(body));
        return response;
    }
}
