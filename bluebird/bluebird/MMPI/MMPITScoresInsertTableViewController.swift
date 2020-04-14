//
//  MMPITScoresInsertTableViewController.swift
//  bluebird
//
//  Created by macbook on 1/30/20.
//  Copyright © 2020 bolattleubayev. All rights reserved.
//

import UIKit

class MMPITScoresInsertTableViewController: UITableViewController {
    
    var document: bluebirdDocument?
    var bluebird: bluebirdModel?
    var tScores = [[String:Int]]()
    
    @IBOutlet weak var lTextField: RoundedTextField!
    @IBOutlet weak var fTextField: RoundedTextField!
    @IBOutlet weak var kTextField: RoundedTextField!
    
    @IBOutlet weak var oneTextField: RoundedTextField!
    @IBOutlet weak var twoTextField: RoundedTextField!
    @IBOutlet weak var threeTextField: RoundedTextField!
    @IBOutlet weak var fourTextField: RoundedTextField!
    @IBOutlet weak var fiveTextField: RoundedTextField!
    @IBOutlet weak var sixTextField: RoundedTextField!
    @IBOutlet weak var sevenTextField: RoundedTextField!
    @IBOutlet weak var eightTextField: RoundedTextField!
    @IBOutlet weak var nineTextField: RoundedTextField!
    @IBOutlet weak var zeroTextField: RoundedTextField!
    
    @IBAction func interpretButtonPressed(_ sender: UIButton) {
        
        if lTextField.text == "" {
            
        } else {
            
        }
        var tScoresDictionary = [String:Int]() {
            didSet {
                
                // new session addition or current session update mechanics
                // if current session number is bigger than number of
                // arrays in document, then add current session values
                // or if current session is updating, replace its previous version
                // also update last modified variable
                
                if document?.bluebird != nil {
                    //print("\(currentSessionNumber) == \(answersArray.count)")
                    if tScores.count == 0 {
                        tScores.append(tScoresDictionary)
                    } else {
                        tScores[tScores.count - 1] = tScoresDictionary
                    }
                }
                
            }
        }
        
        tScoresDictionary["L"] = Int(lTextField.text!) ?? 0
        tScoresDictionary["F"] = Int(fTextField.text!) ?? 0
        tScoresDictionary["K"] = Int(kTextField.text!) ?? 0
        
        tScoresDictionary["1"] = Int(oneTextField.text!) ?? 0
        tScoresDictionary["2"] = Int(twoTextField.text!) ?? 0
        tScoresDictionary["3"] = Int(threeTextField.text!) ?? 0
        tScoresDictionary["4"] = Int(fourTextField.text!) ?? 0
        tScoresDictionary["5"] = Int(fiveTextField.text!) ?? 0
        tScoresDictionary["6"] = Int(sixTextField.text!) ?? 0
        tScoresDictionary["7"] = Int(sevenTextField.text!) ?? 0
        tScoresDictionary["8"] = Int(eightTextField.text!) ?? 0
        tScoresDictionary["9"] = Int(nineTextField.text!) ?? 0
        tScoresDictionary["0"] = Int(zeroTextField.text!) ?? 0
        
        tScores = document?.bluebird?.tScoresStorage ?? []
        tScores.append(tScoresDictionary)
        print("\(tScores)")
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
                                            tScoresStorage: tScores,
                                            tsiStorage: document?.bluebird?.tsiStorage ?? [],
                                            tsiTestDates: document?.bluebird?.tsiTestDates ?? [],
                                            tsiScoresStorage: document?.bluebird?.tsiScoresStorage ?? [])
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "toPlotMMPI" {
            if let destination = segue.destination.contents as? MMPIPlotViewController {
                destination.document = document
                if let indexOfTest = document?.bluebird?.tScoresStorage.count {
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
