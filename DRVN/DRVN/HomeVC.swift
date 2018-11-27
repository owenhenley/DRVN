//
//  HomeVC.swift
//  DRVN
//
//  Created by Owen Henley on 11/25/18.
//  Copyright © 2018 Owen Henley. All rights reserved.
//

import UIKit
import MapKit
import RevealingSplashView

class HomeVC: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var requestRideButton: RoundedShadowButton!
    
    var slideOutMenuDelegate: CenterVCDelegate?
    let revelingSplashView = RevealingSplashView(iconImage: UIImage(named:"launchScreenIcon")!, iconInitialSize: CGSize(width: 100, height: 100), backgroundColor: .white)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        self.view.addSubview(revelingSplashView)
        revelingSplashView.animationType = .heartBeat
        revelingSplashView.startAnimation()
        revelingSplashView.heartAttack = true
    }
    
    @IBAction func menuTapped(_ sender: Any) {
        slideOutMenuDelegate?.toggleLeftPanel()
    }
    @IBAction func requestRideTapped(_ sender: Any) {
        requestRideButton.animateButton(shouldLoad: true, with: nil)
    }
}

extension HomeVC: MKMapViewDelegate {
    
}
