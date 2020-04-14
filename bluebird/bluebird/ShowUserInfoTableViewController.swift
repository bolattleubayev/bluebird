//
//  ShowUserInfoTableViewController.swift
//  bluebird
//
//  Created by macbook on 1/22/20.
//  Copyright © 2020 bolattleubayev. All rights reserved.
//

import UIKit

class ShowUserInfoTableViewController: UITableViewController {
    
    var document: bluebirdDocument?
    
    @IBOutlet weak var firstNameLabel: UILabel! {
        didSet {
            if let firstName = document?.bluebird?.firstName {
                firstNameLabel.text = firstName
            }
        }
    }
    
    @IBOutlet weak var lastNameLabel: UILabel! {
        didSet {
            if let lastName = document?.bluebird?.lastName {
                lastNameLabel.text = lastName
            }
        }
    }
    
    @IBOutlet weak var patronimicNameLabel: UILabel! {
        didSet {
            if let patronimicName = document?.bluebird?.patronimicName {
                patronimicNameLabel.text = patronimicName
            }
        }
    }
    
    @IBOutlet weak var genderLabel: UILabel! {
        didSet {
            if let isMale = document?.bluebird?.isMale {
                if isMale {
                    genderLabel.text = "Мужской"
                } else {
                    genderLabel.text = "Женский"
                }
            }
        }
    }
    
    @IBOutlet weak var birthDateLabel: UILabel! {
        didSet {
            
            var day: String?
            var month: String?
            var year: String?
            
            if let birthDay = document?.bluebird?.birthDay {
                day = birthDay
            }
            
            if let birthMonth = document?.bluebird?.birthMonth {
                month = birthMonth
            }
            
            if let birthYear = document?.bluebird?.birthYear {
                year = birthYear
            }
            
            var outputString: String = ""
            
            if let unwrappedDay = day {
                outputString = unwrappedDay
            }
            
            if let unwrappedMonth = month {
                outputString += ("." + unwrappedMonth)
            }
            
            if let unwrappedYear = year {
                outputString += ("." + unwrappedYear)
            }
            
            if outputString != "" {
                birthDateLabel.text = outputString
            }
        }
    }
    
    @IBOutlet weak var notesTextView: UITextView! {
        didSet {
            if let notes = document?.bluebird?.notes {
                notesTextView.text = notes
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}
