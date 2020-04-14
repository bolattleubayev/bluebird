//
//  MMPIHistoryTableViewController.swift
//  bluebird
//
//  Created by macbook on 1/26/20.
//  Copyright © 2020 bolattleubayev. All rights reserved.
//

import UIKit

class MMPIHistoryTableViewController: UITableViewController, UITabBarControllerDelegate {
    
    var document: bluebirdDocument?
    let headerTitles = ["Результаты теста", "Т-баллы"]
    
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
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if section == 0 {
            return document?.bluebird?.mmpiStorage.count ?? 0
        } else {
            return document?.bluebird?.tScoresStorage.count ?? 0
        }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MMPIHistoryCell", for: indexPath) as! MMPIHistoryTableViewCell
            // Configure the cell...
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd hh:mm:ss"
        
        if indexPath.section == 0 {
            cell.nameLabel?.text = "Тест #\(indexPath.row + 1) (" + df.string(from:(document?.bluebird?.mmpiTestDates[indexPath.row])!) + ")"
            
            if (document?.bluebird?.mmpiStorage[indexPath.row].count)! >= 377 {
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
            cell.nameLabel?.text = "Тест Т-баллы #\(indexPath.row + 1)"
            
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
                document?.bluebird?.mmpiTestDates.remove(at: indexPath.row)
                document?.bluebird?.mmpiStorage.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
            } else {
                document?.bluebird?.tScoresStorage.remove(at: indexPath.row)
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
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toMMPIPlot" {
            if segue.destination.contents is MMPIPlotViewController {
                if let mpvc = segue.destination.contents as? MMPIPlotViewController { // igcvc - Image Gallery Collection View Controller, we need to refer to segue.destination.contents, as segue points to Navigation Controller
                    
                    let cell = sender as! UITableViewCell
                    let indexPath = tableView.indexPath(for: cell)
                    
                    // putting needed view
                    mpvc.document = document
                    mpvc.testIndex = indexPath!.row
                    if indexPath?.section == 0 {
                        mpvc.onlyTScoresAvailable = false
                    } else {
                        mpvc.onlyTScoresAvailable = true
                    }
                    print("sending doc to plot mmpi \(indexPath!.row)")
                }
            }
        }
    }
}
