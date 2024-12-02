
@isTest
global class MockHttpResponseGenerator implements HttpCalloutMock {

    private String body;

    public MockHttpResponseGenerator(String body){
        this.body = body;
    }

    global HTTPResponse respond(HTTPRequest req) {
        HttpResponse res = new HttpResponse();
        res.setHeader('Content-Type', 'application/json');
        res.setBody(this.body);
        res.setStatusCode(200);
        return res;
    }
}