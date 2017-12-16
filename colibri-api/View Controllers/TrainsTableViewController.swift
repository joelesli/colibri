//
//  TrainsTableViewController.swift
//  colibri-api
//
//  Created by Joel Martinez on 12/16/17.
//  Copyright © 2017 JOELESLI. All rights reserved.
//

import UIKit

class TrainsTableViewController: ColibriTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Trains"
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    
    override open func fetchObjects() {
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        networkHelper.getSystems(parameters: [:]) { (objects) in
            
            if let objtcs = objects as? [System] {
                
                //filter out invalid data
                var systems = SystemsHelper().systemsWithValidTrain(systems: objtcs)
                
                systems.sort(by: { (system01, system02) -> Bool in
                    return system01.trainNumber ?? 0 < system02.trainNumber ?? 0
                })
                
                //create trains from the systems
                let trainHelper = TrainHelper()
                var trains = trainHelper.trainsFrom(systems: systems)
                
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
