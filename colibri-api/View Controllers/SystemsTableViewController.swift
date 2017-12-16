//
//  SystemsTableViewController.swift
//  colibri-api
//
//  Created by Joel Martinez on 12/16/17.
//  Copyright © 2017 JOELESLI. All rights reserved.
//

import UIKit



class SystemsTableViewController: ColibriTableViewController {

    var gpsData = [String : GPSHistory]()
    var requestCount = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if title == nil {
            title = "Systems"
        }
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    
    
    // MARK: - Fetch objects
    
//    override open func fetchObjects() {
//
//        guard let sections = tableSections else {
//            return
//        }
//
//        //fetch the GPS data
//
//        UIApplication.shared.isNetworkActivityIndicatorVisible = true
//
//        for section in sections {
//            if let systems = section.tableItems as? [System] {
//
//                for system in systems {
//                    let parameters = ["mac" : system.mac!]
//                    networkHelper.getGPSHistory(parameters: parameters) { (results) in
//
//                        DispatchQueue.main.async {
//
//                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
//                        }
//                    }
//                }
//
//            }
//        }
//
//    }
    
    override public func controllerFor(item: TableItem, withSubitems items: [TableItem]) -> UIViewController? {
        var controller : UIViewController?
        
        if let system = item as? System {
            let cont = MapViewController.controller() as! MapViewController
            cont.system = system
            controller = cont
        }
        
        return controller
    }

}
