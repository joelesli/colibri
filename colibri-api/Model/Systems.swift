//
//  Systems.swift
//  colibri-api
//
//  Created by Joel Martinez on 12/16/17.
//  Copyright © 2017 JOELESLI. All rights reserved.
//

import Foundation

public struct Train : Codable, TableItem {
    
    let trainNumber : Int?
    var systems : [System]?
    
    public var cellTitle: String? {
        get {
            return trainNumber == nil ? nil : "Train number: \(trainNumber!)"
        }
    }
    
    public var cellSubtitle : String? {
        get {
            return systems == nil ? nil : "Systems: \(systems!.count)"
        }
    }
    
    public var tableItems : [TableItem]? {
        get {
            return systems
        }
        
        set {
            systems = newValue as? [System]
        }
    }
    
}

/// List of colibri systems with GPS position, base data ...
/// /api/db/1/systems.json?params={"operatorId":8,"pcType":1,"modelType":"R 187.9","vehicleType":"Zug"}
public struct System : Codable, TableItem {
    
    /*
     {
     "mac": "00:c0:3a:b1:d5:f2",
     "name": "DB FV Versuchstr\u00e4ger BV187.9",
     "lastCall": null,
     "id": 7,
     "lat": 0,
     "lng": 0,
     "operator": "DB Fernverkehr",
     "operatorId": 8,
     "trainType": "IC",
     "trainNumber": null,
     "station": null,
     "stationId": null,
     "modelType": "R 187.9",
     "modelTypeImage": "images/db/modelType/Bordbistro_R187.9.jpg",
     "modelTypeId": 9,
     "vehicleType": "Zug",
     "vehicleTypeId": 1,
     "pcType": "Mobil",
     "pcTypeId": 1
     },
     */
    
    
    let mac : String?
    let name : String?
    var lastCall : Int?
    let id : Int?
    let lat : Double?
    let lng : Double?
    let operatorName : String? //TODO need to make codable because the attribute name is operator
    let operatorId : Int?
    let trainType : String?
    /// Must be > 0 to be a valid train
    var trainNumber : Int?
    let station : String?
    let stationId : Int?
    let modelType : String?
    let modelTypeImage : String?
    let modelTypeId : Int?
    let vehicleType : String?
    let vehicleTypeId : Int?
    let pcType : String?
    let pcTypeId : Int?
    
    enum CodingKeys : String, CodingKey {
        case mac
        case name
        case lastCall
        case id
        case lat
        case lng
        case operatorName = "operator"
        case operatorId
        case trainType
        case trainNumber
        case station
        case stationId
        case modelType
        case modelTypeImage
        case modelTypeId
        case vehicleType
        case vehicleTypeId
        case pcType
        case pcTypeId
    }
    
    public var cellTitle: String? {
        get {
            return mac != nil ? "Mac: " + mac! : nil
        }
    }
    
    public var cellSubtitle : String? {
        get {
            return modelType != nil ? "Model type: " + modelType! : nil
        }
    }
    
    public var tableItems : [TableItem]? {
        get {
            return [TableItem]()
        }
        
        set {
            //TODO
        }
    }
    
}

/// Get detailed information for a specific colibri system.
/// Best data could be retrieved from systems of operator "DB Regio SO"
/// /api/db/1/system.json?params={"mac":"00:c0:3a:b1:d5:f2","id":7}
struct SystemDetails : Codable {
    /*
     {
     "id": 7,
     "mac": "00:c0:3a:b1:d5:f2",
     "name": "DB FV Versuchstr\u00e4ger BV187.9",
     "properties": {},
     "trainType": "IC",
     "trainNumber": null,
     "station": null,
     "stationId": null,
     "modelType": "R 187.9",
     "modelTypeImage": "https://dbdata.colibri-w.de/images/db/modelType/Bordbistro_R187.9.jpg",
     "pcType": "Mobil",
     "vehicleType": "Zug",
     "operator": "DB Fernverkehr",
     "sims": [],
     "jobs": [],
     "gps": null,
     "traffic": [],
     "baptismHistory": [],
     "messages": [],
     "systemInfo": null
     }
     */
}


