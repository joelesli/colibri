//
//  SystemsTableViewController.swift
//  colibri-api
//
//  Created by Joel Martinez on 12/16/17.
//  Copyright © 2017 JOELESLI. All rights reserved.
//

import UIKit



class SystemsTableViewController: ColibriTableViewController {

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Systems"
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    
    
    // MARK: - Fetch objects
    
    override open func fetchObjects() {
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        networkHelper.getSystems(parameters: [:]) { (objects) in
            
            DispatchQueue.main.async {
                
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
            }
            
            
        }
        
    }

}
