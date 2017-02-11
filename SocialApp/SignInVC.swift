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

class SignInVC: UIViewController {
    
    @IBOutlet weak var emailText: FancyField!
    @IBOutlet weak var passwordText: FancyField!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
    
    func firebaseAuth(_ credential: FIRAuthCredential) {
        FIRAuth.auth()?.signIn(with: credential, completion: { (user, error) in
            if error != nil {
                print("ANŽE: uneable to athenticate with firebase - \(error)")
            } else {
                print("ANŽE: athenticated with firebase")
            }
        })
    }
    
    @IBAction func signInBtnTapped(_ sender: Any) {
        
        if let email = emailText.text, let password = passwordText.text {
            FIRAuth.auth()?.signIn(withEmail: email, password: password, completion: { (user, error) in
                if error == nil {
                    print("ANŽE: email user authenticated with Firebase")
                } else {
                    FIRAuth.auth()?.createUser(withEmail: email, password: password, completion: { (user, error) in
                        if error != nil {
                            print("ANŽE: Unable to authenticate with firebase using email")
                            let alertcontroller = UIAlertController(title: "Oh no!", message: "Incorrect email or password, or you are already signed in with facebook", preferredStyle: .alert)
                            let defaultAction = UIAlertAction(title: "dismiss", style: .default, handler: nil)
                            alertcontroller.addAction(defaultAction)
                            self.present(alertcontroller, animated: true, completion: nil)
                        } else {
                            print("ANŽE: Succsesfully authenticated with Firebase")
                        }
                    })
                }
            })
        }
    }
    
}
