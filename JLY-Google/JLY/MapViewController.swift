//
//  FirstViewController.swift
//  JLY
//
//  Created by Rui Zheng on 2014-10-17.
//  Copyright (c) 2014 Rui Zheng. All rights reserved.
//

import UIKit
import CoreLocation


let NavigationBarHeight=44, StatusBarHeight=20, SearchBarHeight=44

class MapViewController: UIViewController, GMSMapViewDelegate, CLLocationManagerDelegate {
    
    var gmaps: GMSMapView?
    let locationManager = CLLocationManager()
    
    @IBOutlet weak var mapViewContainer: UIView!

    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        mapViewContainer.hidden=true
            }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        //Move camera to predefined location
        var target: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 51.6, longitude: 17.2)
        var camera: GMSCameraPosition = GMSCameraPosition(target: target, zoom: 6, bearing: 0, viewingAngle: 0)
        
        var container:CGRect?=CGRectMake(0, CGFloat(NavigationBarHeight+SearchBarHeight), self.view.bounds.width, self.view.bounds.height-super.tabBarController!.tabBar.bounds.height-CGFloat(NavigationBarHeight+SearchBarHeight))
        
        container=self.mapViewContainer.bounds
        
        gmaps = GMSMapView.mapWithFrame(container!, camera: camera)
        
        if let map = gmaps? {
            map.myLocationEnabled = true
            map.camera = camera
            map.delegate = self
            
            self.mapViewContainer.addSubview(map)
            self.mapViewContainer.hidden=false
        }
        
        //get the current location and display
        locationManager.delegate = self
        
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        locationManager.requestAlwaysAuthorization()

        locationManager.startUpdatingLocation()
    }
    
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        println("Succeed: ")
        var current_location: CLLocation?=locations[0] as? CLLocation
        if let current_cordinate = (current_location!.coordinate) as CLLocationCoordinate2D?{
            self.updateGoogleMapView(current_cordinate)
        }

        locationManager.stopUpdatingLocation()
        
        
    }
    
    func updateGoogleMapView(target: CLLocationCoordinate2D!)->Bool{
        if let camera: GMSCameraPosition = GMSCameraPosition(target: target, zoom: 13, bearing: 0, viewingAngle: 0) as GMSCameraPosition?{
            self.gmaps?.clear()
            self.gmaps?.moveCamera(GMSCameraUpdate.setCamera(camera))
            if let marker = GMSMarker() as GMSMarker?{
                marker.position=target
                
                marker.appearAnimation=kGMSMarkerAnimationPop
                marker.map=self.gmaps
            }
            
            return true
        }else{
            return false
        }
        
        
    }
    
    func mapView(mapView: GMSMapView!, didTapMarker marker: GMSMarker!) -> Bool {
        self.performSegueWithIdentifier("ToMarkerDetailSegue", sender: marker)
        return true
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier=="ToMarkerDetailSegue"{
            var dest=segue.destinationViewController as MarkerDetailViewController
            dest.marker=sender as GMSMarker
        }
    }
    
    func locationManager(manager: CLLocationManager!, didFailWithError error: NSError!) {
        
        println("Error while updating location " + error.localizedDescription)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

