//
//  ContainerVC.swift
//  DRVN
//
//  Created by Owen Henley on 11/27/18.
//  Copyright © 2018 Owen Henley. All rights reserved.
//

import UIKit
import QuartzCore

enum SlideOutState {
    case collapsed
    case leftPanelExpanded
}

enum ShowWhichVC {
    case homeVC
}

var showVC: ShowWhichVC = .homeVC

class ContainerVC: UIViewController {
    
    var homeVC: HomeVC!
    var currentState: SlideOutState = .collapsed {
        didSet {
            let shouldShowShadow = currentState != .collapsed
            shouldShowShadowForVC(status: shouldShowShadow)
        }
    }
    var leftVC: LeftSidePanelVC!
    let centerPanelExpandedOffset: CGFloat = 160
    var centerController: UIViewController!
    var tapGesture = UITapGestureRecognizer()
    
    var isHidden = false

    override func viewDidLoad() {
        super.viewDidLoad()
        initCenter(screen: showVC)
    }
    
    func initCenter(screen: ShowWhichVC) {
        var presentingController: UIViewController
        
        showVC = screen
        
        if homeVC == nil {
            homeVC = UIStoryboard.homeVC()
            homeVC.slideOutMenuDelegate = self
        }
        
        presentingController = homeVC
        
        // remove before initialising new view
        if let controller = centerController {
            controller.view.removeFromSuperview()
            controller.removeFromParent()
        }
        
        centerController = presentingController
        view.addSubview(centerController.view)
        addChild(centerController)
        centerController.didMove(toParent: self)
    }
    
    override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation {
        return UIStatusBarAnimation.slide
    }
    
    override var prefersStatusBarHidden: Bool {
        return isHidden
    }

}


extension ContainerVC: CenterVCDelegate {
    
    func toggleLeftPanel() {
        let notAlreadyExpanded = currentState != .leftPanelExpanded
        
        if notAlreadyExpanded {
            addLeftPanelViewController()
        }
        animateLeftPanel(shouldExpand: notAlreadyExpanded)
    }
    
    func addLeftPanelViewController() {
        if leftVC == nil {
            leftVC = UIStoryboard.leftViewController()
            addChildSidePanelVC(leftVC)
        }
    }
    
    @objc func animateLeftPanel(shouldExpand: Bool) {
        if shouldExpand {
            isHidden = !isHidden
            animateStatusBar()
            setupWhiteCoverView()
            animateCenterPanelXPosition(targetPosition: centerController.view.frame.width - centerPanelExpandedOffset)
            currentState = .leftPanelExpanded
        } else {
            isHidden = !isHidden
            animateStatusBar()
            hideWhiteCoverView()
            animateCenterPanelXPosition(targetPosition: 0) { (finished) in
                if finished {
                    self.currentState = .collapsed
                    self.leftVC = nil
                }
            }
        }
    }
    
    func animateStatusBar() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: .curveEaseInOut,
                       animations: {
                        self.setNeedsStatusBarAppearanceUpdate()
        })
    }
    
    func animateCenterPanelXPosition(targetPosition: CGFloat, completion: ((Bool) -> ())! = nil) {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: .curveEaseInOut,
                       animations: {
                        self.centerController.view.frame.origin.x = targetPosition
        }, completion: completion)
    }
    
    func setupWhiteCoverView() {
        let whiteCoverView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
        whiteCoverView.alpha = 0
        whiteCoverView.backgroundColor = .white
        whiteCoverView.tag = 25
        
        self.centerController.view.addSubview(whiteCoverView)
        UIView.animate(withDuration: 0.2) {
            whiteCoverView.alpha = 0.7
        }
        
        tapGesture = UITapGestureRecognizer(target: self, action: #selector(animateLeftPanel(shouldExpand:)))
        tapGesture.numberOfTapsRequired = 1
        self.centerController.view.addGestureRecognizer(tapGesture)
    }
    
    func hideWhiteCoverView() {
        centerController.view.removeGestureRecognizer(tapGesture)
        for subview in self.centerController.view.subviews {
            if subview.tag == 25 {
                UIView.animate(withDuration: 0.2, animations: {
                    subview.alpha = 0
                }) { (finished) in
                    subview.removeFromSuperview()
                }
                
            }
        }
    }
    
    func shouldShowShadowForVC(status: Bool) {
        if status {
            centerController.view.layer.shadowOpacity = 0.4
        } else {
            centerController.view.layer.shadowOpacity = 0
        }
    }
    
    func addChildSidePanelVC(_ sidePanelController: LeftSidePanelVC) {
        view.insertSubview(sidePanelController.view, at: 0)
        addChild(sidePanelController)
        sidePanelController.didMove(toParent: self)
    }
    
    
}


private extension UIStoryboard {
    
    class func mainStoryboard() -> UIStoryboard {
        return UIStoryboard(name: "HomeScreen", bundle: Bundle.main)
    }
    
    class func leftViewController() -> LeftSidePanelVC? {
        return mainStoryboard().instantiateViewController(withIdentifier: "LeftSidePanelVC") as? LeftSidePanelVC
    }
    
    class func homeVC() -> HomeVC? {
        return mainStoryboard().instantiateViewController(withIdentifier: "HomeVC") as? HomeVC
    }
}
