//
//  HomeController.swift
//  AuPair
//
//  Created by Jonathan on 20/12/2017.
//  Copyright © 2017 Jonathan. All rights reserved.
//

import UIKit
import Koloda

class HomeController: UIViewController {
    @IBOutlet weak var kolodaView: KolodaView!

    var images = [UIImage]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        images.append(UIImage(named: "logo")!)
        images.append(UIImage(named: "paperplane")!)
        images.append(UIImage(named: "logo")!)
        images.append(UIImage(named: "paperplane")!)
        images.append(UIImage(named: "logo")!)
        images.append(UIImage(named: "paperplane")!)
        print("HomeController#viewDidLoad / img: \(images.count)")
        
        kolodaView.dataSource = self
        kolodaView.delegate = self
        
        kolodaView.layer.zPosition = 1
    }

}

extension HomeController: KolodaViewDelegate {
    func kolodaDidRunOutOfCards(_ koloda: KolodaView) {
        koloda.reloadData()
        print("KolodaViewDelegate#kolodaDidRunOutOfCards")
    }
    
    func koloda(_ koloda: KolodaView, didSelectCardAt index: Int) {
//        UIApplication.shared.openURL(URL(string: "https://yalantis.com/")!)
        print("KolodaViewDelegate#koloda, didSelectCartAt")
    }
}

extension HomeController: KolodaViewDataSource {
    
    func kolodaNumberOfCards(_ koloda:KolodaView) -> Int {
        print("KolodaViewDataSource#kolodaNumberOfCards / \(images.count)")
        return images.count
    }
    
    func kolodaSpeedThatCardShouldDrag(_ koloda: KolodaView) -> DragSpeed {
        print("KolodaViewDataSource#kolodaSpeedThatCardShouldDrag")
        return .fast
    }
    
    func koloda(_ koloda: KolodaView, viewForCardAt index: Int) -> UIView {
        print("KolodaViewDataSource#koloda, viewForCardAt / \(index < images.count ? "ok" : "empty")")

        let view = (Bundle.main.loadNibNamed("CardView", owner: self, options: nil)![0] as? CardView)!
//        let view =
        view.image = images[index]
        
        view.label.text = "\(index)"
        
        return view
    }
    
    func koloda(_ koloda: KolodaView, viewForCardOverlayAt index: Int) -> OverlayView? {
        print("KolodaViewDataSource#koloda, viewForCardOverlayAt")
        let x = Bundle.main.loadNibNamed("OverlayView", owner: self, options: nil)![0] as? OverlayView
        if x != nil {
            print("-> ok")
        } else {
            print("-> empty")
        }
        return x
    }
}

