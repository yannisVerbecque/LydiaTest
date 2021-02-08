//
//  Info+CoreDataProperties.swift
//  LydiaTest
//
//  Created by Yannis VERBECQUE on 08/02/2021.
//
//

import Foundation
import CoreData


extension Info {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Info> {
        return NSFetchRequest<Info>(entityName: "Info")
    }

    @NSManaged public var page: Int16
    @NSManaged public var results: Int16
    @NSManaged public var seed: String
    @NSManaged public var version: String
    @NSManaged public var contactRequest: ContactRequest?

}

extension Info : Identifiable {

}
