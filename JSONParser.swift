//
//  JSONParser.swift
//
//  Created by Cristian Cardoso on 5/3/17.
//  Copyright © 2017 Cristian Cardoso. All rights reserved.
//

import Foundation


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
