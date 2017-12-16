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

class NetworkHelper : NSObject {
    
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
    
    func get(endpoint: String, parameters: Parameters, callback: @escaping NetworkResultsBlock) {
        
        let urlString = colibriAPIURL + endpoint + ".json"
        if let url = URL(string: urlString) {
            Alamofire.request(url, parameters: parameters)
                .validate(statusCode: 200..<300)
                .validate(contentType: ["application/json"])
                .responseJSON(completionHandler: { (response) in
                    callback([response])
                })
        }
        
    }
    
    func getSystems(callBack: @escaping NetworkResultsBlock) {
        //http://hackathon.colibri-labs.de/api/db/1/systems.json?params=%7B%22vehicleType%22%3A%22Zug%22%7D
        let parameters: Parameters = ["vehicleType": "Zug"]
        let urlString = colibriAPIURL + ColibriEndpointsSpecificData.systems.rawValue + ".json"
        if let url = URL(string: urlString) {
            Alamofire.request(url, parameters: parameters)
                .validate(statusCode: 200..<300)
                .validate(contentType: ["application/json"])
                .responseJSON(completionHandler: { (response) in
                    callBack([response])
                })   
        }
        

        
//        Alamofire.request(colibriAPIURL + ColibriEndpointsSpecificData.systems.rawValue + ".json" + "?" + "params={'vehicleType':'Zug'}").responseJSON { response in
//            print("Request: \(String(describing: response.request))")   // original url request
//            print("Response: \(String(describing: response.response))") // http url response
//            print("Result: \(response.result)")                         // response serialization result
//            
//            if let json = response.result.value {
//                print("JSON: \(json)") // serialized json response
//                callBack([json])
//            }
//            
//            if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
//                print("Data: \(utf8Text)") // original server data as UTF8 string
//                callBack([utf8Text])
//            }
//            
//        }
    }
    
}
