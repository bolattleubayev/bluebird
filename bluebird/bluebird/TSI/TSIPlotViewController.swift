//
//  TSIPlotViewController.swift
//  bluebird
//
//  Created by macbook on 2/6/20.
//  Copyright © 2020 bolattleubayev. All rights reserved.
//

import UIKit

class TSIPlotViewController: UIViewController {
    
    // MARK: - Variables
    
    var document: bluebirdDocument?
    var onlyTScoresAvailable = false
    var testIndex = 0
    
    private var finalL: Int = 0
    private var finalF: Int = 0
    private var finalK: Int = 0
    private var final1: Int = 0
    private var final2: Int = 0
    private var final3: Int = 0
    private var final4: Int = 0
    private var final5: Int = 0
    private var final6: Int = 0
    private var final7: Int = 0
    private var final8: Int = 0
    private var final9: Int = 0
    private var final0: Int = 0
    
    @IBOutlet weak var tsiPlotView: TSIPlotView!
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print(document?.bluebird)
        if let lastScoreNumber = document?.bluebird?.tsiScoresStorage.count {
            if let lastInsertedScore = document?.bluebird?.tsiScoresStorage[testIndex] {
                
                final1 = lastInsertedScore["1"] ?? 0
                final2 = lastInsertedScore["2"] ?? 0
                final3 = lastInsertedScore["3"] ?? 0
                final4 = lastInsertedScore["4"] ?? 0
                final5 = lastInsertedScore["5"] ?? 0
                final6 = lastInsertedScore["6"] ?? 0
                final7 = lastInsertedScore["7"] ?? 0
                final8 = lastInsertedScore["8"] ?? 0
                final9 = lastInsertedScore["9"] ?? 0
                
            }
        }
        
        tsiPlotView.plot1 = final1
        tsiPlotView.plot2 = final2
        tsiPlotView.plot3 = final3
        tsiPlotView.plot4 = final4
        tsiPlotView.plot5 = final5
        tsiPlotView.plot6 = final6
        tsiPlotView.plot7 = final7
        tsiPlotView.plot8 = final8
        tsiPlotView.plot9 = final9
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        tsiPlotView.plot1 = final1
        tsiPlotView.plot2 = final2
        tsiPlotView.plot3 = final3
        tsiPlotView.plot4 = final4
        tsiPlotView.plot5 = final5
        tsiPlotView.plot6 = final6
        tsiPlotView.plot7 = final7
        tsiPlotView.plot8 = final8
        tsiPlotView.plot9 = final9
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
