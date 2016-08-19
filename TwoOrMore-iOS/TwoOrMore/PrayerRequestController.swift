//
//  PrayerRequestController.swift
//  TwoOrMore
//
//  Created by Jamar Brooks on 6/12/16.
//  Copyright © 2016 TwoOrMore. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class PrayerRequestController: UIViewController {
    
    var ref : FIRDatabaseReference!
    var uuid : String!
    var userId : String!

    @IBOutlet weak var subjectField: UITextField!
    @IBOutlet weak var requestField: UITextView!
    
    override func viewDidLoad() {
        self.ref = FIRDatabase.database().reference()
        uuid = NSKeyedUnarchiver.unarchiveObjectWithFile(WelcomeController.ArchiveURL.path!) as! String
        ref.child("posts").observeSingleEventOfType(.Value, withBlock: { (snapshot) in
            // Get user value
            print(snapshot.value)
        })
    }
    
    
    @IBAction func submitToFriends(sender: AnyObject) {
        let request = PrayerRequest(userId: uuid, subject: subjectField.text!, request: requestField.text!)
        request.timestamp = NSDate()
        request.access = "friends"
        let key = self.ref.child("requests").childByAutoId().key
        let childUpdates = ["/requests/\(key)": request.toDict()]
        ref.updateChildValues(childUpdates)
        self.dismissViewControllerAnimated(true) { () -> Void in
            
        }
    }
    
    @IBAction func submitPublicly(sender: UIButton) {
        let request = PrayerRequest(userId: uuid, subject: subjectField.text!, request: requestField.text!)
        request.timestamp = NSDate()
        request.access = "public"
        let key = self.ref.child("requests").childByAutoId().key
        let childUpdates = ["/requests/\(key)": request.toDict()]
        ref.updateChildValues(childUpdates)
        self.dismissViewControllerAnimated(true) { () -> Void in
            
        }
    }
}
