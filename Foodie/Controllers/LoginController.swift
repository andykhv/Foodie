//
//  LoginController.swift
//  Foodie
//
//  Created by Andy Khov on 10/22/19.
//  Copyright © 2019 Andy Khov. All rights reserved.
//

import UIKit
import os.log
import Firebase

class LoginController: UIViewController, UITextFieldDelegate {
    // MARK: Properties
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var statusLabel: UILabel!
    var email: String!
    var password: String!
    
    // MARK: ViewController lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let signOutButton = UIBarButtonItem()
        signOutButton.title = "Sign Out"
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = signOutButton
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.statusLabel.text = ""
        if Auth.auth().currentUser != nil {
          let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
          let profileController = storyBoard.instantiateViewController(withIdentifier: "profileController") as! ProfileController
          self.navigationController?.show(profileController, sender: self)
        }
    }
    
    // MARK: UITextFieldDelegate funcs
    func textFieldShouldReturn (_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    // MARK: Actions
    @IBAction func emailChanged(_ sender: UITextField) {
        self.email = sender.text
        print(self.email!)
    }
    @IBAction func passwordChanged(_ sender: UITextField) {
        self.password = sender.text
        print(self.password!)
    }
    @IBAction func loginButtonPressed(_ sender: UIButton) {
        self.statusLabel.text = "logging in..."
        self.statusLabel.textColor = .black
        login(withEmail: self.email!, with: self.password!, completion: {authResult, error in
            guard let user = authResult?.user, error == nil else {
                os_log("%@", log: OSLog.default, type: .info, error!.localizedDescription)
                self.statusLabel.text = error!.localizedDescription
                self.statusLabel.textColor = .red
                return
            }
            os_log("%@ logged in", log: OSLog.default, type: .info, user.email ?? "unknown")
            self.statusLabel.text = "login successful"
            self.statusLabel.textColor = .green
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let profileController = storyBoard.instantiateViewController(withIdentifier: "profileController") as! ProfileController
            self.navigationController?.show(profileController, sender: self)
        })
    }
    @IBAction func registerButtonPressed(_ sender: Any) {
        self.statusLabel.text = "creating account..."
        self.statusLabel.textColor = .black
        register(withEmail: self.email!, with: self.password!, completion: {authResult, error in
            guard let user = authResult?.user, error == nil else {
                os_log("%@", log: OSLog.default, type: .info, error!.localizedDescription)
                self.statusLabel.text = error!.localizedDescription
                self.statusLabel.textColor = .red
                return
            }
            os_log("%@ created", log: OSLog.default, type: .info, user.email ?? "unknown")
            self.statusLabel.text = "account created"
            self.statusLabel.textColor = .green
        })
    }
    
    /*
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    }*/

}
