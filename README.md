# JSONParser Swift 3

Create JSONParser.swift file. Then create for example **parseCampus(JSONData: [NSDictionary])** method.

```ruby
class JSONParser : NSObject {
    
    private static var _mInstance : JSONParser? = nil
    
    public static func getInstance() -> JSONParser{
        if (_mInstance == nil){
            _mInstance = JSONParser()
        }
        return _mInstance!
    }
    
    func parseCampus(JSONData: [NSDictionary])  -> [Campus] {
        
        var campusArr : [Campus] = []
        
        for item in JSONData  {
            
            var lat : Double = 0.0
            var lng : Double = 0.0
            let id = item[JSON_KEYS.CAMPUSES.JSON_KEY_ID] as? String
            let instituteId = item[JSON_KEYS.CAMPUSES.JSON_KEY_INSTITUEID] as? String
            if let location = item[JSON_KEYS.CAMPUSES.JSON_KEY_LOCATION] as? [String : AnyObject]{
                
                lat = location[JSON_KEYS.CAMPUSES.JSON_KEY_LAT] as! Double
                lng = location[JSON_KEYS.CAMPUSES.JSON_KEY_LNG] as! Double
            }
            
            let map = item[JSON_KEYS.CAMPUSES.JSON_KEY_MAP] as? String
            let name = item[JSON_KEYS.CAMPUSES.JSON_KEY_NAME] as? String
            let website = item[JSON_KEYS.CAMPUSES.JSON_KEY_WEBSITE] as? String
            let description = item[JSON_KEYS.CAMPUSES.JSON_KEY_DESCRIPTION] as? String
            let tour360 = item[JSON_KEYS.CAMPUSES.JSON_KEY_TOUR_360] as? String
            let image = item[JSON_KEYS.CAMPUSES.JSON_KEY_IMAGE] as? String
            let location = Location(lat: lat, lng: lng)
            let description_image = item[JSON_KEYS.CAMPUSES.JSON_KEY_DESCRIPTION_IMAGE] as? String
            let campus = Campus(id: id, instituteId: instituteId, location: location, mapImage: map, name: name, website: website, tour360 : tour360, description: description, image : image, description_image: description_image)
            campusArr.append(campus)
        }
        
        return campusArr
    }
}
```


This is an example how to parse data from a Alamofire response.

This line parse the response.
```ruby
JSONParser.getInstance().parseCampus(JSONData: JSON as! [NSDictionary])
```

Example of HTTP request.
```ruby
func fetchCampusesHTTP(){
                
        let parameters = ["where": ["instituteId" : GlobalState.getInstance().instituteId]] as [String : AnyObject]
        
        Alamofire.request(NetworkUtilities.generateUrl(url: Endpoint.URL, params: parameters), method : HTTPMethod.get, parameters: nil, encoding: URLEncoding.default , headers : nil).validate().responseJSON { response in
                        
            switch response.result {
                
            case .success:
                
                if let JSON = response.result.value as? NSArray{
                    self.campusArr = JSONParser.getInstance().parseCampus(JSONData: JSON as! [NSDictionary])
                }

            case .failure( _):
                
                if let error = response.error {
                    print(error)
                }
            }
        }
 }
```
