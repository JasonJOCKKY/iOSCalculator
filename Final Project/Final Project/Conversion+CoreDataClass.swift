//
//  Conversion+CoreDataClass.swift
//  Final Project
//
//  Created by Tan Jingsong on 7/28/20.
//  Copyright © 2020 Tan Jingsong. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Conversion)
public class Conversion: NSManagedObject {
    static let MaxNmberOfConversion: Int = 30
    
    class func fetchAllDateDescend() -> NSFetchRequest<Conversion> {
        let request = Conversion.fetchRequest() as NSFetchRequest<Conversion>
        let sortDescriptor = NSSortDescriptor(key: "createdOn", ascending: false)
        
        request.sortDescriptors = [sortDescriptor]
        
        return request
    }
    
    class func fetchOldest() -> NSFetchRequest<Conversion> {
        let request = Conversion.fetchRequest() as NSFetchRequest<Conversion>
        let sortDescriptor = NSSortDescriptor(key: "createdOn", ascending: true)
        let fetchLimit = 1
        
        request.sortDescriptors = [sortDescriptor]
        request.fetchLimit = fetchLimit
        
        return request
    }
}
