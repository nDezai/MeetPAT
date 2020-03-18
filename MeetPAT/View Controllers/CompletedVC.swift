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

class CompletedVC: UIViewController {

        // MARK: Properties
        var completedSurveys: [CompletedSurveys] = []
        var user: User!
        let ref = Database.database().reference(withPath: "Completed-Surveys")
        let usersRef = Database.database().reference(withPath: "Online")
        
        let tableView = UITableView()
        
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
            let cell = tableView.dequeueReusableCell(withIdentifier: "SurveyCell", for: indexPath)
            let survey = completedSurveys[indexPath.row]
            
            cell.textLabel?.text = survey.participantID
            cell.textLabel?.text = survey.sampleID
            
            return cell
        }
        
        func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
            return indexPath
        }
        
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            performSegue(withIdentifier: "goToStudy", sender: self)
        }
    }
