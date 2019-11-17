//
//  FirebaseAuthenticationService.swift
//  Foodie
//
//  Created by Andy Khov on 11/3/19.
//  Copyright © 2019 Andy Khov. All rights reserved.
//

import Foundation
import Firebase
import os.log

func login(withEmail email: String, with password: String, completion completionHandler: AuthDataResultCallback?) -> Void {
    Auth.auth().signIn(withEmail: email, password: password, completion: completionHandler)
}

func register(withEmail email: String, with password: String, completion completionHandler: AuthDataResultCallback?) -> Void {
    Auth.auth().createUser(withEmail: email, password: password, completion: completionHandler)
}

func logout(exception exceptionHandler: () -> Void) -> Void {
    do {
        try Auth.auth().signOut()
        os_log("logout succesful Firebase Authentication", log: OSLog.default, type: .info)
    } catch {
        exceptionHandler()
    }
}
