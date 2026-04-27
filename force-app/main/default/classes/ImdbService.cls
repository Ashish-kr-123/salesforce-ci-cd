public with sharing class ImdbService {
    @AuraEnabled(cacheable=false)
    public static List<Map<String, Object>> searchByName(String query) {
        if (String.isBlank(query)) {
            return new List<Map<String, Object>>();
        }
        // URL uses Named Credential named "CollectAPI_NC"
        String endpoint = 'callout:CollectAPI_NC/imdb/imdbSearchByName?query='
            + EncodingUtil.urlEncode(query, 'UTF-8');

        Http http = new Http();
        HttpRequest req = new HttpRequest();
        req.setEndpoint(endpoint);
        req.setMethod('GET');
        req.setHeader('Accept', 'application/json');

        HttpResponse res;
        try {
            res = http.send(req);
        } catch (System.CalloutException ex) {
            // Return friendly error wrapped as AuraHandledException so LWC shows message
            throw new AuraHandledException('Callout failed: ' + ex.getMessage());
        }

        Integer status = res.getStatusCode();
        if (status >= 200 && status < 300) {
            // Parse response body (CollectAPI typically returns {"result": [...]})
            Object parsed = JSON.deserializeUntyped(res.getBody());
            if (parsed instanceof Map<String, Object>) {
                Map<String, Object> payload = (Map<String, Object>) parsed;
                if (payload.containsKey('result')) {
                    List<Object> raw = (List<Object>) payload.get('result');
                    List<Map<String, Object>> out = new List<Map<String, Object>>();
                    for (Object o : raw) {
                        out.add((Map<String,Object>) o);
                    }
                    return out;
                } else {
                    // If unexpected structure but parsed as map, try to flatten
                    List<Map<String, Object>> out = new List<Map<String, Object>>();
                    for (String k : payload.keySet()) {
                        out.add(new Map<String,Object>{ 'key' => k, 'value' => payload.get(k) });
                    }
                    return out;
                }
            } else if (parsed instanceof List<Object>) {
                List<Map<String,Object>> out = new List<Map<String,Object>>();
                for (Object o : (List<Object>) parsed) out.add((Map<String,Object>) o);
                return out;
            } else {
                return new List<Map<String,Object>>();
            }
        } else {
            // Surface body for troubleshooting
            String body = res.getBody();
            throw new AuraHandledException('External API error: ' + status + ' - ' + body);
        }
    }
}