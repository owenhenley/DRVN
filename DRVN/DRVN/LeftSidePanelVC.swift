//
//  SlideOutMenuVC.swift
//  DRVN
//
//  Created by Owen Henley on 11/26/18.
//  Copyright © 2018 Owen Henley. All rights reserved.
//

import UIKit

class LeftSidePanelVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func signupSigninTapped(_ sender: Any) {
        let loginStoryboard = UIStoryboard(name: "LoginScreen", bundle: Bundle.main)
        let loginVC = loginStoryboard.instantiateViewController(withIdentifier: "LoginVC") as? LoginVC
        
        guard let login = loginVC else { return }
        present(login, animated: true, completion: nil)
    }
    
}
