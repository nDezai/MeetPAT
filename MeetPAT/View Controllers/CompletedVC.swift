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
        
        ref.observe(.value, with: { snapshot in
            print(snapshot.value as Any)
        })
    }
    
    // MARK: - Table Functions
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return completedSurveys.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SurveyCell", for: indexPath) as! SurveyCell
        let survey = completedSurveys[indexPath.row]
        
        cell.surveyLabel.text = "\(survey.sampleID) - \(survey.participantID)"
        cell.surveyLabel.textAlignment = .center
        cell.backgroundColor = #colorLiteral(red: 0.004859850742, green: 0.09608627111, blue: 0.5749928951, alpha: 1)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        return indexPath
    }
   
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let survey = self.completedSurveys[indexPath.row]
        performSegue(withIdentifier: "goToStudy", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToStudy" {
            let breakdownVC = segue.destination as! StudyBreakdownVC
        }
        
    }
}
