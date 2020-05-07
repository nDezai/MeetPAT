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
        
        navigationController?.setNavigationBarHidden(true, animated: false)
        navigationItem.hidesBackButton = true
        setUpElements()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    // MARK: - Login into Study
    
    @IBAction func loginPressed(sender: UIButton) {
        
        guard
            let email = usernameTF.text, email != "",
            let password = passwordTF.text, password != ""
            else {
                
                let alertController = UIAlertController(title: "Login Error", message: "Both fields must not be blank.", preferredStyle: .alert)
                let okayAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alertController.addAction(okayAction)
                present(alertController, animated: true, completion: nil)
                
                return
        }
        
        Auth.auth().signIn(withEmail: email, password: password, completion: { (result, error) in
            
            if let error = error {
                let alertController = UIAlertController(title: "Login Error", message: error.localizedDescription, preferredStyle: .alert)
                let okayAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alertController.addAction(okayAction)
                self.present(alertController, animated: true, completion: nil)
                
                return
            }
            self.view.endEditing(true)
            
            if let viewController = self.storyboard?.instantiateViewController(withIdentifier: "StudyTabVC") {
                UIApplication.shared.keyWindow?.rootViewController = viewController
                self.dismiss(animated: true, completion: nil)
            }
        })
    }
    
    // MARK: - Registering Study
    
    @IBAction func registerPressed(sender: UIButton) {
        
        guard let email = usernameTF.text, email != "",
            let password = passwordTF.text, password != "" else {
                
                let alertController = UIAlertController(title: "Registration Error", message: "Please make sure you provide a study email address and password to complete the registration.", preferredStyle: .alert)
                let okayAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alertController.addAction(okayAction)
                present(alertController, animated: true, completion: nil)
                
                return
        }
        
        Auth.auth().createUser(withEmail: email, password: password, completion: { (result, error) in
            
            if let error = error {
                let alertController = UIAlertController(title: "Registration Error", message: error.localizedDescription, preferredStyle: .alert)
                let okayAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alertController.addAction(okayAction)
                self.present(alertController, animated: true, completion: nil)
                
                return
            }
            self.alertAppear()
            self.view.endEditing(true)
        })
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
