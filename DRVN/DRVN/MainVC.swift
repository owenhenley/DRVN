//
//  MainVC.swift
//  DRVN
//
//  Created by Owen Henley on 11/25/18.
//  Copyright © 2018 Owen Henley. All rights reserved.
//

import UIKit
import MapKit

class MainVC: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var requestRideButton: RoundedShadowButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
    }
    @IBAction func requestRideTapped(_ sender: Any) {
        requestRideButton.animateButton(shouldLoad: true, with: nil)
    }
}

extension MainVC: MKMapViewDelegate {
    
}
