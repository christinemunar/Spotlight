//
//  ViewController.swift
//  Spotlight
//
//  Created by Christine Munar on 2/18/16.
//  Copyright © 2016 Christine Munar. All rights reserved.
//

import UIKit
import AVFoundation
import CoreGraphics
import Foundation

class ViewController: UIViewController {

    @IBOutlet weak var btnFlash: UIButton!
    @IBOutlet weak var titleImg: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBarHidden = true
        btnFlash.setImage(UIImage(named: "icon.png"), forState: UIControlState.Normal)
        self.btnFlash.alpha = 0.35;
        self.titleImg.alpha = 0.55;
        
    }
    
    @IBAction func buttonClicked(sender: AnyObject) {
        let device = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo)
        if (device.hasTorch) {
            do {
                try device.lockForConfiguration()
                if (device.torchMode == AVCaptureTorchMode.On) {
                    device.torchMode = AVCaptureTorchMode.Off
                    btnFlash.setTitle("TURN ON", forState: .Normal)
                    self.btnFlash.alpha = 0.35;
                    self.titleImg.alpha = 0.55;
                } else {
                    try device.setTorchModeOnWithLevel(1.0)
                    btnFlash.setTitle("TURN OFF", forState: .Normal)
                    self.btnFlash.alpha = 1;
                    self.titleImg.alpha = 1;
                }
                device.unlockForConfiguration()
            } catch {
                print(error)
            }
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBarHidden = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

