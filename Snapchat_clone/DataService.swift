//
//  DataService.swift
//  Snapchat_clone
//
//  Created by Alfredo M. on 3/20/17.
//  Copyright © 2017 Alfredo M. All rights reserved.
//

import Foundation
import FirebaseDatabase
import FirebaseStorage

let FIR_CHILD_USERS = "users"

class DataService {
    
    private static let _instance = DataService()
    
    private let REF_DATABASE = FIRDatabase.database().reference()
    private let REF_MAIN_STORAGE =  FIRStorage.storage().reference()
    
    static var instance: DataService {
        return _instance
    }
    
    var mainRef: FIRDatabaseReference {
        return REF_DATABASE
    }
    
    var mainStorageRef: FIRStorageReference {
        return REF_MAIN_STORAGE
    }
    
    var imageStorageRef: FIRStorageReference {
        return REF_MAIN_STORAGE.child("images")
    }
    
    var videoStorageRef: FIRStorageReference {
        return REF_MAIN_STORAGE.child("videos")
    }
    
    func saveUser(uid: String) {
        let profile: Dictionary<String, Any> = ["firstName": "", "lastName": ""]
        
        REF_DATABASE.child(FIR_CHILD_USERS).child(uid).child("profile").setValue(profile)
    }
    
    var usersRef: FIRDatabaseReference {
        return REF_DATABASE.child(FIR_CHILD_USERS)
    }
    
    func sendMediaPullRequest( senderUID : String, sendingTo: Dictionary<String, User>, mediaURL: URL, textSnippet: String? = nil) {
        
        
        var uids = [String]()
        for user in sendingTo.keys {
            uids.append(user)
        }

        let pr: Dictionary<String, Any> = ["mediaURL": mediaURL.absoluteString, "userID" : senderUID, "openCount": 0, "recipients": uids];
        
        mainRef.child("pullRequests").childByAutoId().setValue(pr)
    }
}
