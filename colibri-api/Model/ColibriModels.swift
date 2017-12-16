//
//  ColibriModels.swift
//  colibri-api
//
//  Created by Joel Martinez on 12/15/17.
//  Copyright © 2017 JOELESLI. All rights reserved.
//

import Foundation




/// Organisation unit that use the colibri project.
struct Operator : Codable {
    /*
     /// {
     /// "id": 8,
     /// "name": "DB Fernverkehr"
     /// },
     */
    
    let id : Int
    let name : String
}



/// List of model series of trains and station panels within colibri.
struct ModelType : Codable {
    /* {
    "id": 40,
    "name": "Dosto 767.2 (B10)",
    "image": "",
    "vehicleTypeId": 1,
    "vehicleType": "Zug"
    },
    */
    
    
    let id : Int
    let name : String
    let image : String
    let vehicleTypeId :Int
    let vehicleType : String
    
}

/// List of vehicle types (train, bus, car, panel)
struct VehicleType : Codable {
    /*
     {
     "id": 2,
     "name": "Bus"
     },
     */
    
    let id : Int
    let name : String
}

/// List PC Types. (Moving of stationary)
struct PCType : Codable {
    /*
     {
     "id": 1,
     "name": "Mobil"
     },
     */
    
    let id : Int
    let name : String
}

/// List of ISPs for the colibri systems.
struct SIMProvider : Codable {
    /*
    {
    "issuerIdentifierNumber": 894901,
    "name": "Deutsche Telekom AG",
    "properties": {
        "color": "#E20074"
        }
    },
    */
    //TODO: color is part of the dictionary
    let issuerIdentifierNumber : Int
    let name : String
    let color : String
}

/// List of stations with gps position.
struct Station : Codable {
    /*
     {
     "id": 8089002,
     "name": "Berlin Anhalter Bf",
     "shortTag": "BAHU",
     "lat": 52.503486,
     "lng": 13.381362
     },
     */
    
    let id : Int
    let name : String
    let shortTag : String
    let lat : Double
    let lng : Double
    var schedule : ScheduleDetails?
}

struct ScheduleDetails : Codable {
    let track : Int
    let approach : Int //1513133460
    let departure : Int // 1513133460,
    let delay : Int
    let status : String
    let message : String
}


/// Get the train schedule of the specified tour at the given time (day). (including delay times)
/// /api/db/1/trainSchedule.json?params={"trainType":"RE","trainNumber":14,"time":"Fri, 15 Dec 2017 20:56:39 +0000"}
struct TrainSchedule : Codable {
    
    /// Train type like RE, RB, ICE
    let type : String
    
    
    /// Train number
    let number : String
    
    /// The display name, e.g. "RE 20"
    let name : String
    
    /// An array of stations with schedule details
    var stations : [Station]?
    
    /// Until when the schedule is valid
    let validUntil : Int // 1513140600
    
    
}

/// List of colibri systems with GPS position, base data ...
/// /api/db/1/systems.json?params={"operatorId":8,"pcType":1,"modelType":"R 187.9","vehicleType":"Zug"}
struct System : Codable {
    
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

/// List of GPS coordinates for a specific system including internet connectivity information.
/// Values are saved every 30 seconds.
/// /api/db/1/gpsHistory.json?params={"mac":"00:c0:3a:b1:d5:f2","id":7,"fromTime":"Fri, 15 Dec 2017 20:56:39 +0000","toTime":"Fri, 15 Dec 2017 20:56:39 +0000"}
struct GPSHistory : Codable {
    
    let lat : Double
    let lng : Double
    
    /// Need the units of the speed?
    let speed : Int
    
    let time : Int //1512770250,
    var simData : [SIMData]?
    /*
     {
     "lat": 52.5948,
     "lng": 11.8574,
     "speed": 0,
     "time": 1512770250,
     "simData": [
     {
     "sim": "89492018167014764708",
     "strength": -104,
     "signalType": "lte"
     },
     {
     "sim": "89490200001328549855",
     "strength": -64,
     "signalType": "lte"
     }
     ]
     },
     */
    
    
}

struct SIMData : Codable {
    let sim : String
    let strength : Int //-104
    let signalType : String //"lte"
}

struct Sensor : Codable {
    
