@IsTest
global class ImdbServiceMock implements HttpCalloutMock {
    global HTTPResponse respond(HTTPRequest req) {
        HttpResponse res = new HttpResponse();
        res.setHeader('Content-Type', 'application/json');
        res.setStatusCode(200);
        // Sample CollectAPI-like JSON
        String sample = '{ "result": [ ' +
            '{"title":"Inception","year":"2010","imdbid":"tt1375666","url":"https://www.imdb.com/title/tt1375666/"},' +
            '{"title":"The Matrix","year":"1999","imdbid":"tt0133093","url":"https://www.imdb.com/title/tt0133093/"}' +
        ']}';
        res.setBody(sample);
        return res;
    }
}