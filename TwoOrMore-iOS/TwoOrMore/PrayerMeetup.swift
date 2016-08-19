//
//  PrayerMeeting.swift
//  TwoOrMore
//
//  Created by Jamar Brooks on 6/18/16.
//  Copyright © 2016 TwoOrMore. All rights reserved.
//

import Foundation
import MapKit

class PrayerMeetup : NSObject, NSCoding, MKAnnotation {
    var title : String!
    var details : String!
    //Used for display, not storage
    var subtitle : String?
    var location : String!
    var color : MKPinAnnotationColor!
    var coordinate : CLLocationCoordinate2D
    var coordinateArray : [Double]!
    var time : NSDate!
    var userId : String!
    var access : String!
    
    init(title: String, location: String, coordinate: CLLocationCoordinate2D, time: NSDate) {
        self.title = title
        self.coordinate = coordinate
        self.coordinateArray = [coordinate.latitude, coordinate.longitude]
        self.location = location
        self.subtitle = location
        self.time = time
        self.details = ""
        color = MKPinAnnotationColor.Red
        
        super.init()
    }
    
    init(title: String, location: String, latitude: Double, longitude: Double, time: NSDate) {
        self.title = title
        self.coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        self.coordinateArray = [latitude, longitude]
        self.location = location
        self.subtitle = location
        self.time = time
        self.details = ""
        color = MKPinAnnotationColor.Red
        
        super.init()
    }
    
    func pinColor() -> MKPinAnnotationColor  {
        return .Green
    }
    
    func toDict() -> [String : String] {
        return ["title" : title, "details" : details, "location": location, "time" : "\(time.timeIntervalSince1970)", "latitude": "\(coordinateArray[0])", "longitude": "\(coordinateArray[1])", "access": access]
    }
    
    func toDict(locationPrefix : String) -> [String : String] {
        return ["title" : title, "details" : details, "location": locationPrefix + location, "time" : "\(time.timeIntervalSince1970)", "latitude": "\(coordinateArray[0])", "longitude": "\(coordinateArray[1])", "access": access]
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(title, forKey: "title")
        aCoder.encodeObject(coordinateArray, forKey: "coordinate")
        aCoder.encodeObject(location, forKey: "location")
        aCoder.encodeObject(time, forKey: "time")
    }
    
    required convenience init?(coder aDecoder : NSCoder) {
        let title = aDecoder.decodeObjectForKey("title") as! String
        let coordinateArray = aDecoder.decodeObjectForKey("coordinate") as! [Double]
        let location = aDecoder.decodeObjectForKey("location") as! String
        let time = aDecoder.decodeObjectForKey("time") as! NSDate
        
        self.init(title: title, location: location, coordinate: CLLocationCoordinate2D(latitude: coordinateArray[0], longitude: coordinateArray[1]), time: time)
    }
}