    let time : Int //1513131892,
    let properties : [String : Measurement]
    /*
     {
     "time": 1513131892,
     "properties": {
     "temperatureWE2": {
     "label": "Raumtemperatur WE2 3. Abteil",
     "value": 24.2,
     "unit": "\u00b0C"
     },
     "temperatureIndoor": {
     "label": "Raumtemperatur Gro\u00dfraum",
     "value": 20,
     "unit": "\u00b0C"
     },
     "temperatureZub": {
     "label": "Raumtemperatur Zub",
     "value": 23.6,
     "unit": "\u00b0C"
     },
     "temperatureS1": {
     "label": "Raumtemperaur S1- Schrank",
     "value": 27.9,
     "unit": "\u00b0C"
     },
     "temperatureOutside": {
     "label": "Au\u00dfentemperatur",
     "value": 0.5,
     "unit": "\u00b0C"
     },
     "temperature1": {
     "label": "Verdampferendtemperatur",
     "value": 0.3,
     "unit": "\u00b0C"
     },
     "temperatureCooling": {
     "label": "Temperatur Drehrichter K\u00e4lte",
     "value": 0.2,
     "unit": "\u00b0C"
     },
     "temperatureH5": {
     "label": "Temperatur H5 Kasten",
     "value": 16.9,
     "unit": "\u00b0C"
     },
     "levelFreshWaterWE1": {
     "label": "F\u00fcllstand Frischwasser WE1",
     "value": 80,
     "unit": "%"
     },
     "levelFreshWaterWE2": {
     "label": "F\u00fcllstand Frischwasser WE2",
     "value": 40,
     "unit": "%"
     },
     "levelWastewaterWE1": {
     "label": "F\u00fcllstand Abwasser WE1",
     "value": 60,
     "unit": "%"
     },
     "levelWastewaterWE2": {
     "label": "F\u00fcllstand Abwasser WE2",
     "value": 60,
     "unit": "%"
     },
     "highPressureAc": {
     "label": "Hochdrucksensor Klima",
     "value": 2.36,
     "unit": "bar"
     },
     "lowPressureAc": {
     "label": "Niederdrucksensor Klima",
     "value": 2.35,
     "unit": "bar"
     },
     "oilAc": {
     "label": "\u00d6ldruck Klima",
     "value": 2.32,
     "unit": "bar"
     },
     "acVoltage": {
     "label": "Batteriepsannung",
     "value": 28,
     "unit": "V"
     },
     "presssostat": {
     "label": "Pressostat HD Klima",
     "value": 0,
     "unit": "bool"
     },
     "presssostat2": {
     "label": "Pressostat ND Klima",
     "value": 0,
     "unit": "bool"
     },
     "powerFailure": {
     "label": "Energieversorgung gest\u00f6rt",
     "value": 0,
     "unit": "bool"
     },
     "mainswitch": {
     "label": "Zugspannung Ein",
     "value": 8,
     "unit": "bool"
     },
     "wcFailure": {
     "label": "WC gest\u00f6rt",
     "value": 0,
     "unit": "bool"
     },
     "doorFailure": {
     "label": "T\u00fcr gest\u00f6rt",
     "value": 0,
     "unit": "bool"
     },
     "batterySwitch": {
     "label": "Batterieladung Ein",
     "value": 64,
     "unit": "bool"
     }
     }
     }
     */
    
}

struct Measurement : Codable {
    
    let label : String //"Batterieladung Ein",
    let value : Int // 64,
    let unit : String //"bool"
    
}

/// Passenger and bike counting data.
/// If paramters "fromTime" and "toTime" are supplied, you will all values within the given period.
/// Values are saved on change or every 5 minutes.

/// (Only available for systems of operator "DB Regio NO")
struct LoadCount : Codable {
    
