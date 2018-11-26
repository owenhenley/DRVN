//
//  UIViewShadow.swift
//  DRVN
//
//  Created by Owen Henley on 11/25/18.
//  Copyright © 2018 Owen Henley. All rights reserved.
//

import UIKit

class UIViewShadow: UIView {
    
    override func awakeFromNib() {
        setupView()
    }

    func setupView() {
        self.clipsToBounds = false
        self.layer.shadowOpacity = 0.4
        self.layer.shadowColor = UIColor.darkGray.cgColor
        self.layer.shadowRadius = 5
        self.layer.shadowOffset = CGSize(width: 0, height: 2)
    }

}
