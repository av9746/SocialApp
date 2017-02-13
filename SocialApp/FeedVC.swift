//
//  FeedVC.swift
//  SocialApp
//
//  Created by Anze Vavken on 12/02/2017.
//  Copyright © 2017 VavkenApps. All rights reserved.
//

import UIKit
import SwiftKeychainWrapper
import Firebase

class FeedVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var posts: [Post] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        DataService.ds.REF_POST.observe(.value, with: {(snapshot) in
            
            self.posts = []
            
            if let snapshot = snapshot.children.allObjects as? [FIRDataSnapshot] {
                for snap in snapshot {
                    print("SNAP: \(snap)")
                    
                    if let postDict = snap.value as? Dictionary<String, AnyObject> {
                        let key = snap.key
                        let post = Post(postKey: key, postData: postDict)
                        self.posts.append(post)
                    }
                    
                }
            }
            self.tableView.reloadData()
        })
        
    }
    


    @IBAction func SignOutTapped(_ sender: Any) {
        let removeSuccsesfull = KeychainWrapper.standard.remove(key: KEY_UID)
        print("ANŽE:Keychain removed \(removeSuccsesfull)")
        try! FIRAuth.auth()?.signOut()
        dismiss(animated:true, completion: nil)
    }
}

extension FeedVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(withIdentifier: "PostCell") as! PostCell
    }
}
