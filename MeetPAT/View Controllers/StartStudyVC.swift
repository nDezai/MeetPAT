//
//  StartStudyVC.swift
//  Appceptability (Realm Cloud)
//
//  Created by Neel Desai on 09/03/2020.
//  Copyright © 2020 Neel Desai. All rights reserved.
//

import UIKit
import FirebaseAuth

class StartStudyVC: UIViewController {
    
    @IBAction func logOutPressed(_ sender: Any) {
        
        let alertController = UIAlertController(title: "Logout?", message: "Are you sure you want to logout?", preferredStyle: .alert);
        alertController.addAction(UIAlertAction(title: "Logout", style: .destructive, handler: {
            alert -> Void in
            do {
                try Auth.auth().signOut()
                if let viewController = self.storyboard?.instantiateViewController(withIdentifier: "LoginVC") {
                UIApplication.shared.keyWindow?.rootViewController = viewController
                self.dismiss(animated: true, completion: nil)
                }
            } catch {
                let alertController = UIAlertController(title: "Logout Error", message: error.localizedDescription, preferredStyle: .alert)
                let okayAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alertController.addAction(okayAction)
                self.present(alertController, animated: true, completion: nil)
                
                return
            }}))
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
    
    @IBOutlet weak var startButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpElement()
    }
    
    @IBAction func startPressed(_ sender: UIButton) {
    }
    
    // MARK: - Other Functions
    
    func setUpElement() {
        
        // Style the elements
        Utilities.surveyFilledButton(startButton)
    }
}
