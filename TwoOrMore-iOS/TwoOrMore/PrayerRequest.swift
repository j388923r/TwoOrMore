//
//  PrayerRequest.swift
//  TwoOrMore
//
//  Created by Jamar Brooks on 7/22/16.
//  Copyright © 2016 TwoOrMore. All rights reserved.
//

import Foundation

class PrayerRequest {
    
    var access : String!
    var anonymous : Bool = false
    var answered : Bool = false
    var subject : String!
    var request : String!
    var userId : String!
    var timestamp : NSDate!
    
    init(userId: String, subject: String, request: String) {
        self.userId = userId
        self.subject = subject
        self.request = request
    }
    
    func toDict() -> [String : String] {
        return ["userId": userId, "subject": subject, "request": request, "timestamp" : String(Int(timestamp.timeIntervalSince1970)), "access" : access, "anonymous": String(anonymous), "answered": String(answered)]
    }
}