//
//  RoundedShadowView.swift
//  DRVN
//
//  Created by Owen Henley on 11/25/18.
//  Copyright © 2018 Owen Henley. All rights reserved.
//

import UIKit

class RoundedShadowView: UIView {

    override func awakeFromNib() {
        setupView()
    }
    
    func setupView() {
        self.layer.shadowOpacity = 0.2
        self.layer.shadowColor = UIColor.lightGray.cgColor
        self.layer.shadowRadius = 5
        self.layer.shadowOffset = CGSize(width: 0, height: 2)
        self.layer.cornerRadius = 5
    }
}
