public with sharing class requestHelper {
    public static String request(String endPoint, Boolean flag) {
        httpRequest request = new httpRequest();
        request.setEndpoint(endpoint);
        request.setMethod('GET');
        request.setHeader('Content-Type', 'application/json');
        request.setHeader('Accept', 'application/json');
        Http http = new Http();
        try{
            HttpResponse response = http.send(request);
            if(response.getStatusCode() == 200){
                return response.getBody();
            }else{
                return response.getBody();
            }
        }catch(Exception error){
            System.debug('ERROR: '+error.getMessage());
            return error.getMessage();
        }
    }
}