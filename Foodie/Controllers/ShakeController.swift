//
//  ShakeController.swift
//  Foodie
//
//  Created by Andy Khov on 5/5/19.
//  Copyright © 2019 Andy Khov. All rights reserved.
//

import UIKit
import AudioToolbox
import os.log

class ShakeController: UIViewController {
    // MARK: Properties
    @IBOutlet weak var imageView: UIImageView!
    var loadingImage: UIImage!
    
    // MARK: ViewController lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // load "loading" icon
        loadingImage = UIImage.animatedImageNamed("loading", duration: 1)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        imageView.image = UIImage(named: "PhoneShake")
    }
    
    // MARK: UIResponder
    override func motionBegan(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
            imageView.image = loadingImage
            os_log("shaking detected", log: OSLog.default, type: .debug)
        }
    }
}
