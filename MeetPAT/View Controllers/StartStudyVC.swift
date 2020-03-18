//
//  StartStudyVC.swift
//  Appceptability (Realm Cloud)
//
//  Created by Neel Desai on 09/03/2020.
//  Copyright © 2020 Neel Desai. All rights reserved.
//

import UIKit

class StartStudyVC: UIViewController {
    
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
        Utilities.styleFilledButton(startButton)
    }
}
