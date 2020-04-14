//
//  MainMenuTableViewController.swift
//  bluebird
//
//  Created by macbook on 1/22/20.
//  Copyright © 2020 bolattleubayev. All rights reserved.
//

import UIKit

class MainMenuTableViewController: UITableViewController {
    
    // MARK: - Varibles
    var document: bluebirdDocument? {
        didSet {
            updateUI()
        }
    }
    
    // keeping mpdel updated with the view
    var bluebird: bluebirdModel? 
    
    // MARK: - Outlets
    
    @IBOutlet weak var firstNameLabel: UILabel!
    
    @IBOutlet weak var lastNameLabel: UILabel!
    
    @IBOutlet weak var userImage: UIImageView!
    
    // MARK: - Functions and Actions
    
    @IBAction func close(_ sender: UIBarButtonItem) {
        presentingViewController?.dismiss(animated: true) {
            self.document?.close()
        }
    }
    
    // close button pressed "xmark" on edit user info screen
    @IBAction func unwindToHome(segue: UIStoryboardSegue) {
        //dismiss(animated: true, completion: nil)
    }
    
    private func updateUI() {
        bluebird = document?.bluebird
    }
    
    private func documentChanged() {
        // update the document's Model to match ours
        //document?.bluebird = bluebird
        // then tell the document that something has changed
        // so it will autosave at next best opportunity
        if document?.bluebird != nil {
            document?.updateChangeCount(.done)
        }
    }
    // MARK: - App Lifecycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateUI()
        if document?.documentState != .normal {
            document?.open { success in
                if success {
                    // set title
                    self.title = self.document?.localizedName
                    // set model to that the document is able to get opening the file
                    self.bluebird = self.document?.bluebird
                    self.firstNameLabel.text = self.document?.bluebird?.firstName ?? ""
                    self.lastNameLabel.text = self.document?.bluebird?.lastName ?? ""
                    if let availablePhoto = self.document?.bluebird?.userPhoto {
                        if availablePhoto != UIImage(named: "camera")?.pngData() {
                            self.userImage.image = UIImage(data: availablePhoto)
                        }
                    }
                }
            }
            documentChanged()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.backgroundView = UIImageView(image: UIImage(named: "backroundRandomImages"))
        tableView.backgroundView?.alpha = 0.3
        tableView.backgroundView?.contentMode = UIView.ContentMode.scaleAspectFill
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.largeTitleTextAttributes = [ NSAttributedString.Key.foregroundColor: UIColor(red: 0.0/255.0, green: 102.0/255.0, blue: 193.0/255.0, alpha: 1.0)]
        navigationController?.navigationBar.tintColor = UIColor(red: 0.0/255.0, green: 102.0/255.0, blue: 193.0/255.0, alpha: 1.0)
        
        NotificationCenter.default.addObserver(self, selector: #selector(reloadLabels), name: NSNotification.Name(rawValue: "reloadLabels"), object: nil)
        
        updateUI()
    }
    
    @objc func reloadLabels(notification: NSNotification){
        firstNameLabel.text = document?.bluebird?.firstName ?? ""
        lastNameLabel.text = document?.bluebird?.lastName ?? ""
        if let availablePhoto = document?.bluebird?.userPhoto {
            if availablePhoto != UIImage(named: "camera")?.pngData() {
                userImage.image = UIImage(data: availablePhoto)
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        documentChanged()
    }
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toEditCredentials" {
            if let destination = segue.destination.contents as? EditUserInfoTableViewController {
                destination.document = document
                print("sending doc to edit credentials")
            }
        } else if segue.identifier == "toRevealCredentials" {
            if let destination = segue.destination.contents as? ShowUserInfoTableViewController {
                destination.document = document
                print("sending doc to show credentials")
            }
        } else if segue.identifier == "toEditNotes" {
            if let destination = segue.destination.contents as? NotesViewController {
                destination.document = document
                print("sending doc to notes")
            }
        } else if segue.identifier == "toMMPI" {
            if let barDestination = segue.destination as? UITabBarController {
                if let questionsDestination = barDestination.viewControllers?[0] as? MMPIQuestionsViewController{
                    questionsDestination.document = document
                    questionsDestination.isContinuingUnfinishedTest = false
                    
                    print("sending doc to questions")
                }
                if let tScoresDestination = barDestination.viewControllers?[1] as? MMPITScoresInsertTableViewController{
                    tScoresDestination.document = document
                    print("sending doc to tScores")
                }
                if let questionsDestination = barDestination.viewControllers?[2] as? MMPIHistoryTableViewController{
                    questionsDestination.document = document
                    print("sending doc to history")
                }
            }
        } else if segue.identifier == "toTSI" {
            if let barDestination = segue.destination as? UITabBarController {
                
                if let questionsDestination = barDestination.viewControllers?[0] as? TSIHistoryTableViewController{
                    questionsDestination.document = document
                    print("sending doc to tsi history")
                }
                
                if let scoresDestination = barDestination.viewControllers?[1] as? TSIScoresInsertTableViewController{
                    scoresDestination.document = document
                    print("sending doc to tsi scores")
                }
            }
        }
    }
}
