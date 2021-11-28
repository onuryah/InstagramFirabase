//
//  FeedCell.swift
//  InstagramApp
//
//  Created by Ceren Çapar on 12.10.2021.
//

import UIKit
import Firebase

class FeedCell: UITableViewCell {
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var likeNumberLabel: UILabel!
    @IBOutlet weak var hiddenLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    @IBAction func likeButtonClicked(_ sender: Any) {
        let fireStoreDataBase = Firestore.firestore()
        
        if let likeCount = Int(likeNumberLabel.text!) {
            
            let likeStore = ["likes" : likeCount + 1] as [String : Any]
            
            fireStoreDataBase.collection("Posts").document(hiddenLabel.text!).setData(likeStore, merge: true)
        }
        
        
    }
    
}
