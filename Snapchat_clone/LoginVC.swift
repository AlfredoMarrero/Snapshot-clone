//
//  LoginVC.swift
//  Snapchat_clone
//
//  Created by Alfredo M. on 3/17/17.
//  Copyright © 2017 Alfredo M. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {

    @IBOutlet weak var emailField: RoundTextField!
    @IBOutlet weak var passwordField: RoundTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func loginButton(_ sender: Any) {
        print("llego aqui")
        if let email = emailField.text, let pass = passwordField.text, email.characters.count > 0 && pass.characters.count > 0 {
            //Call the login cervice
            AuthService.instance.login(email: email, password: pass, onComplete: { errMsg, data in
                guard errMsg == nil else {
                    print("errMsg: \(errMsg)")
                    let alert = UIAlertController (title: "Error Authentication", message: errMsg, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                    return
                }
                self.dismiss(animated: true, completion: nil)
            })
        } else {
            let alert = UIAlertController(title: "Username and Password Required.", message: "You must enter both a user name and a password", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction( title: "OK", style: .cancel, handler: nil))
            present(alert, animated: true, completion: nil)
        }
    }
}
