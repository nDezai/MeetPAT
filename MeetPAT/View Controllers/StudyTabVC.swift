//
//  StudyTabVC.swift
//  MeetPAT
//
//  Created by Neel Desai on 18/03/2020.
//  Copyright © 2020 Neel Desai. All rights reserved.
//

import UIKit
import FirebaseAuth

class StudyTabVC: UITabBarController {
    
    @IBOutlet weak var logOutButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.hidesBackButton = true
    }
    
    @IBAction func logOutPressed(_ sender: Any) {
        
        let alertController = UIAlertController(title: "Logout?", message: "Are you sure you want to logout?", preferredStyle: .alert);
        alertController.addAction(UIAlertAction(title: "Logout", style: .destructive, handler: {
            alert -> Void in
            do {
                try Auth.auth().signOut()
                self.navigationController?.popToRootViewController(animated: true)
            } catch let signOutError as NSError {
                print("Error signing out: @%", signOutError)
            }}))
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
}
