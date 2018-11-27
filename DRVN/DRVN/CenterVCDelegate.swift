//
//  CenterVCDelegate.swift
//  DRVN
//
//  Created by Owen Henley on 11/26/18.
//  Copyright © 2018 Owen Henley. All rights reserved.
//

import UIKit

protocol CenterVCDelegate {
    func toggleLeftPanel()
    func addLeftPanelViewController()
    func animateLeftPanel(shouldExpand: Bool)
}
