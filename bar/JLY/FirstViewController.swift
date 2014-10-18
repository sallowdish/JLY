//
//  FirstViewController.swift
//  JLY
//
//  Created by Rui Zheng on 2014-10-17.
//  Copyright (c) 2014 Rui Zheng. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController, GMSMapViewDelegate {
    
    var gmaps: GMSMapView?
    
//    required init(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        var target: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 51.6, longitude: 17.2)
        var camera: GMSCameraPosition = GMSCameraPosition(target: target, zoom: 6, bearing: 0, viewingAngle: 0)

        var container:CGRect?=CGRectMake(0, 0, self.view.bounds.width, self.view.bounds.height-super.tabBarController!.tabBar.bounds.height)
        
        
        gmaps = GMSMapView.mapWithFrame(container!, camera: camera)
        
        if let map = gmaps? {
            map.myLocationEnabled = true
            map.camera = camera
            map.delegate = self
            
            self.view.addSubview(map)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

