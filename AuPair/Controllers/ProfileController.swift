//
//  ProfileController.swift
//  AuPair
//
//  Created by Jonathan on 22/12/2017.
//  Copyright © 2017 Jonathan. All rights reserved.
//

import UIKit
import FirebaseAuth

class ProfileController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func tryRefreshCards(_ sender: Any) {
        tabBarController?.selectedIndex = 1
        if let home = tabBarController?.selectedViewController as? HomeController {
            home.kolodaView.resetCurrentCardIndex()
        }
    }
    
    @IBAction func tryLogout(_ sender: Any) {
        do {
            try Auth.auth().signOut()
            performSegue(withIdentifier: "unwindToWelcome", sender: self)
        } catch let error {
            print("ERROR: cannot disconnect due to \(error)")
        }
    }
    
}
