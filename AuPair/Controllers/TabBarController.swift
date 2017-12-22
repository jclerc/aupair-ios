//
//  TabBarController.swift
//  AuPair
//
//  Created by Jonathan on 20/12/2017.
//  Copyright © 2017 Jonathan. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBar.layer.shadowOffset = CGSize(width: 0, height: -1)
        tabBar.layer.shadowColor = UIColor.gray.cgColor
        tabBar.layer.shadowRadius = 4
        tabBar.layer.shadowOpacity = 0.3
    }

}
