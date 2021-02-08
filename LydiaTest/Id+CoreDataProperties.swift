//
//  Id+CoreDataProperties.swift
//  LydiaTest
//
//  Created by Yannis VERBECQUE on 08/02/2021.
//
//

import Foundation
import CoreData


extension Id {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Id> {
        return NSFetchRequest<Id>(entityName: "Id")
    }

    @NSManaged public var name: String
    @NSManaged public var value: String?
    @NSManaged public var contact: Contact?

}

extension Id : Identifiable {

}
