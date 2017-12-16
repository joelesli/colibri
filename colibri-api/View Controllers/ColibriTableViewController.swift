//
//  ColibriTableViewController.swift
//  colibri-api
//
//  Created by Joel Martinez on 12/16/17.
//  Copyright © 2017 JOELESLI. All rights reserved.
//

import UIKit

public enum Storyboard : String {
    case main = "Main"
}

public struct TableSection {
    var sectionTitle : String?
    var tableItems : [TableItem]
}

public protocol TableItem {
    var cellTitle : String? { get }
    var cellSubtitle : String? { get }
    var tableItems : [TableItem]? { get set }
}

public class ColibriTableViewController: UITableViewController {

    public var tableSections : [TableSection]?
    public let networkHelper = NetworkHelper()
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        fetchObjects()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override public func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override public func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return tableSections?.count ?? 0
    }
    
    override public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return tableSections?[section].tableItems.count ?? 0
    }
    
    
    override public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        // Configure the cell...
        if let item = tableSections?[indexPath.section].tableItems[indexPath.row] {
            cell.textLabel?.text = item.cellTitle
            cell.detailTextLabel?.text = item.cellSubtitle
            cell.accessoryType = item.tableItems == nil ? .none : .disclosureIndicator
        }
        
        return cell
    }
    
    override public func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return tableSections?[section].sectionTitle
    }
    
    override public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let item = tableSections?[indexPath.section].tableItems[indexPath.row], let subItems = item.tableItems,
            let controller = controllerFor(item: item, withSubitems: subItems) {
            navigationController?.pushViewController(controller, animated: true)
        }
        else {
            tableView.deselectRow(at: indexPath, animated: true)
        }
        
    }
    
    // MARK: - Helper methods for view controller hierarchy
    public func controllerFor(item: TableItem, withSubitems items: [TableItem]) -> UIViewController? {
        return nil
    }
    
    // MARK: - Fetch objects
    
    public func fetchObjects() {
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        networkHelper.getSystems(parameters: [:]) { (objects) in
            
            DispatchQueue.main.async {
                
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
            }
            
            
        }
        
    }
    

}

extension UIViewController {
    
    class open func controllerFrom(storyboard name: Storyboard, inBundle bundle: Bundle?) -> UIViewController? {
        let aStoryboard = UIStoryboard(name: name.rawValue, bundle: bundle)
        print("Controller with identifier: \(String(describing: self))")
        return aStoryboard.instantiateViewController(withIdentifier: String(describing: self))
    }
    
    class open func controller() -> UIViewController? {
        return self.controllerFrom(storyboard: .main, inBundle: nil)
    }
    
}
