//
//  RoundedImageView.swift
//  DRVN
//
//  Created by Owen Henley on 11/25/18.
//  Copyright © 2018 Owen Henley. All rights reserved.
//

import UIKit

class RoundedImageView: UIImageView {

    override func awakeFromNib() {
        setupImageView()
    }
    
    func setupImageView() {
        self.layer.cornerRadius = self.frame.width / 2
        self.clipsToBounds = true
    }
}
