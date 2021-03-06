//
//  Utilities.swift
//  Appceptability (Realm Cloud)
//
//  Created by Neel Desai on 09/03/2020.
//  Copyright © 2020 Neel Desai. All rights reserved.
//

import Foundation
import UIKit

class Utilities {
    
    static func styleTextField(_ textfield:UITextField) {
        
        // Create the bottom line
        let bottomLine = CALayer()
        
        bottomLine.frame = CGRect(x: 0, y: textfield.frame.height - 2, width: textfield.frame.width, height: 2)
        
        bottomLine.backgroundColor = UIColor.init(red: 255/255, green: 255/255, blue: 255/255, alpha: 1).cgColor
        
        // Remove border on text field
        textfield.borderStyle = .none
        
        // Add the line to the text field
        textfield.layer.addSublayer(bottomLine)
        
    }
    
    static func styleFilledButton(_ button:UIButton) {
        
        // Filled rounded corner style
        button.backgroundColor = #colorLiteral(red: 0.08534555882, green: 0.02815807238, blue: 0.2609079778, alpha: 1)
        button.layer.cornerRadius = 25.0
        button.tintColor = UIColor.white
    }
    
    static func surveyFilledButton(_ button:UIButton) {
        
        // Filled rounded corner style
        button.backgroundColor = #colorLiteral(red: 0.08534555882, green: 0.02815807238, blue: 0.2609079778, alpha: 1)
        button.layer.cornerRadius = 25.0
        button.tintColor = UIColor.black
    }
    
    static func styleHollowButton(_ button:UIButton) {
        
        // Hollow rounded corner style
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.cornerRadius = 25.0
        button.tintColor = UIColor.black
    }
    
    static func isPasswordValid(_ password : String) -> Bool {
        
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)[a-zA-Z\\d]{6,}")
        return passwordTest.evaluate(with: password)
    }
    
}

