//
//  MenuContainerVC.swift
//  DRVN
//
//  Created by Owen Henley on 11/26/18.
//  Copyright © 2018 Owen Henley. All rights reserved.
//

import UIKit
import QuartzCore

class MenuContainerVC: UIViewController {
    
    var showVC: SwitchCurrentVC = .homeVC
    var homeVC: HomeVC!
    var currentState: SlideOutState = .inactive {
        didSet {
            let shouldShowShadow = currentState != .inactive
            shouldShowShadowForMenu(status: shouldShowShadow)
        }
    }
    var menuVC: SlideOutMenuVC!
    var menuController: UIViewController!
    var tapGesture: UITapGestureRecognizer!
    
    var statusHidden = false
    let menuOpenedOffset: CGFloat = 160
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initMenuVC(screen: showVC)
    }
    
    func initMenuVC(screen: SwitchCurrentVC) {
        var presentController: UIViewController
        showVC = screen
        if homeVC == nil {
            homeVC = UIStoryboard.homeVC()
            homeVC.slideOutMenuDelegate = self
        }
        presentController = homeVC
        
        if let controller = menuController {
            controller.view.removeFromSuperview()
            controller.removeFromParent()
        }
        menuController = presentController
        view.addSubview(menuController.view)
        addChild(menuController)
        menuController.didMove(toParent: self)
    }
    
    override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation {
        return UIStatusBarAnimation.slide
    }
    
    override var prefersStatusBarHidden: Bool {
        return statusHidden
    }
    
}

extension MenuContainerVC: SlideOutMenuDelegate {
    
    func toggleMenu() {
        let notOpen = currentState != .active
        if notOpen {
            addMenuView()
        }
        animateMenuAppear(isActive: notOpen)
    }
    
    func addMenuView() {
        if menuVC == nil {
            menuVC = UIStoryboard.menuViewController()
            addChildSlideMenuVC(menuVC)
        }
    }
    
    func addChildSlideMenuVC(_ menuVC: SlideOutMenuVC) {
        view.insertSubview(menuVC.view, at: 0)
        addChild(menuVC)
        menuVC.didMove(toParent: self)
    }
    
    @objc func animateMenuAppear(isActive: Bool) {
        if isActive {
            statusHidden = !statusHidden
            animateStatusBar()
            setupCoverView()
            currentState = .active
            animateMenuXPosition(targetPosition: menuController.view.frame.width - menuOpenedOffset)
        } else {
            statusHidden = !statusHidden
            animateStatusBar()
            hideCoverView()
            animateMenuXPosition(targetPosition: 0) { (finished) in
                if finished {
                    self.currentState = .inactive
                    self.menuVC = nil
                }
            }
        }
    }
    
    func animateMenuXPosition(targetPosition: CGFloat, completion: ((Bool) -> ())! = nil) {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
            self.menuController.view.frame.origin.x = targetPosition
        }, completion: completion)
    }
    
    func animateStatusBar() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
            self.setNeedsStatusBarAppearanceUpdate()
        })
    }
    
    // The white overlay on may when menu slides out
    func setupCoverView() {
        let coverview = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
        coverview.alpha = 0.0
        coverview.backgroundColor = .white
        coverview.tag = 25
        self.menuController.view.addSubview(coverview)
        UIView.animate(withDuration: 0.2) {
            coverview.alpha = 0.7
        }
        
        tapGesture = UITapGestureRecognizer(target: self, action: #selector(animateMenuAppear(isActive:)))
        tapGesture.numberOfTapsRequired = 1
        
        self.menuController.view.addGestureRecognizer(tapGesture)
    }
    
    func shouldShowShadowForMenu(status: Bool) {
        if status {
            menuController.view.layer.shadowOpacity = 0.4
        } else {
            menuController.view.layer.shadowOpacity = 0.0
        }
    }
    
    func hideCoverView() {
        menuController.view.removeGestureRecognizer(tapGesture)
        for subview in self.menuController.view.subviews {
            if subview.tag == 25 {
                UIView.animate(withDuration: 0.2, animations: {
                    subview.alpha = 0.0
                }) { (finished) in
                    subview.removeFromSuperview()
                }
            }
        }
    }
}

// Only this vc has access to this extension
private extension UIStoryboard {
    
    class func mainStoryboard() -> UIStoryboard {
        return UIStoryboard(name: "HomeScreen", bundle: Bundle.main)
    }
    
    class func menuStoryBoard() -> UIStoryboard {
        return UIStoryboard(name: "SlideOutMenu", bundle: Bundle.main)
    }
    
    class func menuViewController() -> SlideOutMenuVC? {
        return menuStoryBoard().instantiateViewController(withIdentifier: "SlideOutMenuVC") as? SlideOutMenuVC
    }
    
    class func homeVC() -> HomeVC? {
        return mainStoryboard().instantiateViewController(withIdentifier: "HomeVC") as? HomeVC
    }
}

enum SlideOutState {
    case inactive
    case active
}

enum SwitchCurrentVC {
    case homeVC
}
