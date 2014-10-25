//
//  MarkerDetailView.swift
//  JLY
//
//  Created by Rui Zheng on 2014-10-19.
//  Copyright (c) 2014 Rui Zheng. All rights reserved.
//

import Foundation

class MarkerDetailViewController: UIViewController {
    
    var marker:GMSMarker!
    
    @IBOutlet weak var markerInfoLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        markerInfoLabel.text=marker!.description
        
        
    }
}