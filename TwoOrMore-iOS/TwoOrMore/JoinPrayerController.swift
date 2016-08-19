//
//  JoinPrayerController.swift
//  TwoOrMore
//
//  Created by Jamar Brooks on 6/17/16.
//  Copyright © 2016 TwoOrMore. All rights reserved.
//

import UIKit
import MapKit
import FirebaseAuth
import FirebaseDatabase

class JoinPrayerController: UIViewController, UISearchControllerDelegate, UISearchResultsUpdating, UISearchBarDelegate {

    @IBOutlet weak var topSegment: UISegmentedControl!
    
    @IBOutlet weak var listView: UIView!
    @IBOutlet weak var mapView: UIView!
    
    var searchController : UISearchController!
    
    var ref : FIRDatabaseReference!
    
    var prayerMeetings = [PrayerMeetup]()
    
    override func viewDidLoad() {
        self.searchController = UISearchController(searchResultsController:  nil)
        
        self.searchController.searchResultsUpdater = self
        self.searchController.delegate = self
        self.searchController.searchBar.delegate = self
        
        self.searchController.hidesNavigationBarDuringPresentation = false
        self.searchController.dimsBackgroundDuringPresentation = false
        
        self.navigationItem.backBarButtonItem = nil
        
        self.navigationItem.titleView = searchController.searchBar
        self.navigationItem.title = "Join Prayer"
        
        self.ref = FIRDatabase.database().reference()
        ref.child("meetups").observeSingleEventOfType(.Value, withBlock: { (snapshot) in
            let storedMeetups = snapshot.value as! NSDictionary
            for (_, value) in storedMeetups {
                let storedTitle = value["title"] as! String
                let storedLocation = value["location"] as! String
                self.prayerMeetings.append(PrayerMeetup(title: storedTitle, location: storedLocation, latitude: Double(value["latitude"] as! String)!, longitude: Double(value["longitude"] as! String)!, time: NSDate(timeIntervalSince1970: Double(value["time"] as! String)!)))
                
            }
            
            if let listController = self.childViewControllers[0] as? ListController {
                if let mapController = self.childViewControllers[1] as? MapController {
                    for i in 0..<self.prayerMeetings.count {
                        mapController.mapView.addAnnotation(self.prayerMeetings[i])
                        
                        mapController.prayerMeetings = self.prayerMeetings
                        listController.prayerMeetings = self.prayerMeetings
                        
                        listController.tableView.reloadData()
                    }
                }
            }
        })
    }
    
    @IBAction func segmentChanged(sender: UISegmentedControl) {
        switch topSegment.selectedSegmentIndex {
        case 0:
            listView.hidden = true
            mapView.hidden = false
            break
        case 1:
            listView.hidden = false
            mapView.hidden = true
            break
        default:
            break
        }
    }
    
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        
    }
}
