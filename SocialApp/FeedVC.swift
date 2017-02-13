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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
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
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(withIdentifier: "PostCell") as! PostCell
    }
}
