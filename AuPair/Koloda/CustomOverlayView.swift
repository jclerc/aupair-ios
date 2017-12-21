//
//  CustomOverlayView.swift
//  AuPair
//
//  Created by Jonathan on 21/12/2017.
//  Copyright © 2017 Jonathan. All rights reserved.
//

import UIKit
import Koloda

private let overlayRightImageName = "overlay-like"
private let overlayLeftImageName = "overlay-skip"

class CustomOverlayView: OverlayView {
    @IBOutlet lazy var overlayImageView: UIImageView! = {
        [unowned self] in
        
        var imageView = UIImageView(frame: self.bounds)
        imageView.isOpaque = false
        imageView.backgroundColor = UIColor.clear
        self.isOpaque = false
        self.backgroundColor = UIColor.clear
        self.addSubview(imageView)
        
        return imageView
    }()
    
    override var overlayState: SwipeResultDirection?  {
        didSet {
            switch overlayState {
            case .left? :
                overlayImageView.image = UIImage(named: overlayLeftImageName)
            case .right? :
                overlayImageView.image = UIImage(named: overlayRightImageName)
            default:
                overlayImageView.image = nil
            }
            
        }
    }
}
