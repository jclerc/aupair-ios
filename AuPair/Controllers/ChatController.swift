//
//  ChatController.swift
//  AuPair
//
//  Created by Jonathan on 22/12/2017.
//  Copyright © 2017 Jonathan. All rights reserved.
//

import UIKit

struct ChatPushData {
    var id: Int!
    var name: String!
    var location: String!
    var picture: UIImage!
}

struct ChatDiscussionData {
    var id: Int!
    var name: String!
    var date: String!
    var message: String!
    var picture: UIImage!
}

class ChatController: UIViewController {

    @IBOutlet weak var chatPushCollection: UICollectionView!
    var chatPushList = [ChatPushData]()
    
    @IBOutlet weak var chatDiscussionTable: UITableView!
    var chatDiscussionList = [ChatDiscussionData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupChatPush()
        setupChatDiscussion()
    }
    
    @IBAction func unwindToChat(sender: UIStoryboardSegue) {}
    
    private func loadChat(of id: Int, name: String) {
        print("Loading conversation #\(id)")
        if let view = storyboard?.instantiateViewController(withIdentifier: "DiscussionController") as? DiscussionController {
            view.name = name
            present(view, animated: true, completion: nil)
        }
    }
    
    private func setupChatPush() {
        chatPushList.append(ChatPushData(id: 1, name: "Famille Wursten", location: "Allemagne", picture: UIImage(named: "cp-1")))
        chatPushList.append(ChatPushData(id: 2, name: "Famille Johnson", location: "État-Unis", picture: UIImage(named: "cp-2")))
        chatPushList.append(ChatPushData(id: 3, name: "Famille Francisque", location: "France", picture: UIImage(named: "cp-3")))

        chatPushCollection.delegate = self
        chatPushCollection.dataSource = self
    }
    
    private func setupChatDiscussion() {
        for i in 1...3 {
            chatDiscussionList.append(ChatDiscussionData(id: 3*i + i, name: "Famille Miguelo", date: "hier à 13:28", message: "Yes we have a dog and he is really cute", picture: UIImage(named: "cc-1")))
            chatDiscussionList.append(ChatDiscussionData(id: 3*i + i, name: "Famille Robuzon", date: "mardi à 20:19", message: "Of course you will have access to the bathroom!", picture: UIImage(named: "cc-2")))
            chatDiscussionList.append(ChatDiscussionData(id: 3*i + i, name: "Famille Cartelo", date: "lundi à 15:32", message: "I’ll be happy to discuss with you, but I'm sick at the moment...", picture: UIImage(named: "cc-3")))
        }
        
        chatDiscussionTable.delegate = self
        chatDiscussionTable.dataSource = self
    }
}

extension ChatController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let data = chatPushList[indexPath.row]
        loadChat(of: data.id, name: data.name)
    }
}

extension ChatController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return chatPushList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ChatPushCell", for: indexPath) as! ChatPushCell
        let data = chatPushList[indexPath.row]
        
        cell.nameLabel.text = data.name
        cell.locationLabel.text = data.location
        cell.cellView.backgroundColor = UIColor(patternImage: data.picture)
        
        return cell
    }
}

extension ChatController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let data = chatDiscussionList[indexPath.row]
        loadChat(of: data.id, name: data.name)
    }
}

extension ChatController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chatDiscussionList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChatDiscussionCell", for: indexPath) as! ChatDiscussionCell
        let data = chatDiscussionList[indexPath.row]
        
        cell.nameLabel.text = data.name
        cell.dateLabel.text = data.date
        cell.messageLabel.text = data.message
        cell.pictureImage.image = data.picture
        
        return cell
    }
}
