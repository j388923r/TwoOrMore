//
//  ListController.swift
//  TwoOrMore
//
//  Created by Jamar Brooks on 6/18/16.
//  Copyright © 2016 TwoOrMore. All rights reserved.
//

import UIKit

class ListController: UITableViewController {
    
    var prayerMeetings = [PrayerMeetup]()
    
    override func viewDidLoad() {
        
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return prayerMeetings.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "prayerMeetupCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath)
        
        cell.textLabel?.text = prayerMeetings[indexPath.row].title
        cell.detailTextLabel?.text = prayerMeetings[indexPath.row].location
        
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let destination = segue.destinationViewController as? MeetupDetailsController {
            destination.prayerMeetup = prayerMeetings[(tableView.indexPathForSelectedRow?.row)!]
        }
    }
}
