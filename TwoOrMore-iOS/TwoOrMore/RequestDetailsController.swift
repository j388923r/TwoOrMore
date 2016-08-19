//
//  RequestDetailsController.swift
//  TwoOrMore
//
//  Created by Jamar Brooks on 8/14/16.
//  Copyright © 2016 TwoOrMore. All rights reserved.
//

import UIKit

class RequestDetailsController: UIViewController {

    var prayerRequest : PrayerRequest!
    
    @IBOutlet weak var subjectView: UITextView!
    
    @IBOutlet weak var requestView: UITextView!
    
    override func viewDidLoad() {
        subjectView.text = prayerRequest.subject
        requestView.text = prayerRequest.request
    }
    
    override func viewDidAppear(animated: Bool) {
        
    }
}
