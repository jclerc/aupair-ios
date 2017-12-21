//
//  CustomOverlayView.swift
//  AuPair
//
//  Created by Jonathan on 21/12/2017.
//  Copyright © 2017 Jonathan. All rights reserved.
//

import UIKit
import Koloda

class CustomOverlayView: OverlayView {
    @IBOutlet lazy var overlayImageView: UIImageView! = {
        [unowned self] in
        
        // view as large as container
        var imageView = UIImageView(frame: self.bounds)
        // prevent white screen
        imageView.isOpaque = false
        imageView.backgroundColor = UIColor.clear
        self.isOpaque = false
        self.backgroundColor = UIColor.clear
        // add to view
        self.addSubview(imageView)
        
        return imageView
    }()
    
    override var overlayState: SwipeResultDirection?  {
        didSet {
            switch overlayState {
            case .left? :
                overlayImageView.image = UIImage(named: "overlay-skip")
            case .right? :
                overlayImageView.image = UIImage(named: "overlay-like")
            default:
                overlayImageView.image = nil
            }
            
        }
    }
}
