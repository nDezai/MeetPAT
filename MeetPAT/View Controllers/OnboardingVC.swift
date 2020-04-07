//
//  OnboardingVC.swift
//  MeetPAT
//
//  Created by Neel Desai on 06/04/2020.
//  Copyright © 2020 Neel Desai. All rights reserved.
//

import UIKit

class OnboardingVC: UIViewController, OnboardingPageVCDelegate {
    
    var onboardingPageVC: OnboardingPageVC?
    
    @IBOutlet var pageControl: UIPageControl!
    @IBOutlet var nextButton: UIButton! {
        didSet {
            nextButton.layer.cornerRadius = 25.0
            nextButton.layer.masksToBounds = true
        }
    }
    @IBOutlet var skipButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    // MARK: - Button Functions
    
    @IBAction func nextButtonTapped(sender: UIButton) {
        if let index = onboardingPageVC?.currentIndex {
            switch index {
            case 0...1:
                onboardingPageVC?.forwardPage()
                
            case 2:
//                UserDefaults.standard.set(true, forKey: "hasViewedWalkthrough")
                dismiss(animated: true, completion: nil)
                
            default: break
                
            }
        }
        
        updateUI()
    }
    
    @IBAction func skipButtonTapped(sender: UIButton) {
//        UserDefaults.standard.set(true, forKey: "hasViewedWalkthrough")
        dismiss(animated: true, completion: nil)
    }
    
    func updateUI() {
        if let index = onboardingPageVC?.currentIndex {
            switch index {
                
            case 0...1:
                nextButton.setTitle("Next", for: .normal)
                skipButton.isHidden = false
                
            case 2:
                nextButton.setTitle("Get Started", for: .normal)
                skipButton.isHidden = true
                
            default: break
                
            }
            
            pageControl.currentPage = index
        }
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination
        if let pageViewController = destination as? OnboardingPageVC {
            onboardingPageVC = pageViewController
            onboardingPageVC?.onboardingDelegate = self
        }
    }
    
    // MARK: - OnboardingPageVCDelegate Method
    
    func didUpdatePageIndex(currentIndex: Int) {
        updateUI()
    }
}
