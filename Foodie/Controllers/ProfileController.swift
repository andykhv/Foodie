//
//  ProfileController.swift
//  Foodie
//
//  Created by Andy Khov on 10/22/19.
//  Copyright © 2019 Andy Khov. All rights reserved.
//

import UIKit
import os.log

class ProfileController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        if self.isMovingFromParent {
            logout(exception: {
                os_log("unable to log out of Firebase Authentication", log: OSLog.default, type: .info)
            })
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
