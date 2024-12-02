public with sharing class getAllBreeds {
    @auraEnabled(cacheable=true)
    public static String getAll(){
        String endpoint = 'https://dog.ceo/api/breeds/list/all';
        Boolean flag = true;
        return requestHelper.request(endPoint, flag);
    }

    @auraEnabled(cacheable=true)
    public static String getSubBreeds(String breed){
        String endpoint = 'https://dog.ceo/api/breed/'+breed+'/list';
        Boolean flag = false;
        return requestHelper.request(endPoint, flag);
    }

    @auraEnabled(cacheable=true)
    public static String getDogImagesByBreed(String breed){
        String endpoint = 'https://dog.ceo/api/breed/'+breed+'/images';
        Boolean flag = false;
        return requestHelper.request(endPoint, flag);
    }

    @auraEnabled(cacheable=true)
    public static String getDogImages(String breed, String subBreed){
        String endpoint = 'https://dog.ceo/api/breed/'+breed+'/'+subBreed+'/images';
        Boolean flag = false;
        return requestHelper.request(endPoint, flag);
    }
}