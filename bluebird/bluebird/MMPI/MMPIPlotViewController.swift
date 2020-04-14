//
//  MMPIPlotViewController.swift
//  bluebird
//
//  Created by macbook on 1/26/20.
//  Copyright © 2020 bolattleubayev. All rights reserved.
//

import UIKit

class MMPIPlotViewController: UIViewController {
    
    // MARK: - Variables
    
    var document: bluebirdDocument?
    var onlyTScoresAvailable = false
    var testIndex = 0
    
    // MARK: - Outlets
    
    @IBOutlet weak var mmpiPlotView: MMPIPlotView!
    
    @IBOutlet weak var finishTestButton: UIButton!
    
    // MARK: - App Lifecycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        rawL = 0
        rawF = 0
        rawK = 0
        
        raw1 = 0
        raw2 = 0
        raw3 = 0
        raw4 = 0
        raw5 = 0
        raw6 = 0
        raw7 = 0
        raw8 = 0
        raw9 = 0
        raw0 = 0
        
        if !onlyTScoresAvailable {
            convertToRawScore()
            convertToT()
            
            if let numberOfAnsweredQuestions = document?.bluebird?.mmpiStorage[testIndex].count {
                print("answered \(numberOfAnsweredQuestions)")
                if numberOfAnsweredQuestions >= 377 {
                    finishTestButton.isHidden = true
                } else {
                    finishTestButton.isHidden = false
                }
            }
        } else {
            if let lastTScoreNumber = document?.bluebird?.tScoresStorage.count {
                if let lastInsertedTScore = document?.bluebird?.tScoresStorage[testIndex] {
                    
                    
                    finalL = lastInsertedTScore["L"] ?? 0
                    finalF = lastInsertedTScore["F"] ?? 0
                    finalK = lastInsertedTScore["K"] ?? 0
                    
                    final1 = lastInsertedTScore["1"] ?? 0
                    final2 = lastInsertedTScore["2"] ?? 0
                    final3 = lastInsertedTScore["3"] ?? 0
                    final4 = lastInsertedTScore["4"] ?? 0
                    final5 = lastInsertedTScore["5"] ?? 0
                    final6 = lastInsertedTScore["6"] ?? 0
                    final7 = lastInsertedTScore["7"] ?? 0
                    final8 = lastInsertedTScore["8"] ?? 0
                    final9 = lastInsertedTScore["9"] ?? 0
                    final0 = lastInsertedTScore["0"] ?? 0
                    
                    finishTestButton.isHidden = true
                }
            }
        }
        
        
        mmpiPlotView.isMale = (document?.bluebird?.isMale)!
        mmpiPlotView.plotL = finalL
        mmpiPlotView.plotF = finalF
        mmpiPlotView.plotK = finalK
        mmpiPlotView.plot0 = final0
        mmpiPlotView.plot1 = final1
        mmpiPlotView.plot2 = final2
        mmpiPlotView.plot3 = final3
        mmpiPlotView.plot4 = final4
        mmpiPlotView.plot5 = final5
        mmpiPlotView.plot6 = final6
        mmpiPlotView.plot7 = final7
        mmpiPlotView.plot8 = final8
        mmpiPlotView.plot9 = final9
        mmpiPlotView.plot0 = final0
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        rawL = 0
        rawF = 0
        rawK = 0
        
        raw1 = 0
        raw2 = 0
        raw3 = 0
        raw4 = 0
        raw5 = 0
        raw6 = 0
        raw7 = 0
        raw8 = 0
        raw9 = 0
        raw0 = 0
        
