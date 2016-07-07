//
//  ListController.swift
//  TwoOrMore
//
//  Created by Jamar Brooks on 6/18/16.
//  Copyright © 2016 TwoOrMore. All rights reserved.
//

import UIKit

class ListController: UITableViewController {
    
    var prayerMeetups = [PrayerMeetup]()
    
    override func viewDidLoad() {
        
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return prayerMeetups.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "prayerMeetupCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! UITableViewCell
        
        cell.textLabel?.text = prayerMeetups[indexPath.row].title
        cell.detailTextLabel?.text = prayerMeetups[indexPath.row].subtitle
        
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let destination = segue.destinationViewController as? MeetupDetailsController {
            destination.prayerMeetup = prayerMeetups[(tableView.indexPathForSelectedRow?.row)!]
        }
    }
}
