//
//  StudyScrollVC.swift
//  Appceptability (Realm Cloud)
//
//  Created by Neel Desai on 12/03/2020.
//  Copyright © 2020 Neel Desai. All rights reserved.
//

import UIKit
import Firebase

class StudyScrollVC: UIViewController, UIScrollViewDelegate {
    
    // MARK: Constants
    let endStudy = "ScrollToStudy3"
    
    // MARK: Properties
    var completedSurveys: [CompletedSurveys] = []
    var user: User!
    let ref = Database.database().reference(withPath: "Completed-Surveys")
    let usersRef = Database.database().reference(withPath: "Online")
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var idTF: UITextField!
    @IBOutlet weak var sampleTF: UITextField!
    @IBOutlet weak var ageTF: UITextField!
    @IBOutlet weak var countryTF: UITextField!
    
    @IBOutlet weak var iFeelSlider: UISlider!
    @IBOutlet weak var aFeelSlider: UISlider!
    @IBOutlet weak var gritSlider: UISlider!
    @IBOutlet weak var iTasteSlider: UISlider!
    @IBOutlet weak var aTasteSlider: UISlider!
    @IBOutlet weak var iSweetSlider: UISlider!
    @IBOutlet weak var aSweetSlider: UISlider!
    @IBOutlet weak var flavourSlider: UISlider!
    @IBOutlet weak var textureSlider: UISlider!
    @IBOutlet weak var overallSlider: UISlider!
    
    @IBOutlet weak var saveButton: UIButton!
    
    // MARK: - Views
    
