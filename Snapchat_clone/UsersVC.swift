//
//  UsersVC.swift
//  Snapchat_clone
//
//  Created by Alfredo M. on 3/20/17.
//  Copyright © 2017 Alfredo M. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseStorage
import FirebaseAuth

class UsersVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var users = [User]()
    private var listOfSelectedUsers = Dictionary<String, User>()
    
    private var _imageData: Data?
    private var _videoURL: URL?
    
    var imageData: Data {
        set{
            _imageData = newValue
        }
        get {
            return _imageData!
        }
    }
    
    var videoURL: URL {
        set {
            _videoURL = newValue
        }
        get {
            return _videoURL!
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.allowsMultipleSelection = true
        
        navigationItem.rightBarButtonItem?.isEnabled = false
        
        DataService.instance.usersRef.observeSingleEvent(of: .value) { (snapshot: FIRDataSnapshot) in
            print("Snap: \(snapshot.debugDescription)")
            if let users = snapshot.value as? Dictionary <String, AnyObject> {
                
                for (key, value) in users {
                    if let dic = value as? Dictionary<String, AnyObject> {
                        if let profile = dic["profile"] as? Dictionary <String, AnyObject> {
                            if let firstName = profile["firstName"] as? String {
                                let uid = key
                                let user = User(uid: uid, firstName: firstName)
                                self.users.append(user)
                            }
                        }
                    }
                }
            }
            self.tableView.reloadData()
            print("Users: \(self.users)")
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "UserCell") as? UserCell {
            cell.updateUI(user: users[indexPath.row])
            return cell
        }
        
        return UserCell()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        navigationItem.rightBarButtonItem?.isEnabled = true
        navigationItem.rightBarButtonItem?.isEnabled = true
        let cell = tableView.cellForRow(at: indexPath) as! UserCell
        cell.setCheckmark(selected: true)
        let user = users[indexPath.row]
        listOfSelectedUsers[user.uid] = user
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! UserCell
        cell.setCheckmark(selected: false)
        let user = users[indexPath.row]
        listOfSelectedUsers[user.uid] = nil
        
        if listOfSelectedUsers.count <= 0 {
            navigationItem.rightBarButtonItem?.isEnabled = false
        }
    }
    
    @IBAction func sendSnapButtonPressed (sender: AnyObject){
        
        if let url = _videoURL {
            let videoName = "\(NSUUID().uuidString)\(url)"
            let ref = DataService.instance.videoStorageRef.child(videoName)
            
            let task = ref.putFile(url, metadata: nil, completion: { (meta : FIRStorageMetadata?, err : Error?) in
                
                if err != nil {
                    print ("Error uploading video: \(err?.localizedDescription)")
                    
                } else {
                    let downloadURL = meta!.downloadURL()
                    
                    DataService.instance.sendMediaPullRequest(senderUID: (FIRAuth.auth()?.currentUser!.uid)!, sendingTo: self.listOfSelectedUsers, mediaURL: downloadURL!, textSnippet: " ")
                }
            })
            self.dismiss(animated: true, completion: nil)
            
        } else if let imageData = _imageData {
            
            let ref = DataService.instance.imageStorageRef.child("\(NSUUID().uuidString).jpg")
            
            _ = ref.put (imageData, metadata: nil, completion: { (meta: FIRStorageMetadata?, err: Error?) in
                
                if err != nil {
                    print("Error uploading image: \(err?.localizedDescription)")
                } else {
                    let downLoadURL = meta!.downloadURL()
                }
            })
            self.dismiss(animated: true, completion: nil)
        }
    }
}
