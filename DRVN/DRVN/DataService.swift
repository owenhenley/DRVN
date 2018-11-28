//
//  DataService.swift
//  DRVN
//
//  Created by Owen Henley on 11/27/18.
//  Copyright © 2018 Owen Henley. All rights reserved.
//

import Foundation
import Firebase

class DataService {
    
    static let shared = DataService()
    
    private var Ref_Base = FIRESTORE
    private var Ref_Users = FIRESTORE.collection("users")
    private var Ref_Drivers = FIRESTORE.collection("drivers")
    private var Ref_Trips = FIRESTORE.collection("trips")
    
    
    func createUser(uid: String, userData: Dictionary<String, Any>, isDriver: Bool) {
        if isDriver {
            Ref_Drivers.document(uid).updateData(userData)
        } else {
            Ref_Users.document(uid).updateData(userData)
        }
    }
    
}


