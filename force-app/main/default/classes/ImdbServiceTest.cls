@IsTest
private class ImdbServiceTest {
    @IsTest static void testSearchByName() {
        // Register mock so real HTTP is not called during tests
        Test.setMock(HttpCalloutMock.class, new ImdbServiceMock());
        Test.startTest();
        List<Map<String,Object>> results = ImdbService.searchByName('inception');
        Test.stopTest();

        System.assertNotEquals(null, results, 'Results should not be null');
        System.assertEquals(2, results.size(), 'Mock returns 2 results');
        System.assertEquals('Inception', (String) results[0].get('title'));
    }
}