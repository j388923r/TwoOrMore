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
    var title : String?
    var details : String?
    var subtitle : String?
    var location : String!
    var color : MKPinAnnotationColor!
    var coordinate : CLLocationCoordinate2D
    var coordinateArray : [Double]!
    var time : NSDate?
    
    init(title: String, location: String, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.coordinate = coordinate
        self.coordinateArray = [coordinate.latitude, coordinate.longitude]
        self.location = location
        self.subtitle = location
        self.time = NSDate()
        
        color = MKPinAnnotationColor.Red
        
        super.init()
    }
    
    func pinColor() -> MKPinAnnotationColor  {
        return .Green
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(title, forKey: "title")
        aCoder.encodeObject(coordinateArray, forKey: "coordinate")
        aCoder.encodeObject(location, forKey: "location")
    }
    
    required convenience init?(coder aDecoder : NSCoder) {
        let title = aDecoder.decodeObjectForKey("title") as! String
        let coordinateArray = aDecoder.decodeObjectForKey("coordinate") as! [Double]
        let location = aDecoder.decodeObjectForKey("location") as! String
        
        self.init(title: title, location: location, coordinate: CLLocationCoordinate2D(latitude: coordinateArray[0], longitude: coordinateArray[1]))
    }
}