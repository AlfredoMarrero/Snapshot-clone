//
//  DataService.swift
//  Snapchat_clone
//
//  Created by Alfredo M. on 3/20/17.
//  Copyright © 2017 Alfredo M. All rights reserved.
//

import Foundation
import FirebaseDatabase

let FIR_CHILD_USERS = "users"

class DataService {

    private static let _instance = DataService()
    
    private let REF_DATABASE = FIRDatabase.database().reference()

    static var instance: DataService {
        return _instance
    }

    func saveUser(uid: String) {
        let profile: Dictionary<String, Any> = ["firstName": "", "lastName": ""]
        
        REF_DATABASE.child(FIR_CHILD_USERS).child(uid).child("profile").setValue(profile)
    }
    
    var usersRef: FIRDatabaseReference {
        return REF_DATABASE.child(FIR_CHILD_USERS)
    }

}
