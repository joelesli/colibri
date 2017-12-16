//
//  TrainHelper.swift
//  colibri-api
//
//  Created by Joel Martinez on 12/16/17.
//  Copyright © 2017 JOELESLI. All rights reserved.
//

import Foundation

class TrainHelper : NSObject {
    
    func trainsFrom(systems: [System]) -> [Train] {
        
        var trains = [Train]()
        for aSystem in systems {
            
            if let lastTrain = trains.last, lastTrain.trainNumber == aSystem.trainNumber {
                var train = lastTrain
                train.systems?.append(aSystem)
                trains.removeLast()
                trains.append(train)
            }
                //handles the no train case and the new train case
            else {
                let train = Train(trainNumber: aSystem.trainNumber!, systems: [aSystem])
                trains.append(train)
            }
            
        }
        return trains
    }
    
    func tableSectionsFrom(trains:[Train]) -> [TableSection] {
        
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
        
        return sections 
    }
    
}
