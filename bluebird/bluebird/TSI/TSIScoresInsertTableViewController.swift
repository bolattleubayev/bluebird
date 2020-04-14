//
//  TSIScoresInsertTableViewController.swift
//  bluebird
//
//  Created by macbook on 2/6/20.
//  Copyright © 2020 bolattleubayev. All rights reserved.
//

import UIKit

class TSIScoresInsertTableViewController: UITableViewController {
    
    var document: bluebirdDocument?
    var bluebird: bluebirdModel?
    var tsiScores = [[String:Int]]()
    
    @IBOutlet weak var oneTextField: RoundedTextField!
    @IBOutlet weak var twoTextField: RoundedTextField!
    @IBOutlet weak var threeTextField: RoundedTextField!
    @IBOutlet weak var fourTextField: RoundedTextField!
    @IBOutlet weak var fiveTextField: RoundedTextField!
    @IBOutlet weak var sixTextField: RoundedTextField!
    @IBOutlet weak var sevenTextField: RoundedTextField!
    @IBOutlet weak var eightTextField: RoundedTextField!
    @IBOutlet weak var nineTextField: RoundedTextField!
    
    @IBAction func plotButtonPressed(_ sender: UIButton) {
        var scoresDictionary = [String:Int]() {
            didSet {
                
                // new session addition or current session update mechanics
                // if current session number is bigger than number of
                // arrays in document, then add current session values
                // or if current session is updating, replace its previous version
                // also update last modified variable
                
                if document?.bluebird != nil {
                    //print("\(currentSessionNumber) == \(answersArray.count)")
                    if tsiScores.count == 0 {
                        tsiScores.append(scoresDictionary)
                    } else {
                        tsiScores[tsiScores.count - 1] = scoresDictionary
                    }
                }
                
            }
        }
        
        
        scoresDictionary["1"] = Int(oneTextField.text!) ?? 0
        scoresDictionary["2"] = Int(twoTextField.text!) ?? 0
        scoresDictionary["3"] = Int(threeTextField.text!) ?? 0
        scoresDictionary["4"] = Int(fourTextField.text!) ?? 0
        scoresDictionary["5"] = Int(fiveTextField.text!) ?? 0
        scoresDictionary["6"] = Int(sixTextField.text!) ?? 0
        scoresDictionary["7"] = Int(sevenTextField.text!) ?? 0
        scoresDictionary["8"] = Int(eightTextField.text!) ?? 0
        scoresDictionary["9"] = Int(nineTextField.text!) ?? 0
        
        tsiScores = document?.bluebird?.tsiScoresStorage ?? []
        tsiScores.append(scoresDictionary)
        print("\(tsiScores)")
        document?.bluebird = bluebirdModel(userPhoto: document?.bluebird?.userPhoto ?? (UIImage(named: "camera")?.pngData())!,
                                           firstName: document?.bluebird?.firstName ?? "",
                                           lastName: document?.bluebird?.lastName ?? "",
                                           patronimicName: document?.bluebird?.patronimicName ?? "",
                                            birthDay: document?.bluebird?.birthDay ?? "",
                                            birthMonth: document?.bluebird?.birthMonth ?? "",
                                            birthYear: document?.bluebird?.birthYear ?? "",
                                            notes: document?.bluebird?.notes ?? "",
                                            lastModified: Date(),
                                            isMale: document?.bluebird?.isMale ?? true,
                                            mmpiStorage: document?.bluebird?.mmpiStorage ?? [],
                                            mmpiTestDates: document?.bluebird?.mmpiTestDates ?? [],
                                            tScoresStorage: document?.bluebird?.tScoresStorage ?? [],
                                            tsiStorage: document?.bluebird?.tsiStorage ?? [],
                                            tsiTestDates: document?.bluebird?.tsiTestDates ?? [],
                                            tsiScoresStorage: tsiScores)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "toPlotTSI" {
            if let destination = segue.destination.contents as? TSIPlotViewController {
                destination.document = document
                if let indexOfTest = document?.bluebird?.tsiScoresStorage.count {
                    if indexOfTest > 0 {
                        destination.testIndex =  indexOfTest - 1
                    }
                }
                destination.onlyTScoresAvailable = true
                print("sending doc to edit credentials")
            }
        }
    }
}
