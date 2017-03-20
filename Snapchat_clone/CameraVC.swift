//
//  CameraVC.swift
//  Snapchat_clone
//
//  Created by Alfredo M. on 3/16/17.
//  Copyright © 2017 Alfredo M. All rights reserved.
//

import UIKit
import FirebaseAuth

class CameraVC: AVCamCameraViewController, AVCameraVCDelegate{
    
    @IBOutlet weak var cameraBtn: UIButton!
    @IBOutlet weak var recordBtn: UIButton!
    @IBOutlet weak var previewView: AVCamPreviewView!
    
    
    override func viewDidLoad() {
        self._previewView = previewView
        super.viewDidLoad()
        
        delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        //guard FIRAuth.auth()?.currentUser != nil else {
            performSegue(withIdentifier: "LoginVC", sender: nil)
          //  return
        //}
    }
    
    @IBAction func recordBtnTapped(_ sender: Any) {
        toggleMovieRecording()
    }
    
    @IBAction func changeCameraBtnPressed(_ sender: Any) {
       
    }
    func shouldEnableRecordUI(_ enable: Bool) {
        recordBtn.isEnabled = enable
        print ("Should enable record UI \(enable)")
    }
    func shouldEnableCameraUI(_ enable: Bool){
         cameraBtn.isEnabled = enable
         print("Should enable camera UI \(enable)")
    }
    func canSatartRecording() {
        print ("Recording has started.")
    }
    func recordingHasStarted(){
        print("Can start recording.")
    }

}

