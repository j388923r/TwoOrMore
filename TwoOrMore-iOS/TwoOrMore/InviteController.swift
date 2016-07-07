//
//  InviteController.swift
//  TwoOrMore
//
//  Created by Jamar Brooks on 6/18/16.
//  Copyright © 2016 TwoOrMore. All rights reserved.
//

import UIKit

class InviteController: UIViewController {

    var inviteTitle : String!
    var inviteDescription : String!
    var inviteTime : NSTimeInterval!
    var inviteLocation : String!
    
    // MARK: Outlets
    
    @IBOutlet weak var titleInput: UITextField!
    
    @IBOutlet weak var descriptionInput: UITextView!
    
    @IBOutlet weak var timeInput: UITextField!
    
    @IBOutlet weak var locationInput: UITextField!
    
    override func viewDidLoad() {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .DateAndTime
        datePicker.addTarget(self, action: "dateChosen:", forControlEvents: .ValueChanged)
        datePicker.minimumDate = NSDate()
        timeInput.inputView = datePicker
    }
    
    func dateChosen(picker : UIDatePicker) {
        let formatter = NSDateFormatter()
        formatter.dateFormat = "MMM dd, yyyy hh:mm:ss a"
        timeInput.text = formatter.stringFromDate(picker.date)
    }
    
    @IBAction func submitToFriends(sender: UIButton) {
        
    }
    
    @IBAction func submitPublicly(sender: UIButton) {
        
    }
}
