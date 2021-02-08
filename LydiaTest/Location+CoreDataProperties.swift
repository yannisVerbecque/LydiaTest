//
//  Location+CoreDataProperties.swift
//  LydiaTest
//
//  Created by Yannis VERBECQUE on 08/02/2021.
//
//

import Foundation
import CoreData


extension Location {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Location> {
        return NSFetchRequest<Location>(entityName: "Location")
    }

    @NSManaged public var city: String
    @NSManaged public var country: String
    @NSManaged public var postcode: String
    @NSManaged public var state: String
    @NSManaged public var contact: Contact
    @NSManaged public var coordinates: Coordinate
    @NSManaged public var street: Street
    @NSManaged public var timezone: Timezone

}

extension Location : Identifiable {

}
