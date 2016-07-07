//
//  WelcomeController.swift
//  TwoOrMore
//
//  Created by Jamar Brooks on 6/12/16.
//  Copyright © 2016 TwoOrMore. All rights reserved.
//

import UIKit

class WelcomeController: UIViewController {

    @IBOutlet weak var welcomeText: UITextView!
    
    static let DocumentsDirectory = NSFileManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.URLByAppendingPathComponent("UUID")
    
    override func viewDidLoad() {
        if let uuid = NSKeyedUnarchiver.unarchiveObjectWithFile(WelcomeController.ArchiveURL.path!) as? String {
            welcomeText.text = PrayerScriptureDb.prayerVerses[Int(arc4random_uniform(UInt32(PrayerScriptureDb.prayerVerses.count)))]
        } else {
            let uuid = NSUUID().UUIDString
        }
    }
    
    
    func returnHome(segue: UIStoryboardSegue) {
        
    }
}
