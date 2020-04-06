//
//  OnboardingPageVC.swift
//  MeetPAT
//
//  Created by Neel Desai on 06/04/2020.
//  Copyright © 2020 Neel Desai. All rights reserved.
//

import UIKit

protocol OnboardingPageVCDelegate: class {
    func didUpdatePageIndex(currentIndex: Int)
}

class OnboardingPageVC: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    var pageHeadings = ["MEDICINES", "COLLABORATION", "THE FUTURE"]
    var pageSubHeadings = ["Many aspects of an everyday medicine can limit it's use in certain patient populations. This is particularly true for those medicines in the paediatric and geriatric age groups.",
                           "UCL School of Pharmacy and GlaxoSmithKline have partnered together to create a novel data collection tool for acceptability measures of a medicinal product, utilising scientifically proven questions and measures.",
                            "Well informed drug product design will allow a greater number of patients to take the right medicine, at the right dose, at the right time. This approach will enable greater personalisation of an individual's future treatment."]
    var pageImages = ["Onboarding1", "Onboarding2", "Onboarding3"]
    
    var currentIndex = 0
    
    weak var onboardingDelegate: OnboardingPageVCDelegate?
    
    // MARK: - ViewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource = self
        delegate = self
        if let startingViewController = contentViewController(at: 0) {
            setViewControllers([startingViewController], direction: .forward, animated: true, completion: nil)
        }
    }
    
    // MARK: - UIPageViewControllerDataSource Methods
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        var index = (viewController as! OnboardingContentVC).index
        index -= 1
        return contentViewController(at: index)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        var index = (viewController as! OnboardingContentVC).index
        index += 1
        return contentViewController(at: index)
    }
    
    func contentViewController(at index: Int) -> OnboardingContentVC? {
        if index < 0 || index >= pageHeadings.count {
            return nil
        }
        
        let storyboard = UIStoryboard(name: "Onboarding", bundle: nil)
        if let pageContentViewController = storyboard.instantiateViewController(withIdentifier: "OnboardingContentVC") as? OnboardingContentVC {
            pageContentViewController.imageFile = pageImages[index]
            pageContentViewController.heading = pageHeadings[index]
            pageContentViewController.subHeading = pageSubHeadings[index]
            pageContentViewController.index = index
            
            return pageContentViewController
        }
        return nil
    }
    
    func forwardPage() {
        currentIndex += 1
        if let nextViewController = contentViewController(at: currentIndex) {
            setViewControllers([nextViewController], direction: .forward, animated: true, completion: nil)
        }
    }
    
    // MARK: - UIPageViewControllerDelegate Method
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        
        if completed {
            
            if let contentViewController = pageViewController.viewControllers?
                .first as? OnboardingContentVC {
                currentIndex = contentViewController.index
                onboardingDelegate?.didUpdatePageIndex(currentIndex: contentViewController.index)
            }
        }
    }
    
    
}
