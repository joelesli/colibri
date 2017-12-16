//
//  NetworkHelper.swift
//  colibri-api
//
//  Created by Joel Martinez on 12/16/17.
//  Copyright © 2017 JOELESLI. All rights reserved.
//

import Foundation
import Alamofire

public typealias NetworkResultsBlock = ([Any]) -> Void

public class NetworkHelper : NSObject {
    
    let colibriAPIURL : String = "http://hackathon.colibri-labs.de/api/db/1/"
    
    /// <#Description#>
    ///
    /// - operators: List of organisation units / customers that use the colibri project.
    /// - modelTypes: List of model series of trains and station panels within colibri.
    /// - vehicleTypes: List of vehicle types (train, bus, car, panel)
    /// - pcTypes: List PC Types. (Moving of stationary)
    /// - simprovider: List of ISPs for the colibri systems.
    /// - stations: List of stations with gps position.
    enum ColibriEndpointsBaseData : String {
        case operators
        case modelTypes
        case vehicleTypes
        case pcTypes
        case simprovider
        case stations
    }
    
    /// <#Description#>
    ///
    /// - trainSchedule: Get the train schedule of the specified tour at the given time (day). (including delay times)
    /// - systems: List of colibri systems with GPS position, base data ...
    /// - system: <#system description#>
    /// - gpsHistory: <#gpsHistory description#>
    /// - sensors: <#sensors description#>
    /// - diagnose: <#diagnose description#>
    /// - afz: <#afz description#>
    enum ColibriEndpointsSpecificData : String {
        case trainSchedule
        case systems
        case system
        case gpsHistory
        case sensors
        case diagnose
        case afz
    }
    
    public func get(endpoint: String, parameters: Parameters, callback: @escaping NetworkResultsBlock) {
        
        let urlString = colibriAPIURL + endpoint + ".json"
        if let url = URL(string: urlString) {
            Alamofire.request(url, parameters: parameters)
                .validate(statusCode: 200..<300)
                .validate(contentType: ["application/json"])
                .responseString(completionHandler: { (response) in
                    callback([response.result.value ?? ""])
                })
//                .responseJSON(completionHandler: { (response) in
//                    
//                    callback([response])
//                })
        }
        
    }
    
    public func getSystems(parameters: Parameters, callback: @escaping NetworkResultsBlock) {
        
        get(endpoint: ColibriEndpointsSpecificData.systems.rawValue, parameters: parameters) { (response) in
            
            guard let jsonString = response.first as? String else {
                callback([])
                return
            }
            //get the array and convert it
            
            do {
                let jsonData = jsonString.data(using: .utf8)!
                let decoder = JSONDecoder()
                let objects = try decoder.decode([System].self, from: jsonData )
                dump(objects)
                callback(objects)
            } catch let error {
                print(error)
                callback([""])
            }
            
        }
        
    }
    
}
