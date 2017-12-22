//
//  DiscussionController.swift
//  AuPair
//
//  Created by Jonathan on 22/12/2017.
//  Copyright © 2017 Jonathan. All rights reserved.
//

import UIKit

class DiscussionController: UIViewController {

    @IBOutlet weak var bottomBar: UIView!
    @IBOutlet weak var messageField: UITextField!
    @IBOutlet weak var nameLabel: UILabel!
    
    var name: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameLabel.text = name
        
        bottomBar.layer.shadowOffset = CGSize(width: 0, height: -1)
        bottomBar.layer.shadowColor = UIColor.gray.cgColor
        bottomBar.layer.shadowRadius = 4
        bottomBar.layer.shadowOpacity = 0.3
    }

    @IBAction func trySend(_ sender: Any) {
        let msg = messageField.text
        print("Send: \(msg ?? "")")
        
        let alert = UIAlertController(title: "Erreur", message: "Cette fonctionnalité n'est pas encore disponible !", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
}
