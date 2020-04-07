//
//  CompletedVC.swift
//  MeetPAT
//
//  Created by Neel Desai on 18/03/2020.
//  Copyright © 2020 Neel Desai. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class CompletedVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
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
    
    // MARK: Properties
    var completedSurveys: [CompletedSurveys] = []
    var user: User!
    let ref = Database.database().reference(withPath: "Completed-Surveys")
    let usersRef = Database.database().reference(withPath: "Online")
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var numberLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref.queryOrdered(byChild: "participantID").observe(.value, with: { snapshot in
            var newSurveys: [CompletedSurveys] = []
            for child in snapshot.children {
                if let snapshot = child as? DataSnapshot,
                    let completedSurveys = CompletedSurveys(snapshot: snapshot) {
                    newSurveys.append(completedSurveys)
                }
            }
            
            self.tableView.delegate = self
            self.tableView.dataSource = self
            self.tableView.register(SurveyCell.self, forCellReuseIdentifier: "SurveyCell")
            
            self.completedSurveys = newSurveys
            self.tableView.reloadData()
            self.numberLabel.text = "\(snapshot.childrenCount)"
        })
        
        Auth.auth().addStateDidChangeListener { auth, user in
            guard let user = user else { return }
            self.user = User(authData: user)
            
            let currentUserRef = self.usersRef.child(self.user.uid)
            currentUserRef.setValue(self.user.email)
            currentUserRef.onDisconnectRemoveValue()
        }
        
//        ref.observe(.value, with: { snapshot in
//            print(snapshot.value as Any)
//        })
    }
    
    // MARK: - Table Functions
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return completedSurveys.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SurveyCell", for: indexPath) as! SurveyCell
        let survey = completedSurveys[indexPath.row]
        
        cell.surveyLabel.text = "\(survey.participantID) - \(survey.sampleID)"
        cell.surveyLabel.textAlignment = .center
        cell.surveyLabel.font = UIFont.boldSystemFont(ofSize: 25)
        cell.backgroundColor = #colorLiteral(red: 0.3493356109, green: 0.8548207879, blue: 0.6642559171, alpha: 1)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        return indexPath
    }
   
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
}
