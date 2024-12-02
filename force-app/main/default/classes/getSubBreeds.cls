public with sharing class getSubBreeds {
    @auraEnabled(cacheable=true)
    public static String getSubBreeds(String breed){
        httpRequest request = new httpRequest();
        request.setEndpoint('https://dog.ceo/api/breed/'+breed+'/list');
        request.setMethod('GET');
        request.setHeader('Content-Type', 'application/json');
        request.setHeader('Accept', 'application/json');
        Http http = new Http();
        HttpResponse response = http.send(request);
        if(response.getStatusCode() == 200){
            subBreedWrapper wrapper = subBreedWrapper.parse(response.getBody());
            System.debug(wrapper.message);
            return JSON.serialize(wrapper);
        }else{
            System.debug('Todo mal');
            return response.getBody();
        }
    }
}