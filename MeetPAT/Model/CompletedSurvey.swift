//
//  CompletedSurvey.swift
//  MeetPAT
//
//  Created by Neel Desai on 18/03/2020.
//  Copyright © 2020 Neel Desai. All rights reserved.
//

import Foundation
import Firebase

struct CompletedSurveys {
    
    let ref: DatabaseReference?
    let key: String
    let addedByUser: String
    var participantID: String
    var sampleID: String
    var ageID: Int = 0
    var countryID: String = ""
    var iFeelID: Double = 0.0
    var aFeelID: Double = 0.0
    var gritID: Double = 0.0
    var iTasteID: Double = 0.0
    var aTasteID: Double = 0.0
    var iSweetID: Double = 0.0
    var aSweetID: Double = 0.0
    var flavourID: Double = 0.0
    var textureID: Double = 0.0
    var overallID: Double = 0.0
    // var created: Date = Date()
    
    init(addedByUser: String, participantID: String, sampleID: String, ageID: Int, countryID: String, iFeelID: Double, aFeelID: Double, gritID: Double, iTasteID: Double, aTasteID: Double, iSweetID: Double, aSweetID: Double, flavourID: Double, textureID: Double, overallID: Double, key: String = "") {
        self.ref = nil
        self.key = key
        self.addedByUser = addedByUser
        self.participantID = participantID
        self.sampleID = sampleID
        self.ageID = ageID
        self.countryID = countryID
        self.iFeelID = iFeelID
        self.aFeelID = aFeelID
        self.gritID = gritID
        self.iTasteID = iTasteID
        self.aTasteID = aTasteID
        self.iSweetID = iSweetID
        self.aSweetID = aSweetID
        self.flavourID = flavourID
        self.textureID = textureID
        self.overallID = overallID
        // self.created = created
    }
    
    init?(snapshot: DataSnapshot) {
        guard
            let value = snapshot.value as? [String: AnyObject],
            let addedByUser = value["addedByUser"] as? String,
            let participantID = value["participantID"] as? String,
            let sampleID = value["sampleID"] as? String,
            let ageID = value["ageID"] as? Int,
            let countryID = value["countryID"] as? String,
            let iFeelID = value["iFeelID"] as? Double,
            let aFeelID = value["aFeelID"] as? Double,
            let gritID = value["gritID"] as? Double,
            let iTasteID = value["iTasteID"] as? Double,
            let aTasteID = value["aTasteID"] as? Double,
            let iSweetID = value["iSweetID"] as? Double,
            let aSweetID = value["aSweetID"] as? Double,
            let flavourID = value["flavourID"] as? Double,
            let textureID = value["textureID"] as? Double,
            let overallID = value["overallID"] as? Double else {
                return nil
        }
        
        self.ref = snapshot.ref
        self.key = snapshot.key
        self.addedByUser = addedByUser
        self.participantID = participantID
        self.sampleID = sampleID
        self.ageID = ageID
        self.countryID = countryID
        self.iFeelID = iFeelID
        self.aFeelID = aFeelID
        self.gritID = gritID
        self.iTasteID = iTasteID
        self.aTasteID = aTasteID
        self.iSweetID = iSweetID
        self.aSweetID = aSweetID
        self.flavourID = flavourID
        self.textureID = textureID
        self.overallID = overallID
    }
    
    func toAnyObject() -> Any {
        return [
            "addedByUser": addedByUser,
            "participantID": participantID,
            "sampleID": sampleID,
            "ageID": ageID,
            "countryID": countryID,
            "iFeelID": iFeelID,
            "aFeelID": aFeelID,
            "gritID": gritID,
            "iTasteID": iTasteID,
            "aTasteID": aTasteID,
            "iSweetID": iSweetID,
            "aSweetID": aSweetID,
            "flavourID": flavourID,
            "textureID": textureID,
            "overallID": overallID
        ]
    }
}
