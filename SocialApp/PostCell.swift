//
//  PostCell.swift
//  SocialApp
//
//  Created by Anze Vavken on 13/02/2017.
//  Copyright © 2017 VavkenApps. All rights reserved.
//

import UIKit

class PostCell: UITableViewCell {
    
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var postImage: UIImageView!
    @IBOutlet weak var captionText: UITextView!
    @IBOutlet weak var likesLbl: UILabel!
    
    var post: Post!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func congigureCell(post: Post) {
        self.post = post
        self.captionText.text = post.caption
        self.likesLbl.text = "\(post.likes)"
    }
    
}