    //to get data filter http://hackathon.colibri-labs.de/api/db/1/systems.json
    // for "operator": "DB Regio NO"
    
    let app_version : String //"1.00",
    let time : Int //1512947105,
    let passengers : Int // -4,
    let bikes : Int //0
    var sensors : [Sensor]?
    /*
     {
     "app_version": "1.00",
     "sensors": [
     {
     "area_id": 1,
     "area_name": "",
     "current_cat_0_in": 67,
     "current_cat_0_out": 59,
     "current_cat_1_in": 3,
     "current_cat_1_out": 0,
     "door_nr": 1,
     "door_state": "closed",
     "main_cat_0_in": 0,
     "main_cat_0_out": 0,
     "main_cat_1_in": 0,
     "main_cat_1_out": 0,
     "status": "online",
     "timestamp": "Sun Dec 10 23:04:55 2017",
     "url": "udp://10.64.4.131#1"
     },
     {
     "area_id": 1,
     "area_name": "",
     "current_cat_0_in": 71,
     "current_cat_0_out": 61,
     "current_cat_1_in": 0,
     "current_cat_1_out": 3,
     "door_nr": 1,
     "door_state": "closed",
     "main_cat_0_in": 0,
     "main_cat_0_out": 0,
     "main_cat_1_in": 0,
     "main_cat_1_out": 0,
     "status": "online",
     "timestamp": "Sun Dec 10 23:04:55 2017",
     "url": "udp://10.64.4.132#1"
     },
     {
     "area_id": 1,
     "area_name": "",
     "current_cat_0_in": 60,
     "current_cat_0_out": 56,
     "current_cat_1_in": 0,
     "current_cat_1_out": 0,
     "door_nr": 1,
     "door_state": "closed",
     "main_cat_0_in": 0,
     "main_cat_0_out": 0,
     "main_cat_1_in": 0,
     "main_cat_1_out": 0,
     "status": "online",
     "timestamp": "Sun Dec 10 23:04:55 2017",
     "url": "udp://10.64.4.133#1"
     },
     {
     "area_id": 1,
     "area_name": "",
     "current_cat_0_in": 76,
     "current_cat_0_out": 67,
     "current_cat_1_in": 0,
     "current_cat_1_out": 0,
     "door_nr": 1,
     "door_state": "closed",
     "main_cat_0_in": 0,
     "main_cat_0_out": 0,
     "main_cat_1_in": 0,
     "main_cat_1_out": 0,
     "status": "online",
     "timestamp": "Sun Dec 10 23:04:55 2017",
     "url": "udp://10.64.4.134#1"
     },
     {
     "status": "offline",
     "timestamp": "Sun Dec 10 23:04:55 2017",
     "url": "udp://10.64.4.135#1"
     },
     {
     "area_id": 1,
     "area_name": "",
     "current_cat_0_in": 38,
     "current_cat_0_out": 73,
     "current_cat_1_in": 0,
     "current_cat_1_out": 0,
     "door_nr": 1,
     "door_state": "closed",
     "main_cat_0_in": 0,
     "main_cat_0_out": 0,
     "main_cat_1_in": 0,
     "main_cat_1_out": 0,
     "status": "online",
     "timestamp": "Sun Dec 10 23:04:55 2017",
     "url": "udp://10.64.4.136#1"
     }
     ],
     "time": 1512947105,
     "passengers": -4,
     "bikes": 0
     },
     */
    
}

struct LoadSensor : Codable {
    
    let area_id : Int //1,
    let area_name : String
    let current_cat_0_in : Int //67,
    let current_cat_0_out : Int //59,
    let current_cat_1_in : Int // 3,
    let current_cat_1_out : Int // 0,
    let door_nr : Int // 1,
    let door_state : String // "closed",
    let main_cat_0_in : Int // 0,
    let main_cat_0_out : Int // 0,
    let main_cat_1_in : Int // 0,
    let main_cat_1_out : Int // 0,
    let status : String //"online",
    let timestamp : String //"Sun Dec 10 23:04:55 2017",
    let url : String //"udp://10.64.4.131#1"
    
}
