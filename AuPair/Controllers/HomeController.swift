//
//  HomeController.swift
//  AuPair
//
//  Created by Jonathan on 20/12/2017.
//  Copyright © 2017 Jonathan. All rights reserved.
//

import UIKit
import Koloda
import Firebase

class HomeController: UIViewController {

    var ref: DatabaseReference!
    
    // koloda: the card system
    var cards = [[String: Any]]()
    @IBOutlet weak var kolodaView: KolodaView!
    @IBOutlet weak var kolodaLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = Database.database().reference()

        fetchData()

        // setup koloda
        kolodaView.dataSource = self
        kolodaView.delegate = self
        kolodaView.layer.zPosition = 1
        kolodaView.countOfVisibleCards = 3
    }
    
    private func fetchData() {
        // fetch data
        ref.child("users").observeSingleEvent(of: .value, with: { (snapshot) in
            // iterate in users
            for child in snapshot.children.allObjects as! [DataSnapshot] {
                let userUid = Auth.auth().currentUser?.uid
                // exclude current user from cards
                if child.key != userUid {
                    if let value = child.value as? [String: Any] {
                        // only families
                        if let type = value["type"] as? String, type == "family" {
                            self.cards.append(value)
                        }
                    }
                }
            }
            // data is now loaded!
            self.kolodaView.reloadData()
            self.kolodaLabel.text = "Rien pour le moment !"
        })
    }
}

extension HomeController: KolodaViewDelegate {
    // on swipe
    func koloda(_ koloda: KolodaView, didSwipeCardAt index: Int, in direction: SwipeResultDirection) {
        // get data
        let data = cards[index]
        
        if let family = data["family"] as? [String: Any] {
            // track event
            let location = family["location"];
            let matchType = direction == .right ? "Accepted" : "Declined"
            Analytics.logEvent("aupair_swipes_family", parameters: [
                "user_id": Auth.auth().currentUser?.uid ?? "none",
                "match_type": matchType,
                "family_location": location ?? "none"
            ])
        }
    }
    
    // update index
    func koloda(_ koloda: KolodaView, didShowCardAt index: Int) {
        amountLabel.text = "\(index + 1)/\(cards.count)"
    }
    
    // no transparency
    func kolodaShouldTransparentizeNextCard(_ koloda: KolodaView) -> Bool {
        return false
    }
}

extension HomeController: KolodaViewDataSource {
    func kolodaNumberOfCards(_ koloda:KolodaView) -> Int {
        return cards.count
    }
    
    func kolodaSpeedThatCardShouldDrag(_ koloda: KolodaView) -> DragSpeed {
        return .fast
    }
    
    func koloda(_ koloda: KolodaView, viewForCardAt index: Int) -> UIView {
        if let view = Bundle.main.loadNibNamed("CardView", owner: self, options: nil)?[0] as? CardView {
            // init view
            view.setData(kolodaView, cards[index])
            return view
        }
        print("ERROR: can't load CardView!")
        return UIView()
    }
    
    func koloda(_ koloda: KolodaView, viewForCardOverlayAt index: Int) -> OverlayView? {
        return Bundle.main.loadNibNamed("OverlayView", owner: self, options: nil)?[0] as? OverlayView
    }
}

