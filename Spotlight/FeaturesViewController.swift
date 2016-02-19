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
    @IBOutlet weak var turnupBtn: UIButton!
    
    var timer = NSTimer()
    var counter = 0
    var turnupOn = false
    
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

    @IBAction func turnupPressed(sender: AnyObject) {
        let device = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo)
        if (turnupOn == true) {
            timer.invalidate()
            turnupOn = false;
            do {
                try device.lockForConfiguration()
                device.torchMode = AVCaptureTorchMode.Off
                device.unlockForConfiguration()
            } catch {
                print(error)
            }
        } else {
            timer.invalidate()
            timer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: "timerAction", userInfo: nil, repeats: true)
            turnupOn = true;
        }
    }
    
    func timerAction() {
        let device = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo)
        if (counter%2 == 0) {
            do {
                try device.lockForConfiguration()
                try device.setTorchModeOnWithLevel(1.0)
                device.unlockForConfiguration()
            } catch {
                print(error)
            }
        } else {
            do {
                try device.lockForConfiguration()
                device.torchMode = AVCaptureTorchMode.Off
                device.unlockForConfiguration()
            } catch {
                print(error)
            }
        }
        ++counter
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillDisappear(animated: Bool) {
        self.navigationController?.navigationBarHidden = false
    }
}
