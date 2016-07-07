//
//  MeetupDetailsController.swift
//  TwoOrMore
//
//  Created by Jamar Brooks on 6/23/16.
//  Copyright © 2016 TwoOrMore. All rights reserved.
//

import UIKit

class MeetupDetailsController: UIViewController {
    
    var prayerMeetup : PrayerMeetup!

    @IBOutlet weak var titleDisplay: UILabel!
    
    @IBOutlet weak var descriptionDisplay: UITextView!
    
    @IBOutlet weak var timeDisplay: UILabel!
    
    @IBOutlet weak var LocationDisplay: UILabel!
    
    override func viewDidLoad() {
        titleDisplay.text = prayerMeetup.title
        descriptionDisplay.text = prayerMeetup.details
        
        let formatter = NSDateFormatter()
        formatter.dateStyle = .ShortStyle
        formatter.timeStyle = .ShortStyle
        
        timeDisplay.text = formatter.stringFromDate(prayerMeetup.time!)
        LocationDisplay.text = prayerMeetup.location
        
        self.navigationItem.title = "Details"
    }
}
