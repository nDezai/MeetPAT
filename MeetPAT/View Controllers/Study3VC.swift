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
        let switchViewController = self.navigationController?.viewControllers[2] as! StudyTabVC
        self.navigationController?.popToViewController(switchViewController, animated: true)
    }
    
    // MARK: - Other Functions
    
    func setUpElements() {
        
        // Style the elements
        Utilities.styleFilledButton(finishButton)
    }
    
}
