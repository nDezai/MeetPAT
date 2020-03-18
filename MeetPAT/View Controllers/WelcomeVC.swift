//
//  WelcomeVC.swift
//  MeetPAT
//
//  Created by Neel Desai on 18/03/2020.
//  Copyright © 2020 Neel Desai. All rights reserved.
//

import UIKit

class WelcomeVC: UIViewController {
    
    @IBOutlet weak var continueButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpElement()
    }
    // MARK: - Other Functions
    
    func setUpElement() {
        
        // Style the elements
        Utilities.styleFilledButton(continueButton)
    }
}
