//
//  RegisterAuPair2Controller.swift
//  AuPair
//
//  Created by Jonathan on 19/12/2017.
//  Copyright © 2017 Jonathan. All rights reserved.
//

import UIKit

class RegisterAuPair2Controller: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItem?.isEnabled = false
    }
    
    @IBAction func tryNext(_ sender: Any) {
        if let view = storyboard?.instantiateViewController(withIdentifier: "RegisterAuPair3") {
            navigationController?.pushViewController(view, animated: true)
        }
    }

    func updateNext() {
        self.navigationItem.rightBarButtonItem?.isEnabled = true
    }

}
