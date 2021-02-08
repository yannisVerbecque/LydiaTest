//
//  Street+CoreDataProperties.swift
//  LydiaTest
//
//  Created by Yannis VERBECQUE on 08/02/2021.
//
//

import Foundation
import CoreData


extension Street {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Street> {
        return NSFetchRequest<Street>(entityName: "Street")
    }

    @NSManaged public var name: String
    @NSManaged public var number: Int16
    @NSManaged public var location: Location?

}

extension Street : Identifiable {

}