    override func viewWillAppear(_ animated: Bool) {
        resetSlider()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        iFeelSlider.addTarget(self, action: #selector(iFeelSliderChanged), for: UIControl.Event.valueChanged)
        aFeelSlider.addTarget(self, action: #selector(aFeelSliderChanged), for: UIControl.Event.valueChanged)
        gritSlider.addTarget(self, action: #selector(gritSliderChanged), for: UIControl.Event.valueChanged)
        iTasteSlider.addTarget(self, action: #selector(iTasteSliderChanged), for: UIControl.Event.valueChanged)
        aTasteSlider.addTarget(self, action: #selector(aTasteSliderChanged), for: UIControl.Event.valueChanged)
        iSweetSlider.addTarget(self, action: #selector(iSweetSliderChanged), for: UIControl.Event.valueChanged)
        aSweetSlider.addTarget(self, action: #selector(aSweetSliderChanged), for: UIControl.Event.valueChanged)
        flavourSlider.addTarget(self, action: #selector(flavourSliderChanged), for: UIControl.Event.valueChanged)
        textureSlider.addTarget(self, action: #selector(textureSliderChanged), for: UIControl.Event.valueChanged)
        overallSlider.addTarget(self, action: #selector(overallSliderChanged), for: UIControl.Event.valueChanged)
        
        scrollView.delegate = self
        
        let cancelButton = UIBarButtonItem()
        cancelButton.title = "Cancel"
        cancelButton.style = .done
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = cancelButton

        setUpElements()
        
        Auth.auth().addStateDidChangeListener { auth, user in
            guard let user = user else { return }
            self.user = User(authData: user)
        }
    }
    
    // MARK: - IBActions
    
    @IBAction func iFeelSliderChanged(_ sender: UISlider) {
        // let iFeelValue = Int(iFeelSlider.value)
        // iFeelTF.text = "\(iFeelValue)"
    }
    
    @IBAction func aFeelSliderChanged(_ sender: UISlider) {
        // let aFeelValue = Int(aFeelSlider.value)
        // aFeelTF.text = "\(aFeelValue)"
    }
    
    @IBAction func gritSliderChanged(_ sender: UISlider) {
        // let gritValue = Int(gritSlider.value)
        // gritTF.text = "\(gritValue)"
    }
    
    @IBAction func iTasteSliderChanged(_ sender: UISlider) {
        // let iTasteValue = Int(iTasteSlider.value)
        // iTasteTF.text = "\(iTasteValue)"
    }
    
    @IBAction func aTasteSliderChanged(_ sender: UISlider) {
        // let aTasteValue = Int(aTasteSlider.value)
        // aTasteTF.text = "\(aTasteValue)"
    }
    
    @IBAction func iSweetSliderChanged(_ sender: UISlider) {
        // let iSweetValue = Int(iSweetSlider.value)
        // iSweetTF.text = "\(iSweetValue)"
    }
    
    @IBAction func aSweetSliderChanged(_ sender: UISlider) {
        // let aSweetValue = Int(aSweetSlider.value)
        // aSweetTF.text = "\(aSweetValue)"
    }
    
    @IBAction func flavourSliderChanged(_ sender: UISlider) {
        // let flavourValue = Int(flavourSlider.value)
        // flavourTF.text = "\(flavourValue)"
    }
    
    @IBAction func textureSliderChanged(_ sender: UISlider) {
        // let textureValue = Int(textureSlider.value)
        // textureTF.text = "\(textureValue)"
    }
    
    @IBAction func overallSliderChanged(_ sender: UISlider) {
        // let overallValue = Int(overallSlider.value)
        // overallTF.text = "\(overallValue)"
    }
    
    @IBAction func savePressed(_ sender: UIButton) {
        saveToFirebase()
    }
    
    // MARK: - Save to Google Firebase
    
    func saveToFirebase() {
        let participantID = idTF.text!
        let sampleID = sampleTF.text!
        let ageID = Int(ageTF.text!)!
        let countryID = countryTF.text!
        
        let iFeelID = Double(iFeelSlider.value)
        let aFeelID = Double(aFeelSlider.value)
        let gritID = Double(gritSlider.value)
        let iTasteID = Double(iTasteSlider.value)
        let aTasteID = Double(aTasteSlider.value)
        let iSweetID = Double(iSweetSlider.value)
        let aSweetID = Double(aSweetSlider.value)
        let flavourID = Double(flavourSlider.value)
        let textureID = Double(textureSlider.value)
        let overallID = Double(overallSlider.value)
        
        let completedSurveys = CompletedSurveys(addedByUser: self.user.email,
                                                participantID: participantID,
                                                sampleID: sampleID,
                                                ageID: ageID,
                                                countryID: countryID,
                                                iFeelID: iFeelID,
                                                aFeelID: aFeelID,
                                                gritID: gritID,
                                                iTasteID: iTasteID,
                                                aTasteID: aTasteID,
                                                iSweetID: iSweetID,
                                                aSweetID: aSweetID,
                                                flavourID: flavourID,
                                                textureID: textureID,
                                                overallID: overallID)
        
        let completedSurveysRef = self.ref.child("\(participantID.uppercased()) - \(sampleID.lowercased())")
        completedSurveysRef.setValue(completedSurveys.toAnyObject())
    }
    
    
    // MARK: - Other Functions
    
    func resetSlider() {
        // Reset sliders to 3 for ViewWillAppear
        iFeelSlider.value = 3
        aFeelSlider.value = 3
        gritSlider.value = 3
        iTasteSlider.value = 3
        aTasteSlider.value = 3
        iSweetSlider.value = 3
        aSweetSlider.value = 3
        flavourSlider.value = 3
        textureSlider.value = 3
        overallSlider.value = 3
    }
    
//    func alertAppear() {
//        let alertController = UIAlertController(title: "Finished?", message: "Are you sure you want to finish?", preferredStyle: .alert);
//        alertController.addAction(UIAlertAction(title: "Finish", style: .destructive, handler: {
//            alert -> Void in
//            self.performSegue(withIdentifier: self.endStudy, sender: nil)
//        }))
//        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
//        self.present(alertController, animated: true, completion: nil)
//    }
    
    func setUpElements() {
        // Style the elements
        Utilities.styleTextField(idTF)
        Utilities.styleTextField(sampleTF)
        Utilities.styleTextField(ageTF)
        Utilities.styleTextField(countryTF)
        Utilities.surveyFilledButton(saveButton)
    }
}
