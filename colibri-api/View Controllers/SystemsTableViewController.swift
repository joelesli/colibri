//
//  SystemsTableViewController.swift
//  colibri-api
//
//  Created by Joel Martinez on 12/16/17.
//  Copyright © 2017 JOELESLI. All rights reserved.
//

import UIKit

struct TableSection {
    var sectionTitle : String
    var tableItems : [TableItem]
}

protocol TableItem {
    var cellTitle : String? { get }
    var cellSubtitle : String? { get }
}

class SystemsTableViewController: UITableViewController {

    var tableSections : [TableSection]?
    let networkHelper = NetworkHelper()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Colibri Systems"
        fetchObjects()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return tableSections?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return tableSections?[section].tableItems.count ?? 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        // Configure the cell...
        if let item = tableSections?[indexPath.section].tableItems[indexPath.row] {
            cell.textLabel?.text = item.cellTitle
            cell.detailTextLabel?.text = item.cellSubtitle
        }

        return cell
    }
 
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return tableSections?[section].sectionTitle ?? ""
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
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    // MARK: - Fetch objects
    
    func fetchObjects() {
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        networkHelper.getSystems(parameters: [:]) { (objects) in
            
            if let objtcs = objects as? [System] {
                
                //filter out invalid data
                var systems = objtcs.filter({ (sys) -> Bool in
                    if let number = sys.trainNumber {
                        return number > 0
                    }
                    return false
                })
                
                systems.sort(by: { (system01, system02) -> Bool in
                    return system01.trainNumber ?? 0 < system02.trainNumber ?? 0
                })
                
                //create trains from the systems
                var trains = [Train]()
                for aSystem in systems {
                    
                    if let lastTrain = trains.last, lastTrain.trainNumber == aSystem.trainNumber {
                        var train = lastTrain
                        train.systems?.append(aSystem)
                        trains.removeLast()
                        trains.append(train)
                    }
                    //handles the no train case and the new train case
                    else {
                        let train = Train(trainNumber: aSystem.trainNumber!, systems: [aSystem])
                        trains.append(train)
                    }
                    
                }
                
                //sort the trains
                trains.sort(by: { (train01, train02) -> Bool in
                    train01.systems?.last?.operatorName ?? "" < train02.systems?.last?.operatorName ?? ""
                })
                
                var sections = [TableSection]()
                
                for train in trains {
                    
                    if let last = sections.last, last.sectionTitle == train.systems?.last?.operatorName {
                        var section = last
                        section.tableItems.append(train)
                        sections.removeLast()
                        sections.append(section)
                    }
                        //handles the empty case and the adding a new section case
                    else {
                        let section = TableSection(sectionTitle: train.systems?.last?.operatorName ?? "", tableItems: [train])
                        sections.append(section)
                    }
                    
                }
                
                //sort the trains within their sections
                var finalSections = [TableSection]()
                for aSection in sections {
                    if let trains = aSection.tableItems as? [Train] {
                        var tr = trains
                        tr.sort(by: { (train01, train02) -> Bool in
                            return train01.trainNumber ?? 0 < train02.trainNumber ?? 0
                        })
                        
                        finalSections.append(TableSection(sectionTitle: aSection.sectionTitle, tableItems: tr))
                    }
                }
                
                
                
                DispatchQueue.main.async {
                    
                    self.tableSections = finalSections
                    self.tableView.reloadData()
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                }
                
                
            }
            
        }
        
    }

}
