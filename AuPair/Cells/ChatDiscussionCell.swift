//
//  ChatDiscussionCell.swift
//  AuPair
//
//  Created by Jonathan on 22/12/2017.
//  Copyright © 2017 Jonathan. All rights reserved.
//

import UIKit

class ChatDiscussionCell: UITableViewCell {
    
    @IBOutlet weak var chatView: UIView!
    @IBOutlet weak var pictureImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        chatView.layer.shadowOffset = CGSize(width: 0, height: 1)
        chatView.layer.shadowColor = UIColor.gray.cgColor
        chatView.layer.shadowRadius = 3
        chatView.layer.shadowOpacity = 0.15
        chatView.layer.cornerRadius = 6
        chatView.clipsToBounds = true
        chatView.layer.masksToBounds = false
        chatView.layer.cornerRadius = 6
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
