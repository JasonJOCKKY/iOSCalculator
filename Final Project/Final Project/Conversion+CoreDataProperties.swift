//
//  Conversion+CoreDataProperties.swift
//  Final Project
//
//  Created by Tan Jingsong on 7/29/20.
//  Copyright © 2020 Tan Jingsong. All rights reserved.
//
//

import Foundation
import CoreData


extension Conversion {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Conversion> {
        return NSFetchRequest<Conversion>(entityName: "Conversion")
    }

    @NSManaged public var createdOn: Date?
    @NSManaged public var fromUnit: String?
    @NSManaged public var fromValue: Double
    @NSManaged public var toUnit: String?
    @NSManaged public var toValue: Double

}
