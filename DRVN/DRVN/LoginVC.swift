//
//  LoginVC.swift
//  DRVN
//
//  Created by Owen Henley on 11/27/18.
//  Copyright © 2018 Owen Henley. All rights reserved.
//

import UIKit
import Firebase

class LoginVC: UIViewController {
    
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var loginButton: RoundedShadowButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.bindToKeyboard()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(screenTapped(sender:)))
        self.view.addGestureRecognizer(tapGesture)
    }
    
    
    @objc func screenTapped(sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    
    @IBAction func exitTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}

extension LoginVC: UITextFieldDelegate {
    
    @IBAction func signInTapped(_ sender: Any) {
        if emailTF.text != nil && passwordTF.text != nil {
            loginButton.animateButton(shouldLoad: true, with: nil)
            self.view.endEditing(true)
            
            if let email = emailTF.text, let password = passwordTF.text {
                AUTH.signIn(withEmail: email, password: password) { (user, error) in
                    if error == nil {
                        if let user = user {
                            if self.segmentedControl.selectedSegmentIndex == 0 {
                                let userData = ["provider": user.additionalUserInfo?.providerID as Any] as [String : Any]
                                DataService.shared.createUser(uid: (AUTH.currentUser?.uid)!, userData: userData, isDriver: false)
                            } else {
                                let userData = ["provider" : user.additionalUserInfo?.providerID as Any,
                                                "userIsDriver" : true,
                                                "isPickupModeEnabled" : false,
                                                "driverIsOnTrip" : true,
                                ] as [String : Any]
                                DataService.shared.createUser(uid: (AUTH.currentUser?.uid)!, userData: userData, isDriver: true)
                            }
                        }
                        print("Successfully signed in")
                        self.dismiss(animated: true, completion: nil)
                    } else {
                        AUTH.createUser(withEmail: email, password: password, completion: { (user, error) in
                            if error != nil {
                                self.handleError(error!)
                            } else {
                                if let user = user {
                                    if self.segmentedControl.selectedSegmentIndex == 0 {
                                        let userData = ["provider" : user.additionalUserInfo?.providerID as Any] as [String : Any]
                                        DataService.shared.createUser(uid: (AUTH.currentUser?.uid)!, userData: userData, isDriver: false)
                                    } else {
                                        let userData = ["provider" : user.additionalUserInfo?.providerID as Any,
                                                        "userIsDriver" : true,
                                                        "isPickupModeEnabled" : false,
                                                        "driverIsOnTrip" : true,
                                                        ] as [String : Any]
                                        DataService.shared.createUser(uid: (AUTH.currentUser?.uid)!, userData: userData, isDriver: true)
                                    }
                                }
                                print("New user created!")
                                self.dismiss(animated: true, completion: nil)
                            }
                            
                        })
                    }
                }
            }
        }
    }
}
