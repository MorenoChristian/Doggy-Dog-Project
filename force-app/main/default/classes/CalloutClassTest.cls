@isTest(SeeAllData=true)
private class CalloutClassTest {
     @isTest static void getAllTest() {
        Response__mdt mdt =Response__mdt.getInstance('getAllBody');
        String body = mdt.body__c;
        MockHttpResponseGenerator mock = new MockHttpResponseGenerator(body);
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, mock);
        String res = getAllBreeds.getAll();
        Test.stopTest();
        System.assertEquals(res, body);
    }

    @isTest static void getSubBreedsTest() {
        String body = '{"message": ["kelpie","shepherd"],"status": "success"}';
        String breed = 'australian';
        MockHttpResponseGenerator mock = new MockHttpResponseGenerator(body);
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, mock);
        String res = getAllBreeds.getSubBreeds(breed);
        Test.stopTest();
        System.assertEquals(res, body);
    }

    @isTest static void getImagesByBreedTest() {
        Response__mdt mdt =Response__mdt.getInstance('dogImagesByBreed');
        String body = mdt.body__c;
        String breed = 'australian';
        MockHttpResponseGenerator mock = new MockHttpResponseGenerator(body);
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, mock);
        String res = getAllBreeds.getDogImagesByBreed(breed);
        Test.stopTest();
        System.assertEquals(res, body);
    }


    @isTest static void getImagesByBreedAndSubBreedTest() {
        Response__mdt mdt =Response__mdt.getInstance('dogImagesByBreedAndSubBreed');
        String body = mdt.body__c;
        String breed = 'australian';
        String subBreed = 'kelpie';
        MockHttpResponseGenerator mock = new MockHttpResponseGenerator(body);
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, mock);
        String res = getAllBreeds.getDogImages(breed, subBreed);
        Test.stopTest();
        System.assertEquals(res, body);
    }
}