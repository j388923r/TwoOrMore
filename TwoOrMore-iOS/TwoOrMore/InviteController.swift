//
//  InviteController.swift
//  TwoOrMore
//
//  Created by Jamar Brooks on 6/18/16.
//  Copyright © 2016 TwoOrMore. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import Alamofire

class InviteController: UIViewController {

    var ref : FIRDatabaseReference!
    var inviteTitle : String!
    var inviteDescription : String!
    var inviteTime : NSTimeInterval!
    var inviteLocation : String!
    var user : FIRUser!
    
    // MARK: Outlets
    
    @IBOutlet weak var titleInput: UITextField!
    
    @IBOutlet weak var descriptionInput: UITextView!
    
    @IBOutlet weak var timeInput: UITextField!
    
    @IBOutlet weak var locationInput: UITextField!
    
    override func viewDidLoad() {
        self.ref = FIRDatabase.database().reference()
        self.inviteTime = NSDate().timeIntervalSince1970
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .DateAndTime
        datePicker.addTarget(self, action: #selector(InviteController.dateChosen(_:)), forControlEvents: .ValueChanged)
        datePicker.minimumDate = NSDate()
        timeInput.inputView = datePicker
        
        let formatter = NSDateFormatter()
        formatter.dateFormat = "MMM dd, yyyy hh:mm:ss a"
        timeInput.text = formatter.stringFromDate(datePicker.minimumDate!)
    }
    
    func dateChosen(picker : UIDatePicker) {
        let formatter = NSDateFormatter()
        formatter.dateFormat = "MMM dd, yyyy hh:mm:ss a"
        inviteTime = picker.date.timeIntervalSince1970
        timeInput.text = formatter.stringFromDate(picker.date)
    }
    
    @IBAction func submitToFriends(sender: UIButton) {
        
        inviteLocation = locationInput.text!
        
        var queryUrl : String!
        if let mRange = inviteLocation.rangeOfString("building [nsew]{0,2}[0-9]+", options: .RegularExpressionSearch) {
            queryUrl = "http://whereis.mit.edu/search?type=query&q=\(inviteLocation.substringWithRange(mRange))&output=json"
        } else {
            queryUrl = "http://whereis.mit.edu/search?type=query&q=building%20\(locationInput.text!)&output=json"
        }
        
        Alamofire.request(.GET, queryUrl).responseJSON {
            response in
            print(response)
            
            if let val = response.result.value {
                let dataList = val as! NSArray
                let data = dataList[0] as! NSDictionary
                let lat = data["lat_wgs84"] as! Double
                let long = data["long_wgs84"] as! Double
                let meetup = PrayerMeetup(title: self.titleInput.text!, location: self.locationInput.text!, latitude: lat, longitude: long, time: NSDate(timeIntervalSince1970: self.inviteTime))
                meetup.access = "friends"
                let key = self.ref.child("meetups").childByAutoId().key
                let childUpdates = ["/meetups/\(key)": meetup.toDict("Building ")]
                self.ref.updateChildValues(childUpdates)
                self.performSegueWithIdentifier("displayRequestSegue", sender: self)
            }
        }
    }
    
    @IBAction func submitPublicly(sender: UIButton) {
        
        inviteLocation = locationInput.text!
        
        var queryUrl : String!
        if let mRange = inviteLocation.rangeOfString("building [nsew]{0,2}[0-9]+", options: .RegularExpressionSearch) {
            queryUrl = "http://whereis.mit.edu/search?type=query&q=\(inviteLocation.substringWithRange(mRange))&output=json"
        } else {
            queryUrl = "http://whereis.mit.edu/search?type=query&q=building%20\(locationInput.text!)&output=json"
        }
        
        Alamofire.request(.GET, queryUrl).responseJSON {
            response in
            print(response)
            
            if let val = response.result.value {
                let dataList = val as! NSArray
                let data = dataList[0] as! NSDictionary
                let lat = data["lat_wgs84"] as! Double
                let long = data["long_wgs84"] as! Double
                let meetup = PrayerMeetup(title: self.titleInput.text!, location: self.locationInput.text!, latitude: lat, longitude: long, time: NSDate(timeIntervalSince1970: self.inviteTime))
                meetup.access = "public"
                let key = self.ref.child("meetups").childByAutoId().key
                let childUpdates = ["/meetups/\(key)": meetup.toDict("Building ")]
                self.ref.updateChildValues(childUpdates)
                self.performSegueWithIdentifier("displayRequestSegue", sender: self)
            }
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // 
    }
}
