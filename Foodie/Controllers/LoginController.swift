//
//  LoginController.swift
//  Foodie
//
//  Created by Andy Khov on 10/22/19.
//  Copyright © 2019 Andy Khov. All rights reserved.
//

import UIKit

class LoginController: UIViewController {
    // MARK: Properties
    
    // MARK: ViewController lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "Sign Out", style: .plain, target: nil, action: nil)
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
