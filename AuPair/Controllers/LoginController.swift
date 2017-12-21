//
//  LoginController.swift
//  AuPair
//
//  Created by Jonathan on 18/12/2017.
//  Copyright © 2017 Jonathan. All rights reserved.
//

import UIKit
import Firebase

class LoginController: UIViewController {
    
    var ref: DatabaseReference!

    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
    }

    @IBAction func tryConnect(_ sender: Any) {
        loginButton.isEnabled = false
        
        if let email = emailField.text, let password = passwordField.text {
            Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
                
                if (error == nil) {
                    print("Successfully logged in")
                    
                    self.ref.child("users/\(user!.uid)").observeSingleEvent(of: .value, with: { (snapshot) in
                        // get value to track it
                        if let value = snapshot.value as? [String: Any] {
                            if let type = value["type"] as? String, type == "family" {
                                Analytics.setUserProperty(type, forName: "user_type")
                                print("ANALYTICS: set user_type")
                                if let family = value["family"] as? [String: Any] {
                                    if let location = family["location"] as? String {
                                        Analytics.setUserProperty(location, forName: "user_location")
                                        print("ANALYTICS: set user_location")
                                    }
                                    if let languages = family["languages"] as? String {
                                        Analytics.setUserProperty(languages, forName: "user_languages")
                                        print("ANALYTICS: set user_languages")
                                    }
                                }
                            }
                        }
                        
                        // login success
                        Analytics.logEvent("login_state", parameters: [
                            "login_state": "Success"
                        ])

                        // then start!
                        if let tabBar = self.storyboard?.instantiateViewController(withIdentifier: "TabBar") as? TabBarController {
                            tabBar.selectedIndex = 1
                            self.present(tabBar, animated: true, completion: nil)
                        }
                    })
                } else {
                    print("Invalid credentials provided")
                    self.loginButton.isEnabled = true
                    
                    // login failed
                    Analytics.logEvent("login_state", parameters: [
                        "login_state": "Fail"
                    ])
                    
                    let alert = UIAlertController(title: "Erreur", message: "Mauvais identifiants.", preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }
    }
    
}
