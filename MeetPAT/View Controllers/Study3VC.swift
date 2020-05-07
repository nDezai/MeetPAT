//
//  Study3VC.swift
//  Appceptability (Realm Cloud)
//
//  Created by Neel Desai on 09/03/2020.
//  Copyright © 2020 Neel Desai. All rights reserved.
//

import UIKit

class Study3VC: UIViewController {
    
    @IBOutlet weak var finishButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.hidesBackButton = true
        setUpElements()
    }
    
    @IBAction func finishPressed(_ sender: UIButton) {
        if let viewController = self.storyboard?.instantiateViewController(withIdentifier: "StudyTabVC") {
        UIApplication.shared.keyWindow?.rootViewController = viewController
        self.dismiss(animated: true, completion: nil)
        }
    }
    
    // MARK: - Other Functions
    
    func setUpElements() {
        
        // Style the elements
        Utilities.surveyFilledButton(finishButton)
    }
    
}
