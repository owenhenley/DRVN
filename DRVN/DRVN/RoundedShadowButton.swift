//
//  RoundedShadowButton.swift
//  DRVN
//
//  Created by Owen Henley on 11/25/18.
//  Copyright © 2018 Owen Henley. All rights reserved.
//

import UIKit

class RoundedShadowButton: UIButton {
    
    var originalSize: CGRect?
    
    override func awakeFromNib() {
        setupViews()
    }

    func setupViews() {
        originalSize = self.frame
        self.layer.cornerRadius = 5
        self.layer.shadowRadius = 5
        self.layer.shadowColor = UIColor.lightGray.cgColor
        self.layer.shadowOpacity = 0.2
        self.layer.shadowOffset = CGSize(width: 0, height: 2)
    }
    
    func animateButton(shouldLoad: Bool, with message: String?) {
        // Set up Activity Monitor
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.style = .whiteLarge
        activityIndicator.color = .darkGray
        activityIndicator.alpha = 0.0
        activityIndicator.hidesWhenStopped = true
        activityIndicator.tag = 15
        
        if shouldLoad {
            self.addSubview(activityIndicator)
            self.setTitle("", for: .normal)
            UIView.animate(withDuration: 0.2, animations: {
                self.layer.cornerRadius = self.frame.height / 2
                // Make a circle
                self.frame = CGRect(
                    // set the far left point to center
                    x: self.frame.midX - (self.frame.height / 2),
                    y: self.frame.origin.y,
                    // set the hight as the width to create square
                    width: self.frame.height,
                    height: self.frame.height)
                
            }) { (finished) in
                if finished == true {
                    activityIndicator.startAnimating()
                    // Show activity indicator
                    activityIndicator.center = CGPoint(x: self.frame.width / 2 + 1, y: self.frame.height / 2 + 1)
                    UIView.animate(withDuration: 0.2, animations: {
                        activityIndicator.alpha = 1
                    })
                    self.isUserInteractionEnabled = false
                }
            }
        } else {
            self.isUserInteractionEnabled = true
            
            for subview in self.subviews {
                if subview.tag == 15 {
                    subview.removeFromSuperview()
                }
            }
            UIView.animate(withDuration: 0.2, animations: {
                self.layer.cornerRadius = 5
                self.frame = self.originalSize!
                self.setTitle(message, for: .normal)
            })
        }
    }
}
