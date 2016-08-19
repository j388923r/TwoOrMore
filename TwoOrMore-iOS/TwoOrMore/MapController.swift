//
//  MapController.swift
//  TwoOrMore
//
//  Created by Jamar Brooks on 6/17/16.
//  Copyright © 2016 TwoOrMore. All rights reserved.
//

import UIKit
import MapKit
import FirebaseDatabase

class MapController: UIViewController, MKMapViewDelegate  {

    var ref : FIRDatabaseReference!
    @IBOutlet weak var mapView: MKMapView!
    var centerCoordinate : CLLocationCoordinate2D?
    var prayerMeetings = [PrayerMeetup]()
    var selectedMeetup : PrayerMeetup?
    
    override func viewDidLoad() {
        
        mapView.delegate = self
        
        if let _ = centerCoordinate {
            
        }
        else {
            centerCoordinate = CLLocationCoordinate2D(latitude: 42.35871452, longitude: -71.09292322)
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        mapView.centerCoordinate = centerCoordinate!
        
        var myRegion = mapView.region
        myRegion.span.latitudeDelta *= 0.0001
        myRegion.span.longitudeDelta *= 0.0001
        mapView.setRegion(myRegion, animated: true)
    }
    
    func mapViewDidFinishLoadingMap(mapView: MKMapView) {
        
    }
    
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        if let annotation = annotation as? PrayerMeetup {
            let identifier = "pin"
            var view: MKPinAnnotationView
            if let dequeuedView = mapView.dequeueReusableAnnotationViewWithIdentifier(identifier)
                as? MKPinAnnotationView { // 2
                    dequeuedView.annotation = annotation
                    view = dequeuedView
            } else {
                // 3
                view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                view.canShowCallout = true
                view.calloutOffset = CGPoint(x: -5, y: 5)
                view.rightCalloutAccessoryView = UIButton(type: .DetailDisclosure) as UIView
            }
            return view
        }
        return nil
    }
    
    func mapView(mapView: MKMapView, annotationView view: MKAnnotationView,
        calloutAccessoryControlTapped control: UIControl) {
        selectedMeetup = view.annotation as? PrayerMeetup
        self.performSegueWithIdentifier("toDetailSegue", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let destination = segue.destinationViewController as? MeetupDetailsController {
            destination.prayerMeetup = selectedMeetup
        }
    }
}
