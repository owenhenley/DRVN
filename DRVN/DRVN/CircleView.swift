//
//  CircleView.swift
//  DRVN
//
//  Created by Owen Henley on 11/25/18.
//  Copyright © 2018 Owen Henley. All rights reserved.
//

import UIKit

class CircleView: UIView {
    
    @IBInspectable var borderColor: UIColor? {
        didSet {
            setupViews()
        }
    }
    
    override func awakeFromNib() {
        setupViews()
    }

    func setupViews() {
        self.layer.cornerRadius = self.frame.width / 2
        self.layer.borderWidth = 1
        self.layer.borderColor = borderColor?.cgColor
    }

}
