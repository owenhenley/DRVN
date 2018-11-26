//
//  GradientView.swift
//  DRVN
//
//  Created by Owen Henley on 11/25/18.
//  Copyright © 2018 Owen Henley. All rights reserved.
//

import UIKit

class GradientView: UIView {
    
    let gradient = CAGradientLayer()
    
    override func awakeFromNib() {
        setupGradientView()
    }
    
    // Make sure view color is set to 'Default'
    
    func setupGradientView() {
        gradient.frame = self.bounds
        gradient.colors = [UIColor.white.cgColor, UIColor.init(white: 1.0, alpha: 0.0).cgColor]
        // Start at top left corner
        gradient.startPoint = CGPoint.zero
        // Gradient only knows the parameter of its own view. 0 -> 1
        gradient.endPoint = CGPoint(x: 0, y: 1)
        // $1 color goes all the way to 80%, $1 to the bottom
        gradient.locations = [0.8, 1.0]
        self.layer.addSublayer(gradient)
    }
    

}
