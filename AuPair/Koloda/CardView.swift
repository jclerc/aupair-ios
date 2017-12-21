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
    
    var mainKolodaView: KolodaView!
    
    @IBOutlet weak var pictureImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var verifiedImage: UIImageView!
    @IBOutlet weak var smokerImage: UIImageView!
    @IBOutlet weak var childrenLabel: UILabel!
    
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var languagesLabel: UILabel!
    
    @IBOutlet weak var datesLabel: UILabel!
    @IBOutlet weak var minimumDurationLabel: UILabel!
    
    @IBOutlet weak var firstActivityImage: UIImageView!
    @IBOutlet weak var firstActivityLabel: UILabel!
    
    @IBOutlet weak var secondActivityImage: UIImageView!
    @IBOutlet weak var secondActivityLabel: UILabel!
    
    func setData(_ mainKolodaView: KolodaView, _ data: [String: Any]) {
        self.mainKolodaView = mainKolodaView

        self.updateLayer()
        
        if let picture = data["picture"] as? String, let url = URL(string: picture) {
            DispatchQueue.global().async {
                let content = try? Data(contentsOf: url)
                DispatchQueue.main.async {
                    self.pictureImage.image = UIImage(data: content!)
                }
            }
        }
        
        if let firstName = data["first_name"], let lastName = data["last_name"] {
            nameLabel.text = "\(firstName) \(lastName)"
        }
        
        if let family = data["family"] as? [String: Any] {
            
            if let verified = family["verified"] as? Bool, verified == false {
                verifiedImage.alpha = 0
            }
            
            if let smoker = family["smoker"] as? Bool, smoker == false {
                smokerImage.alpha = 0
            }
            
            if let children = family["children"] {
                childrenLabel.text = "\(children)"
            }
            
            if let location = family["location"] {
                locationLabel.text = "\(location)"
            }
            
            if let languages = family["languages"] {
                languagesLabel.text = "\(languages)"
            }
            
            if let dates = family["dates"] {
                datesLabel.text = "de \(dates)"
            }
            
            if let minimumDuration = family["minimal_duration"] {
                minimumDurationLabel.text = "\(minimumDuration) mois minimum"
            }
            
            if let activities = family["activities"] as? [String: String], activities.count >= 2 {
                var i = 0
                for activity in activities {
                    var image: UIImageView
                    var label: UILabel
                    
                    if (i == 0) {
                        image = firstActivityImage
                        label = firstActivityLabel
                    } else if (i == 1) {
                        image = secondActivityImage
                        label = secondActivityLabel
                    } else {
                        break
                    }
                    
                    image.image = UIImage(named: "icon-\(activity.key)")
                    label.text = activity.value
                    i += 1
                }
            }
        }
    }
    
    func updateLayer() {
        self.layer.shadowOffset = CGSize(width: 0, height: 2)
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowRadius = 4
        self.layer.shadowOpacity = 0.3
        self.layer.cornerRadius = 6
        self.clipsToBounds = true
        self.layer.masksToBounds = false
        self.layer.cornerRadius = 6
    }
    
    @IBAction func trySkip(_ sender: Any) {
        mainKolodaView.swipe(.left)
    }
    
    @IBAction func tryLike(_ sender: Any) {
        mainKolodaView.swipe(.right)
    }
    
}
