//
//  TSIHistoryTableViewController.swift
//  bluebird
//
//  Created by macbook on 2/6/20.
//  Copyright © 2020 bolattleubayev. All rights reserved.
//

import UIKit

class TSIHistoryTableViewController: UITableViewController {
    
    var document: bluebirdDocument?
    let headerTitles = ["Результаты теста", "Баллы"]
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        tableView.backgroundView = UIImageView(image: UIImage(named: "backroundRandomImages"))
        tableView.backgroundView?.alpha = 0.5
        tableView.backgroundView?.contentMode = UIView.ContentMode.scaleAspectFill
        
        navigationController?.navigationBar.prefersLargeTitles = false
        
        print(document?.bluebird)
        
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return document?.bluebird?.tsiStorage.count ?? 0
        } else {
            return document?.bluebird?.tsiScoresStorage.count ?? 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TSIHistoryCell", for: indexPath) as! TSIHistoryTableViewCell
            // Configure the cell...
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd hh:mm:ss"
        
        if indexPath.section == 0 {
            cell.nameLabel?.text = "Тест #\(indexPath.row + 1) (" + df.string(from:(document?.bluebird?.mmpiTestDates[indexPath.row])!) + ")"
            
            // MARK: Needs Attention!
            
            if (document?.bluebird?.tsiStorage[indexPath.row].count)! >= 377 {
                if #available(iOS 13.0, *) {
                    cell.completionIndicator.image = UIImage(systemName: "checkmark.circle.fill")
                } else {
                    // Fallback on earlier versions
                    cell.completionIndicator.isHidden = true
                }
                cell.completionIndicator.tintColor = #colorLiteral(red: 0.5563425422, green: 0.9793455005, blue: 0, alpha: 1)
            } else {
                if #available(iOS 13.0, *) {
                    cell.completionIndicator.image = UIImage(systemName: "pencil.circle.fill")
                } else {
                    // Fallback on earlier versions
                    cell.completionIndicator.isHidden = true
                }
                cell.completionIndicator.tintColor = #colorLiteral(red: 1, green: 0.4932718873, blue: 0.4739984274, alpha: 1)
            }
                return cell
        } else {
            cell.nameLabel?.text = "Баллы #\(indexPath.row + 1)"
            
            if #available(iOS 13.0, *) {
                cell.completionIndicator.image = UIImage(systemName: "checkmark.circle.fill")
            } else {
                // Fallback on earlier versions
                cell.completionIndicator.isHidden = true
            }
            cell.completionIndicator.tintColor = #colorLiteral(red: 0.5563425422, green: 0.9793455005, blue: 0, alpha: 1)
            
            return cell
        }
        
    }
    
    // deleting with swipe
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            if indexPath.section == 0 {
                document?.bluebird?.tsiTestDates.remove(at: indexPath.row)
                document?.bluebird?.tsiStorage.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
            } else {
                document?.bluebird?.tsiScoresStorage.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
            
            
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section < headerTitles.count {
            return headerTitles[section]
        }
        return nil
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toTSIPlot" {
            if segue.destination.contents is TSIPlotViewController {
                print("is")
                if let tpvc = segue.destination.contents as? TSIPlotViewController { // igcvc - Image Gallery Collection View Controller, we need to refer to segue.destination.contents, as segue points to Navigation Controller
                    
                    print("as")
                    let cell = sender as! UITableViewCell
                    let indexPath = tableView.indexPath(for: cell)
                    
                    // putting needed view
                    tpvc.document = document
                    tpvc.testIndex = indexPath!.row
                    if indexPath?.section == 0 {
                        tpvc.onlyTScoresAvailable = false
                    } else {
                        tpvc.onlyTScoresAvailable = true
                    }
                    print("sending doc to plot tsi \(indexPath!.row)")
                }
            }
        }
    }
}
