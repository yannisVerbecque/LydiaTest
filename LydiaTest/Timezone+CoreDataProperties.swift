//
//  Timezone+CoreDataProperties.swift
//  LydiaTest
//
//  Created by Yannis VERBECQUE on 08/02/2021.
//
//

import Foundation
import CoreData


extension Timezone {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Timezone> {
        return NSFetchRequest<Timezone>(entityName: "Timezone")
    }

    @NSManaged public var detail: String
    @NSManaged public var offset: String
    @NSManaged public var location: Location?

}

extension Timezone : Identifiable {

}
