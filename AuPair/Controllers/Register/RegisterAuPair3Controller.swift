//
//  RegisterAuPair3Controller.swift
//  AuPair
//
//  Created by Jonathan on 19/12/2017.
//  Copyright © 2017 Jonathan. All rights reserved.
//

import UIKit

class RegisterAuPair3Controller: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItem?.isEnabled = false
    }
    
    func updateNext() {
        self.navigationItem.rightBarButtonItem?.isEnabled = true
    }

}
