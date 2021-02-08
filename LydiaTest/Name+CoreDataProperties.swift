//
//  Name+CoreDataProperties.swift
//  LydiaTest
//
//  Created by Yannis VERBECQUE on 08/02/2021.
//
//

import Foundation
import CoreData


extension Name {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Name> {
        return NSFetchRequest<Name>(entityName: "Name")
    }

    @NSManaged public var first: String
    @NSManaged public var last: String
    @NSManaged public var title: String
    @NSManaged public var contact: Contact?

}

extension Name : Identifiable {

}
