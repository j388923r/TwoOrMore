//
//  JoinPrayerController.swift
//  TwoOrMore
//
//  Created by Jamar Brooks on 6/17/16.
//  Copyright © 2016 TwoOrMore. All rights reserved.
//

import UIKit
import MapKit

class JoinPrayerController: UIViewController, UISearchControllerDelegate, UISearchResultsUpdating, UISearchBarDelegate {

    @IBOutlet weak var topSegment: UISegmentedControl!
    
    @IBOutlet weak var listView: UIView!
    @IBOutlet weak var mapView: UIView!
    
    var searchController : UISearchController!
    
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
        
        var queryUrl : String = "http://whereis.mit.edu/search?type=query&q=building%205&output=json"
        
        let building5Loc = CLLocationCoordinate2D(latitude: 42.35871452, longitude: -71.09292322)
        
        let annotation = PrayerMeetup(title: "Prayer for peace", location: "5-119", coordinate: building5Loc)
        annotation.details = "We need peace on this campus."
        
        if let listController = self.childViewControllers[0] as? ListController {
            listController.prayerMeetups.append(annotation)
        }
        
        if let mapController = self.childViewControllers[1] as? MapController {
            mapController.prayerMeetings.append(annotation)
        }
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
