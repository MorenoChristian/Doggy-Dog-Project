public with sharing class getFavoriteController {
    @AuraEnabled(cacheable=true)
    public static List<Favorite_Dog__c> getFav(){
        return [SELECT Id, imageUrl__c, Breed__c, Sub_Breed__c FROM Favorite_Dog__c LIMIT 100];
    }
}