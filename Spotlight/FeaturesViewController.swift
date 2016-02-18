//
//  FeaturesViewController.swift
//  Spotlight
//
//  Created by Christine Munar on 2/18/16.
//  Copyright © 2016 Christine Munar. All rights reserved.
//

import UIKit
import AVFoundation
import CoreGraphics
import Foundation

class FeaturesViewController: UIViewController {


    @IBOutlet weak var frequencySlider: UISlider!
    @IBOutlet weak var lightbulbImg: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBarHidden = false
        frequencySlider.minimumTrackTintColor = UIColor.redColor()
        self.lightbulbImg.alpha = 0.1;
        self.navigationController?.navigationBar.barTintColor = UIColor.blackColor()
        lightbulbImg.image? = (lightbulbImg.image?.imageWithRenderingMode(.AlwaysTemplate))!
        lightbulbImg.tintColor = UIColor.whiteColor()
    }
    
    @IBAction func sliderAction(sender: AnyObject) {
        let device = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo)
        let value = Float(self.frequencySlider.value)
        if (device.hasTorch) {
            do {
                try device.lockForConfiguration()
                if (value == 0.0) {
                    device.torchMode = AVCaptureTorchMode.Off
                } else {
                    try device.setTorchModeOnWithLevel(value)
                    self.lightbulbImg.alpha = CGFloat(value);
                }
                device.unlockForConfiguration()
            } catch {
                print(error)
            }
        }
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillDisappear(animated: Bool) {
        self.navigationController?.navigationBarHidden = false
    }
}
