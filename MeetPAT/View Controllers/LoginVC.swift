//
//  LoginVC.swift
//  MeetPAT
//
//  Created by Neel Desai on 18/03/2020.
//  Copyright © 2020 Neel Desai. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginVC: UIViewController {

        @IBOutlet weak var usernameTF: UITextField!
        @IBOutlet weak var passwordTF: UITextField!
        @IBOutlet weak var errorLabel: UILabel!
        @IBOutlet weak var loginButton: UIButton!
        @IBOutlet weak var registerButton: UIButton!
        
        let loginToTab = "LoginToTab"
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            navigationItem.hidesBackButton = true
            setUpElements()
        }
        
        @IBAction func loginPressed(_ sender: UIButton) {
            loginUser()
        }
        
        @IBAction func registerPressed(_ sender: UIButton) {
            registerUser()
        }
        
        // MARK: - Login Function
        
        func loginUser () {
            guard
              let email = usernameTF.text,
              let password = passwordTF.text,
              email.count > 0,
              password.count > 0
              else {
                return
            }

            Auth.auth().signIn(withEmail: email, password: password) { user, error in
              if let error = error, user == nil {
                let alert = UIAlertController(title: "Sign In Failed",
                                              message: error.localizedDescription,
                                              preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "OK", style: .default))
                
                self.present(alert, animated: true, completion: nil)
              }
            }
        }
        
        // MARK: - Register Function
        
        func registerUser() {
            let email = usernameTF.text
            let password = passwordTF.text
            
            Auth.auth().createUser(withEmail: email!, password: password!) { user, error in
              if error == nil {
                Auth.auth().signIn(withEmail: self.usernameTF.text!,
                                   password: self.passwordTF.text!)
                self.alertAppear()
              }
            }
        }
        
        // MARK: - Other Functions
        
        func alertAppear() {
            
            //Create alert
            let alert = UIAlertController(title: "Registration Success", message: "Your study has been successfully registered", preferredStyle: UIAlertController.Style.alert)
            
            //Add action
            alert.addAction(UIAlertAction(title: "Continue", style: UIAlertAction.Style.default, handler: nil))
            
            //Show alert
            self.present(alert, animated: true, completion: nil)
        }
        
        func setUpElements() {
            
            // Hide the Error Label
            errorLabel.alpha = 0
            
            Utilities.styleFilledButton(loginButton)
            Utilities.styleFilledButton(registerButton)
        }
        
    }
