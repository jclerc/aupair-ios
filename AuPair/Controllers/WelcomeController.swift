//
//  ViewController.swift
//  AuPair
//
//  Created by Jonathan on 18/12/2017.
//  Copyright © 2017 Jonathan. All rights reserved.
//

import UIKit
import Firebase

class WelcomeController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func tryRegisterAuPair(_ sender: Any) {
        Analytics.logEvent("register_user_type", parameters: [
            "user_type": "aupair"
        ])
        unavailable()
    }
    
    @IBAction func tryRegisterFamily(_ sender: Any) {
        Analytics.logEvent("register_user_type", parameters: [
            "user_type": "family"
        ])
        unavailable()
    }
    
    func unavailable() {
        if let view = storyboard?.instantiateViewController(withIdentifier: "RegisterUnavailable") {
            present(view, animated: true, completion: nil)
        }
    }
    
    @IBAction func unwindToWelcome(sender: UIStoryboardSegue) {}

}

