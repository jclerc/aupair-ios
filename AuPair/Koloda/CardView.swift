//
//  CardView.swift
//  AuPair
//
//  Created by Jonathan on 21/12/2017.
//  Copyright © 2017 Jonathan. All rights reserved.
//

import UIKit
import Koloda

class CardView: KolodaView {
    
    @IBOutlet weak var label: UILabel!
    
    var image: UIImage!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.layer.shadowOffset = CGSize(width: 0, height: 2)
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowRadius = 4
        self.layer.shadowOpacity = 0.3
        self.layer.cornerRadius = 6
        self.clipsToBounds = true
        self.layer.masksToBounds = false
        self.layer.cornerRadius = 6
    }
    
}
