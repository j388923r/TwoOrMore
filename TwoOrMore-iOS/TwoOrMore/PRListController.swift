//
//  PRListController.swift
//  TwoOrMore
//
//  Created by Jamar Brooks on 8/14/16.
//  Copyright © 2016 TwoOrMore. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class PRListController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var prayerRequests = [PrayerRequest]()
    
    var allPrayerRequests = [PrayerRequest]()
    
    var myPrayerRequests = [PrayerRequest]()
    
    var user : FIRUser?
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var segmentSwitch: UISegmentedControl!
    
    var ref : FIRDatabaseReference!
    
    override func viewDidLoad() {
        self.ref = FIRDatabase.database().reference()
        ref.child("posts").observeSingleEventOfType(.Value, withBlock: { (snapshot) in
            let storedMeetups = snapshot.value as! NSDictionary
            for (_, value) in storedMeetups {
                let storedRequest = value["request"] as! String
                let storedSubject = value["subject"] as! String
                let userId = value["userId"] as! String
                let request = PrayerRequest(userId: userId, subject: storedSubject, request: storedRequest)
                self.allPrayerRequests.append(request)
                if request.userId == "388923" {
                    self.myPrayerRequests.append(request)
                }
            }
            self.reloadRequests()
        })
        
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    @IBAction func segmentSwitched(sender: UISegmentedControl) {
        reloadRequests()
    }
    
    func reloadRequests() {
        if segmentSwitch.selectedSegmentIndex == 0 {
            self.prayerRequests = self.allPrayerRequests
        } else if segmentSwitch.selectedSegmentIndex == 1 {
            self.prayerRequests = self.myPrayerRequests
        }
        self.tableView.reloadData()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return prayerRequests.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "prayerRequestCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath)
        
        cell.textLabel?.text = prayerRequests[indexPath.row].subject
        cell.detailTextLabel?.text = prayerRequests[indexPath.row].request
        
        return cell
    }
    
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let destination = segue.destinationViewController as? RequestDetailsController {
            destination.prayerRequest = prayerRequests[(tableView.indexPathForSelectedRow?.row)!]
        }
    }
}
