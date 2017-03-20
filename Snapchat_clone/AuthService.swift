//
//  AuthService.swift
//  Snapchat_clone
//
//  Created by Alfredo M. on 3/18/17.
//  Copyright © 2017 Alfredo M. All rights reserved.
//

import Foundation
import FirebaseAuth

typealias Completion = (_ errMsg: String?, _ data: AnyObject?) -> Void

class AuthService {
    
    private static let _instance = AuthService()
    
    static var instance: AuthService{
        return _instance
    }
    
    func login(email: String, password: String, onComplete: Completion?) {
        
        print("llego aqui tambien.")
        FIRAuth.auth()?.signIn(withEmail: email, password: password, completion: { user, error in
            if error != nil {
                if let errorCode = FIRAuthErrorCode(rawValue: error!._code) {
                    if errorCode == .errorCodeUserNotFound {
                        FIRAuth.auth()?.createUser(withEmail: email, password: password, completion: { user, error in
                            if error != nil {
                                //Show error to user
                                self.handleFirebaseError(error: error as! NSError, onComplete: onComplete!)
                                
                            }else {
                                if user?.uid != nil {
                                    print("Debug: Llego aqui con \(user?.uid)")
                                    DataService.instance.saveUser(uid: (user?.uid)!)
                                    
                                    FIRAuth.auth()?.signIn(withEmail: email, password: password, completion: { user, error in
                                        if error != nil {
                                            // Show error to user
                                            self.handleFirebaseError(error: error as! NSError, onComplete: onComplete!)
                                            
                                        } else {
                                            // Successful logged in
                                            onComplete! (nil, user)
                                        }
                                    })
                                }
                            }
                            
                        })
                    }
                } else {
                    // Handle all other errors
                    self.handleFirebaseError(error: error as! NSError, onComplete: onComplete!)
                }
            } else {
                //Successfully logged in
                onComplete!(nil, user)
            }
        })
    }
    
    func handleFirebaseError(error: NSError, onComplete: Completion){
        print (error.debugDescription)
        
        if let errorCode = FIRAuthErrorCode(rawValue: error.code) {
            switch (errorCode) {
            case .errorCodeInvalidEmail, .errorCodeEmailAlreadyInUse:
                onComplete("Invalid email address", nil)
                break
            //print("Invalid email.")
            case .errorCodeWrongPassword:
                onComplete("Wrong password", nil)
                print("Wrog password.")
                break
            case .errorCodeEmailAlreadyInUse:
                onComplete("Could not create account. Email already in use.", nil)
                break
            default:
                onComplete("There was a problem authenticating, try again.", nil)
                print("Default error code.")
            }
        }
    }
}
