//
//  bluebirdModel.swift
//  bluebird
//
//  Created by macbook on 1/22/20.
//  Copyright © 2020 bolattleubayev. All rights reserved.
//

import Foundation

struct bluebirdModel: Codable, Equatable {
    
    var userPhoto: Data
    var firstName: String
    var lastName: String
    var patronimicName: String
    var birthDay: String
    var birthMonth: String
    var birthYear: String
    var notes: String
    var lastModified: Date
    var isMale: Bool
    var mmpiStorage: [[Int: Int]]
    var mmpiTestDates: [Date]
    var tScoresStorage: [[String:Int]]
    var tsiStorage: [[Int: String]]
    var tsiTestDates: [Date]
    var tsiScoresStorage: [[String:Int]]
    
    // failable initializer, if it fails, the other initializer will take place
    init?(json: Data) {
        if let newValue = try? JSONDecoder().decode(bluebirdModel.self, from: json){
            self = newValue
        } else {
            return nil
        }
    }
    
    // getting JSON file, actually it is never going to fail, because all types are 100% codable
    var json: Data? {
        return try? JSONEncoder().encode(self)
    }
    
    init(userPhoto: Data,
         firstName: String,
         lastName: String,
         patronimicName: String,
         birthDay: String,
         birthMonth: String,
         birthYear: String,
         notes: String,
         lastModified: Date,
         isMale: Bool,
         mmpiStorage: [[Int: Int]],
         mmpiTestDates: [Date],
         tScoresStorage: [[String:Int]],
         tsiStorage: [[Int: String]],
         tsiTestDates: [Date],
         tsiScoresStorage: [[String:Int]]) {
        self.userPhoto = userPhoto
        self.firstName = firstName
        self.lastName = lastName
        self.patronimicName = patronimicName
        self.birthDay = birthDay
        self.birthMonth = birthMonth
        self.birthYear = birthYear
        self.notes = notes
        self.lastModified = lastModified
        self.isMale = isMale
        self.mmpiStorage = mmpiStorage
        self.mmpiTestDates = mmpiTestDates
        self.tScoresStorage = tScoresStorage
        self.tsiStorage = tsiStorage
        self.tsiTestDates = tsiTestDates
        self.tsiScoresStorage = tsiScoresStorage
    }
}
