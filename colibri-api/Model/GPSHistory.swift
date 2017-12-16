//
//  GPDHistory.swift
//  colibri-api
//
//  Created by Joel Martinez on 12/16/17.
//  Copyright © 2017 JOELESLI. All rights reserved.
//

import Foundation
import MapKit
import CoreLocation

public struct GPSHistory : Codable {
    var history : [GPSData]?
}

/// List of GPS coordinates for a specific system including internet connectivity information.
/// Values are saved every 30 seconds.
/// /api/db/1/gpsHistory.json?params={"mac":"00:c0:3a:b1:d5:f2","id":7,"fromTime":"Fri, 15 Dec 2017 20:56:39 +0000","toTime":"Fri, 15 Dec 2017 20:56:39 +0000"}
public class GPSData : NSObject, Codable, MKAnnotation {
    
    var lat : Double?
    var lng : Double?
    
    /// Need the units of the speed?
    var speed : Int?
    
    var time : Int? //1512770250,
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
    
    public var coordinate : CLLocationCoordinate2D {
        get {
            return CLLocationCoordinate2D(latitude: lat ?? 0.0 , longitude: lng ?? 0.0)
        }
    }
    
    // Title and subtitle for use by selection UI.
//     NSString *title;
//    @property (nonatomic, readonly, copy, nullable) NSString *subtitle;
    
}


