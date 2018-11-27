//
//  UIView+Ext.swift
//  DRVN
//
//  Created by Owen Henley on 11/27/18.
//  Copyright © 2018 Owen Henley. All rights reserved.
//

import UIKit

extension UIView {
    func fadeTo(alphaValue value: CGFloat, withDuration duration: TimeInterval) {
        UIView.animate(withDuration: duration) {
            self.alpha = value
        }
    }
}
