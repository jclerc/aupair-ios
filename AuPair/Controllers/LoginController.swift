//
//  LoginController.swift
//  AuPair
//
//  Created by Jonathan on 18/12/2017.
//  Copyright © 2017 Jonathan. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginController: UIViewController {

    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func tryConnect(_ sender: Any) {
        if let email = emailField.text, let password = passwordField.text {
            Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
                if (error == nil) {
                    print("Success")
                    if let view = self.storyboard?.instantiateViewController(withIdentifier: "Home") as? HomeController {
                        self.present(view, animated: true, completion: nil)
                    }
                } else {
                    print("Invalid credentials")
                }
            }
        }
    }
    
}
