//
//  LoginVC.swift
//  DRVN
//
//  Created by Owen Henley on 11/27/18.
//  Copyright © 2018 Owen Henley. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {

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
