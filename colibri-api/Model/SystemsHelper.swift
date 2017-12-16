//
//  SystemsHelper.swift
//  colibri-api
//
//  Created by Joel Martinez on 12/16/17.
//  Copyright © 2017 JOELESLI. All rights reserved.
//

import Foundation


class SystemsHelper : NSObject {
    
    //filter out invalid data
    
    func systemsWithValidTrain(systems: [System]) -> [System] {
        
        //filter out invalid data
        let systems = systems.filter({ (sys) -> Bool in
            if let number = sys.trainNumber {
                return number > 0
            }
            return false
        })
        
        return systems
        
    }
    
}
