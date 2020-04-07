//
//  ConsentVC.swift
//  MeetPAT
//
//  Created by Neel Desai on 22/03/2020.
//  Copyright © 2020 Neel Desai. All rights reserved.
//

import UIKit
import ResearchKit
import FirebaseAuth

class ConsentVC: UIViewController, ORKTaskViewControllerDelegate {
    
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
    
    
    @IBOutlet weak var consentButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpElement()
    }
    
    // MARK: - Consent Form Design
    
    let ConsentReviewStepIdentifier = "ConsentReviewStep"
    let consentDocument = ORKConsentDocument()
    
    @IBAction func consentPressed(_ sender: Any) {
        consentDocument.title = "Study X Consent Form"
        
        let section1 = ORKConsentSection(type: .overview)
        section1.summary = NSLocalizedString("Overview Summary", comment: "")
        section1.content = NSLocalizedString("Welcome to Study X. Within this study you will be asked to provide some simple information about yourself, take a sample and assess the sample through answering 10 questions.", comment: "")
        
        let section2 = ORKConsentSection(type: .dataGathering)
        section2.summary = NSLocalizedString("Data Gathering Summary", comment: "")
        section2.content = NSLocalizedString("The data gathered will be used by the research team to improve the properties of the sample you tried today. This data will be stored in a secure cloud database, only accessible to those in the research team.", comment: "")
        
        let section3 = ORKConsentSection(type: .dataUse)
        section3.summary = NSLocalizedString("Data Use Summary", comment: "")
        section3.content = NSLocalizedString("The data gathered will be used by the research team to improve the properties of the sample you tried today. This data will be stored in a secure cloud database, only accessible to those in the research team.", comment: "")
        
        let section4 = ORKConsentSection(type: .privacy)
        section4.summary = NSLocalizedString("Privacy Summary", comment: "")
        section4.content = NSLocalizedString("Your privacy will be maintained at all times.", comment: "")
        
        let section5 = ORKConsentSection(type: .timeCommitment)
        section5.summary = NSLocalizedString("Time Commitment Summary", comment: "")
        section5.content = NSLocalizedString("You will be required to commit 5-10 minutes of your time.", comment: "")
        
        let section6 = ORKConsentSection(type: .studySurvey)
        section6.summary = NSLocalizedString("Survey Summary", comment: "")
        section6.content = NSLocalizedString("The survey will use a simple sliding scale with faces to assess the sample you have tried today.", comment: "")
        
        let section7 = ORKConsentSection(type: .withdrawing)
        section7.summary = NSLocalizedString("Withdrawal Summary", comment: "")
        section7.content = NSLocalizedString("If you would like to withdraw at anytime, please do let us know. Your data will also be removed from the cloud database and not included in future studies", comment: "")
        
        consentDocument.sections = [section1, section2, section4, section3, section5, section6, section7]
        
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_GB")
        dateFormatter.dateFormat = "dd.MM.YYYY"
        let tempDate = dateFormatter.string(from: date)
        print(tempDate)
        consentDocument.addSignature(ORKConsentSignature(forPersonWithTitle: "Participant", dateFormatString: tempDate, identifier: "ConsentDocumentParticipantSignature"))
        
        var steps = [ORKStep]()
        
        let visualConsentStep = ORKVisualConsentStep(identifier: "VisualConsentStep", document: consentDocument)
        steps += [visualConsentStep]
        
        let signature = consentDocument.signatures!.first
        
        let reviewConsentStep = ORKConsentReviewStep(identifier: "ConsentReviewStep", signature: signature, in: consentDocument)
        reviewConsentStep.title = "Named Consent"
        reviewConsentStep.text = "Please provide your first and last name to confirm your consent in the study."
        reviewConsentStep.reasonForConsent = "Consent to join study"
        steps += [reviewConsentStep]
        
        //    let sharingStep = ORKConsentSharingStep(identifier: "SharingStep")
        //    sharingStep.title = "Sharing Options"
        //    sharingStep.text = "Institutions and its partners will receive your survey data following your participation of this study. Sharing your coded study data more broadly (without your personal information) may benefit this and future studies."
        //
        //    steps += [sharingStep]
        
        let completionStep = ORKCompletionStep(identifier: "CompletionStep")
        completionStep.title = NSLocalizedString("Thank you.", comment: "")
        completionStep.text = NSLocalizedString("Your consent has been noted. Please continue onto the survey.", comment: "")
        steps += [completionStep]
        
        let orderedTask = ORKOrderedTask(identifier: "ConsentTask", steps: steps)
        let taskViewController = ORKTaskViewController(task: orderedTask, taskRun: nil)
        taskViewController.delegate = self
        
        present(taskViewController, animated: true, completion: nil)
    }
    
    // MARK: - Consent Form PDF
    func taskViewController(_ taskViewController: ORKTaskViewController, didFinishWith reason: ORKTaskViewControllerFinishReason, error: Error?) {
        if let signatureResult = taskViewController.result.stepResult(forStepIdentifier:
            "ConsentReviewStep")?.firstResult as? ORKConsentSignatureResult {
            if signatureResult.consented {
                var fName = " "
                var lName = " "
                if let uFNAME = signatureResult.signature?.givenName {
                    fName = uFNAME
                }
                if let uLNAME = signatureResult.signature?.familyName {
                    lName = uLNAME
                }
                switch reason {
                case .completed:
                    if (taskViewController.result.stepResult(forStepIdentifier:"ConsentReviewStep")?.firstResult as? ORKConsentSignatureResult) != nil {
                        if let signatureResult = taskViewController.result.stepResult(forStepIdentifier: "ConsentReviewStep")?.firstResult as? ORKConsentSignatureResult {
                            signatureResult.apply(to: consentDocument)
                            consentDocument.makePDF { (data, error) -> Void in
                                print("This is studyID upon consent: \(fName) + \(lName)")
                                var docURL = (FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)).last
                                docURL = docURL?.appendingPathComponent(fName + "_" + lName + ".pdf")
                                print(docURL)
                                do {
                                    _ = PDFView()
                                    try data?.write(to: docURL!, options: .atomicWrite)
                                } catch {
                                    print("Failed to write")
                                }
                            }
                        }
                        // Dismiss the task’s view controller when the task finishes
                        taskViewController.dismiss(animated: true, completion: nil)
                    }
                case .saved:
                    print("Saved")
                case .discarded:
                    print("Discarded")
                case .failed:
                    print("Failed")
                default:
                    break
                }
            }
        }
    }
    
    // MARK: - Other Functions
    func setUpElement() {
        // Style the elements
        Utilities.styleFilledButton(consentButton)
    }
}