        if !onlyTScoresAvailable {
            convertToRawScore()
            convertToT()
        } else {
            if let lastTScoreNumber = document?.bluebird?.tScoresStorage.count {
                if let lastInsertedTScore = document?.bluebird?.tScoresStorage[testIndex] {
                    
                    finalL = lastInsertedTScore["L"] ?? 0
                    finalF = lastInsertedTScore["F"] ?? 0
                    finalK = lastInsertedTScore["K"] ?? 0
                    
                    final1 = lastInsertedTScore["1"] ?? 0
                    final2 = lastInsertedTScore["2"] ?? 0
                    final3 = lastInsertedTScore["3"] ?? 0
                    final4 = lastInsertedTScore["4"] ?? 0
                    final5 = lastInsertedTScore["5"] ?? 0
                    final6 = lastInsertedTScore["6"] ?? 0
                    final7 = lastInsertedTScore["7"] ?? 0
                    final8 = lastInsertedTScore["8"] ?? 0
                    final9 = lastInsertedTScore["9"] ?? 0
                    final0 = lastInsertedTScore["0"] ?? 0
                    
                    finishTestButton.isHidden = true
                }
            }
        }
        
        mmpiPlotView.isMale = (document?.bluebird?.isMale)!
        mmpiPlotView.plotL = finalL
        mmpiPlotView.plotF = finalF
        mmpiPlotView.plotK = finalK
        mmpiPlotView.plot0 = final0
        mmpiPlotView.plot1 = final1
        mmpiPlotView.plot2 = final2
        mmpiPlotView.plot3 = final3
        mmpiPlotView.plot4 = final4
        mmpiPlotView.plot5 = final5
        mmpiPlotView.plot6 = final6
        mmpiPlotView.plot7 = final7
        mmpiPlotView.plot8 = final8
        mmpiPlotView.plot9 = final9
        mmpiPlotView.plot0 = final0
    }
    

    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toInterpret" {
            if let destination = segue.destination.contents as? MMPIInterpretationViewController {
                destination.isMale = (document?.bluebird?.isMale)!
                destination.tValues = [finalL, finalF, finalK, final1, final2, final3, final4, final5, final6, final7, final8, final9, final0]
                print("sending doc to interpretation")
            }
        } else if segue.identifier == "toFinishTest" {
            if let destination = segue.destination.contents as? MMPIQuestionsViewController {
                destination.document = document
                destination.currentSessionNumber = testIndex
                destination.questionNumber = (document?.bluebird?.mmpiStorage[testIndex].count)!
                destination.isContinuingUnfinishedTest = true
                
                print("sending doc to continue question session")
            }
        }
    }
    
    
    // MARK: - Answer Keys
    
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
    
    private var rawL: Int = 0
    private var rawF: Int = 0
    private var rawK: Int = 0
    private var raw1: Int = 0
    private var raw2: Int = 0
    private var raw3: Int = 0
    private var raw4: Int = 0
    private var raw5: Int = 0
    private var raw6: Int = 0
    private var raw7: Int = 0
    private var raw8: Int = 0
    private var raw9: Int = 0
    private var raw0: Int = 0
    
    // Men
    // L = 36 + 3.29rawL
    // F = 45 + 2.12rawF
    // K = 28 + 1.9rawK
    // 1 = 22 + 2.54raw1
    // 2 = 30 + 2.32raw2 (if raw2 < 8, raw2 = 0)
    // 3 = 35 + 1.81raw3 (if raw3 < 8, raw3 = 0)
    // 4 = 20 + 2.31raw4 (if raw4 < 6, raw4 = 0)
    // 5 = 26 + 1.96raw5 (if raw5 < 8, raw5 = 0)
    // 6 = 28 + 2.92raw6
    // 7 = 21 + 2.06raw7 (if raw7 < 9, raw7 = 0)
    // 8 = 21 + 1.92raw8 (if raw8 < 7, raw8 = 0)
    // 9 = 21 + 2.54raw9 (if raw9 < 5, raw9 = 0)
    // 0 = 24 + 1.06raw0
    
    // Women
    // L = 36 + 3.29rawL
    // F = 45 + 2.12rawF
    // K = 28 + 1.9rawK
    // 1 = 23 + 2.02raw1
    // 2 = 24 + 2.04raw2 (if raw2 < 8, raw2 = 0)
    // 3 = 25 + 1.76raw3 (if raw3 < 4, raw3 = 0)
    // 4 = 20 + 2.31raw4 (if raw4 < 6, raw4 = 0)
    // 5 = 95 - 2.06raw5 (if raw5 < 15, raw5 = 0)
    // 6 = 28 + 2.92raw6
    // 7 = 20 + 1.64raw7 (if raw7 < 7, raw7 = 0)
    // 8 = 24 + 1.52raw8 (if raw8 < 5, raw8 = 0)
    // 9 = 21 + 2.54raw9 (if raw9 < 5, raw9 = 0)
    // 0 = 24 + 1.06raw0
    
    private func convertToT() {
        
        finalL = Int(36 + 3.29 * Double(rawL))
        finalF = Int(45 + 2.12 * Double(rawF))
        finalK = Int(28 + 1.90 * Double(rawK))
        
        if (document?.bluebird?.isMale)! {
            final1 = Int(22 + 2.549 * Double(raw1))
            
            if raw2 < 8 {
                final2 = 30
            } else {
                final2 = Int(7.97 + 2.4 * Double(raw2))
            }
            
            if raw3 < 8 {
                final3 = 35
            } else {
                final3 = Int(19.231 + 1.81 * Double(raw3))
            }
            
            if raw4 < 6 {
                final4 = 20
            } else {
                final4 = Int(3.9852 + 2.3584 * Double(raw4))
            }
            
            if raw5 < 8 {
                final5 = 26
            } else {
                final5 = Int(8.7955 + 1.9552 * Double(raw5))
            }
            
            final6 = Int(24.578 + 2.9063 * Double(raw6))
            
            if raw7 < 9 {
                final7 = 21
            } else {
                final7 = Int(1.1247 + 2.0528 * Double(raw7))
            }
            
            if raw8 < 7 {
                final8 = 21
            } else {
                final8 = Int(5.9717 + 1.9257 * Double(raw8))
            }
            
            if raw9 < 5 {
                final9 = 21
            } else {
                final9 = Int(6.4328 + 2.4895 * Double(raw9))
            }
            
            final0 = Int(23.461 + 1.0486 * Double(raw0))
        } else if !(document?.bluebird?.isMale)! {
            final1 = Int(21.642 + 2.0371 * Double(raw1))
            
            if raw2 < 8 {
                final2 = 24
            } else {
                final2 = Int(5.2804 + 2.0394 * Double(raw2))
            }
            
            if raw3 < 4 {
                final3 = 25
            } else {
                final3 = Int(15.757 + 1.758 * Double(raw3))
            }
            
            if raw4 < 6 {
                final4 = 20
            } else {
                final4 = Int(3.9852 + 2.3584 * Double(raw4))
            }
            
            if raw5 < 15 {
                final5 = 95
            } else {
                final5 = Int(128.64 - 2.0799 * Double(raw5))
            }
            
            final6 = Int(24.578 + 2.9063 * Double(raw6))
            
            if raw7 < 7 {
                final7 = 20
            } else {
                final7 = Int(7.3506 + 1.6409 * Double(raw7))
            }
            
            if raw8 < 5 {
                final8 = 21
            } else {
                final8 = Int(14.428 + 1.5251 * Double(raw8))
            }
            
            if raw9 < 5 {
                final9 = 21
            } else {
                final9 = Int(6.4553 + 2.5138 * Double(raw9))
            }
            
            final0 = Int(23.396 + 1.0516 * Double(raw0))
        } else {
            print("gender unwrapping error")
        }
    }
    
    private func convertToRawScore() {
        for i in 1...(document?.bluebird?.mmpiStorage[testIndex])!.count {
            // L
            if scale_L_f.contains(i), document?.bluebird?.mmpiStorage[testIndex][i] == 2 {
                rawL += 1
            }
            
            // F
            
            if (scale_F_f.contains(i) && document?.bluebird?.mmpiStorage[testIndex][i] == 2) || (scale_F_t.contains(i) && document?.bluebird?.mmpiStorage[testIndex][i] == 1) {
                rawF += 1
            }
            
            // K
            
            if (scale_K_f.contains(i) && document?.bluebird?.mmpiStorage[testIndex][i] == 2) || (scale_K_t.contains(i) && document?.bluebird?.mmpiStorage[testIndex][i] == 1) {
                rawK += 1
            }
            
            // 1
            
            if (scale_1_f.contains(i) && document?.bluebird?.mmpiStorage[testIndex][i] == 2) || (scale_1_t.contains(i) && document?.bluebird?.mmpiStorage[testIndex][i] == 1) {
                raw1 += 1
            }
            
            // 2
            
            if (scale_2_f.contains(i) && document?.bluebird?.mmpiStorage[testIndex][i] == 2) || (scale_2_t.contains(i) && document?.bluebird?.mmpiStorage[testIndex][i] == 1) {
                raw2 += 1
            }
            
            // 3
            
            if (scale_3_f.contains(i) && document?.bluebird?.mmpiStorage[testIndex][i] == 2) || (scale_3_t.contains(i) && document?.bluebird?.mmpiStorage[testIndex][i] == 1) {
                raw3 += 1
            }
            
            // 4
            
            if (scale_4_f.contains(i) && document?.bluebird?.mmpiStorage[testIndex][i] == 2) || (scale_4_t.contains(i) && document?.bluebird?.mmpiStorage[testIndex][i] == 1) {
                raw4 += 1
            }
            
            // 5
            
            if (scale_5_f.contains(i) && document?.bluebird?.mmpiStorage[testIndex][i] == 2) || (scale_5_t.contains(i) && document?.bluebird?.mmpiStorage[testIndex][i] == 1) {
                raw5 += 1
            }
            
            // 6
            
            if (scale_6_f.contains(i) && document?.bluebird?.mmpiStorage[testIndex][i] == 2) || (scale_6_t.contains(i) && document?.bluebird?.mmpiStorage[testIndex][i] == 1) {
                raw6 += 1
            }
            
            // 7
            
            if (scale_7_f.contains(i) && document?.bluebird?.mmpiStorage[testIndex][i] == 2) || (scale_7_t.contains(i) && document?.bluebird?.mmpiStorage[testIndex][i] == 1) {
                raw7 += 1
            }
            
            // 8
            
            if (scale_8_f.contains(i) && document?.bluebird?.mmpiStorage[testIndex][i] == 2) || (scale_8_t.contains(i) && document?.bluebird?.mmpiStorage[testIndex][i] == 1) {
                raw8 += 1
            }
            
            // 9
            
            if (scale_9_f.contains(i) && document?.bluebird?.mmpiStorage[testIndex][i] == 2) || (scale_9_t.contains(i) && document?.bluebird?.mmpiStorage[testIndex][i] == 1) {
                raw9 += 1
            }
            
            // 0
            
            if (scale_0_f.contains(i) && document?.bluebird?.mmpiStorage[testIndex][i] == 2) || (scale_0_t.contains(i) && document?.bluebird?.mmpiStorage[testIndex][i] == 1) {
                raw0 += 1
            }
            
        }
        
        raw1 += Int(0.5 * Double(rawK))
        raw4 += Int(0.4 * Double(rawK))
        raw7 += Int(Double(rawK))
        raw8 += Int(Double(rawK))
        raw9 += Int(0.2 * Double(rawK))
    }
    
    let scale_L_f = [50, 58, 65, 90, 120, 150, 163, 180, 210, 231, 240, 270, 300, 330, 360]

    let scale_F_f = [24, 57, 58, 84, 88, 176, 193, 233, 235, 261, 263, 276, 296, 323, 364]
    let scale_F_t = [12, 25, 26, 27, 28, 54, 55, 56, 72, 83, 85, 86, 102, 105, 113, 115, 116, 117, 132, 143, 145, 146, 147, 173, 175, 177, 203, 206, 207, 236, 237, 265, 266, 267, 294, 295, 297, 324, 325, 326, 327, 334, 353, 354, 355, 356, 357]

    let scale_K_f = [8, 13, 38, 43, 73, 94, 98, 103, 124, 128, 133, 154, 158, 163, 188, 193, 217, 223, 253, 277, 280, 282, 283, 310, 312, 313, 342, 372]
    let scale_K_t = [340]

    let scale_1_f = [16, 47, 75, 167, 195, 254, 284, 374]
    let scale_1_t = [15, 17, 45, 46, 77, 105, 107, 135, 137, 165, 197, 225, 255, 285, 286, 308, 314, 315, 316, 344, 345, 346, 375, 376]

    let scale_2_f = [18, 20, 41, 43, 50, 75, 78, 131, 137, 138, 161, 163, 167, 193, 198, 199, 223, 227, 254, 277, 284, 287, 288, 289, 317, 318, 319, 338, 347, 348, 349, 368, 370, 377]
    let scale_2_t = [9, 19, 48, 49, 98, 105, 108, 109, 139, 165, 168, 169, 225, 228, 229, 253, 257, 258, 259, 315, 337, 367]

    let scale_3_f = [8, 11, 13, 16, 41, 43, 71, 73, 74, 75, 101, 103, 104, 124, 133, 155, 163, 164, 184, 187, 196, 214, 218, 224, 226, 248, 254, 256, 278, 280, 284, 343, 370, 374]
    let scale_3_t = [14, 15, 45, 46, 76, 105, 106, 134, 135, 136, 165, 166, 194, 225, 255, 285, 314, 315, 344, 345, 373, 375]

    let scale_4_f = [8, 10, 11, 38, 41, 68, 71, 94, 101, 130, 131, 160, 161, 187, 217, 220, 277, 280, 307, 310, 340, 370]
    let scale_4_t = [12, 40, 42, 64, 70, 72, 100, 102, 132, 162, 190, 191, 192, 221, 222, 247, 250, 251, 252, 281, 311, 337, 341, 366, 367, 369, 371]

    let scale_5_f = [2, 4, 31, 33, 34, 35, 61, 63, 65, 91, 92, 121, 123, 124, 153, 182, 183, 184, 211, 212, 214, 241, 244, 271, 272, 304, 333, 363, 364]
    let scale_5_t = [1, 3, 5, 32, 62, 93, 94, 122, 151, 152, 154, 181, 213, 242, 243, 273, 274, 301, 302, 303, 331, 332, 334, 361, 362]

    let scale_6_f = [34, 117, 148, 188, 196, 218, 226, 238, 268, 370]
    let scale_6_t = [5, 12, 28, 42, 51, 88, 113, 114, 143, 144, 162, 171, 178, 192, 203, 208, 222, 231, 252, 259, 262, 267, 291, 297, 308, 327, 339, 353, 371]

    let scale_7_f = [41, 195, 200, 288, 318, 348]
    let scale_7_t = [19, 21, 39, 49, 51, 69, 76, 79, 80, 81, 99, 106, 109, 110, 111, 136, 140, 141, 154, 159, 170, 171, 189, 191, 201, 219, 221, 230, 231, 251, 253, 258, 260, 290, 291, 315, 320, 337, 350, 367]

    let scale_8_f = [24, 41, 84, 248, 263, 283, 292, 293, 322, 323, 348]
    let scale_8_t = [12, 21, 22, 23, 42, 51, 52, 53, 54, 79, 81, 82, 83, 106, 109, 111, 112, 113, 114, 136, 139, 141, 142, 143, 144, 167, 169, 171, 172, 173, 174, 201, 202, 203, 204, 247, 274, 279, 304, 308, 309, 311, 321, 337, 341, 345, 350, 351, 352, 353, 371, 375]

    let scale_9_f = [8, 30, 35, 38, 71, 89, 90, 120, 217, 249, 313, 358]
    let scale_9_t = [20, 21, 29, 51, 59, 60, 94, 105, 108, 119, 149, 174, 179, 204, 209, 222, 234, 239, 256, 262, 264, 269, 276, 281, 289, 298, 319, 328, 339, 349, 353, 359]

    let scale_0_f = [4, 36, 66, 67, 68, 96, 125, 156, 157, 185, 186, 189, 216, 246, 249, 273, 275, 276, 277, 303, 333, 335, 336, 339, 363, 368]
    let scale_0_t = [6, 7, 8, 9, 34, 37, 38, 39, 69, 95, 97, 98, 126, 127, 128, 129, 155, 158, 159, 187, 188, 217, 218, 219, 243, 245, 248, 278, 279, 307, 308, 309, 337, 338, 365, 366, 367]
}
