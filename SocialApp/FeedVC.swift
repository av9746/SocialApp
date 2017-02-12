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

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }


    @IBAction func SignOutTapped(_ sender: Any) {
        let removeSuccsesfull = KeychainWrapper.standard.remove(key: KEY_UID)
        print("ANŽE:Keychain removed \(removeSuccsesfull)")
        try! FIRAuth.auth()?.signOut()
        dismiss(animated:true, completion: nil)
    }
}
