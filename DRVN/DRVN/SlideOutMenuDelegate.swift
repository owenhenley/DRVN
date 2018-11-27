//
//  SlideOutMenuDelegate.swift
//  DRVN
//
//  Created by Owen Henley on 11/26/18.
//  Copyright © 2018 Owen Henley. All rights reserved.
//

import UIKit

protocol SlideOutMenuDelegate {
    func toggleMenu()
    func addMenuView()
    func animateMenuAppear(isActive: Bool)
}
