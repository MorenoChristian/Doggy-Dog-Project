public with sharing class getDogImagesByBreed {
    @auraEnabled(cacheable=true)
    public static String getDogImagesByBreed(String breed){
        httpRequest request = new httpRequest();
        request.setEndpoint('https://dog.ceo/api/breed/'+breed+'/images');
        request.setMethod('GET');
        request.setHeader('Content-Type', 'application/json');
        request.setHeader('Accept', 'application/json');
        Http http = new Http();
        HttpResponse response = http.send(request);
        if(response.getStatusCode() == 200){
            subBreedWrapper wrapper = subBreedWrapper.parse(response.getBody());
            return JSON.serialize(wrapper);
        }else{
            System.debug('Todo mal');
            return response.getBody();
        }
    }
}