# JSONParser

This is an example how to parse data from a Alamofire response.

This line parse the response.
```ruby
JSONParser.getInstance().parseCampus(JSONData: JSON as! [NSDictionary])
```

Example of HTTP request.
```ruby
func fetchCampusesHTTP(){
                
        let parameters = ["where": ["instituteId" : GlobalState.getInstance().instituteId]] as [String : AnyObject]
        
        Alamofire.request(URL, params: parameters), method : HTTPMethod.get, parameters: nil, encoding: URLEncoding.default , headers : nil).validate().responseJSON { response in
                        
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
