//
//  SignInVC.swift
//  SocialApp
//
//  Created by Anze Vavken on 10/02/2017.
//  Copyright © 2017 VavkenApps. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import FBSDKCoreKit
import Firebase
import SwiftKeychainWrapper

class SignInVC: UIViewController {
    
    @IBOutlet weak var emailText: FancyField!
    @IBOutlet weak var passwordText: FancyField!
    

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        if let _ = KeychainWrapper.standard.string(forKey: KEY_UID) {
            print("ANŽE: foundKey")
            performSegue(withIdentifier: "goToFeedVC", sender: nil)
        } else {
            print ("ANŽE: didnt found key")
        }
        
    }
    
    func firebaseAuth(_ credential: FIRAuthCredential) {
        FIRAuth.auth()?.signIn(with: credential, completion: { (user, error) in
            if error != nil {
                print("ANŽE: uneable to athenticate with firebase - \(error)")
            } else {
                print("ANŽE: athenticated with firebase")
                if let user = user {
                    let userData = ["provider": credential.provider]
                    self.signInComplete(id: user.uid, userData: userData)
                }
            }
        })
    }
    
    func signInComplete(id: String, userData: Dictionary<String, String>) {
        DataService.ds.createFirebaseDBUser(uid: id, userData: userData)
        let keychainresult = KeychainWrapper.standard.set(id, forKey: KEY_UID)
        print("ANŽE: Data saved to keychain \(keychainresult)")
        performSegue(withIdentifier: "goToFeedVC", sender: nil)
    }

    @IBAction func facebookBtnTapped(_ sender: Any) {
        
        let facebookLoginManager = FBSDKLoginManager()
        
        facebookLoginManager.logIn(withReadPermissions: ["email"], from: self) { (result, error) in
            if error != nil {
                print("ANŽE:uneable to authanticate with facebook - \(error)")
            } else if result?.isCancelled == true {
                print("ANŽE: user canceled authentication")
            } else {
                print("ANŽE: Succsesfully authenticated with facebook")
                let credential = FIRFacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
                self.firebaseAuth(credential)
            }
        }
        
        
    }
    
    @IBAction func signInBtnTapped(_ sender: Any) {
        
        if let email = emailText.text, let password = passwordText.text {
            FIRAuth.auth()?.signIn(withEmail: email, password: password, completion: { (user, error) in
                if error == nil {
                    print("ANŽE: email user authenticated with Firebase")
                    if let user = user {
                        print("ANŽE: came here")
                        let userData = ["provider": user.providerID]
                        self.signInComplete(id: user.uid, userData: userData)
                    }
                } else {
                    FIRAuth.auth()?.createUser(withEmail: email, password: password, completion: { (user, error) in
                        if error != nil {
                            print("ANŽE: Unable to authenticate with firebase using email")
                        } else {
                            print("ANŽE: Succsesfully authenticated with Firebase")
                            
                            if let user = user {
                                let userData = ["provider": user.providerID]
                                self.signInComplete(id: user.uid, userData: userData)
                            }
                        }
                    })
                }
            })
        }
    }
        
}
