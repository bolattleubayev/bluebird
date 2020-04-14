//
//  NotesViewController.swift
//  bluebird
//
//  Created by macbook on 1/24/20.
//  Copyright © 2020 bolattleubayev. All rights reserved.
//

import UIKit

class NotesViewController: UIViewController {
    
    var document: bluebirdDocument?
    
    @IBOutlet weak var notesTextView: UITextView! {
        didSet {
            if (document?.bluebird?.notes) != nil {
                notesTextView.text = ""
            }
        }
    }
    
    @IBAction func saveButtonClicked(_ sender: UIBarButtonItem) {
        print(notesTextView.text ?? "")
        document?.bluebird = bluebirdModel(userPhoto: document?.bluebird?.userPhoto ?? (UIImage(named: "camera")?.pngData())!,
                                           firstName: document?.bluebird?.firstName ?? "",
                                            lastName: document?.bluebird?.lastName ?? "",
                                            patronimicName: document?.bluebird?.patronimicName ?? "",
                                            birthDay: document?.bluebird?.birthDay ?? "",
                                            birthMonth: document?.bluebird?.birthMonth ?? "",
                                            birthYear: document?.bluebird?.birthYear ?? "",
                                            notes: (document?.bluebird?.notes ?? "") + "\n" + (notesTextView.text ?? ""),
                                            lastModified: Date(),
                                            isMale: document?.bluebird?.isMale ?? true,
                                            mmpiStorage: document?.bluebird?.mmpiStorage ?? [],
                                            mmpiTestDates: document?.bluebird?.mmpiTestDates ?? [],
                                            tScoresStorage: document?.bluebird?.tScoresStorage ?? [],
                                            tsiStorage: document?.bluebird?.tsiStorage ?? [],
                                            tsiTestDates: document?.bluebird?.tsiTestDates ?? [],
                                            tsiScoresStorage: document?.bluebird?.tsiScoresStorage ?? [])
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.largeTitleTextAttributes = [ NSAttributedString.Key.foregroundColor: UIColor(red: 0.0/255.0, green: 102.0/255.0, blue: 193.0/255.0, alpha: 1.0)]
        navigationController?.navigationBar.tintColor = UIColor(red: 0.0/255.0, green: 102.0/255.0, blue: 193.0/255.0, alpha: 1.0)
        
        navigationItem.title = "Заметки"
        self.title = "Заметки"
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
